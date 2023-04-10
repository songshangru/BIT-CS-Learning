from typing import Optional
from typing import Union, Tuple
import torch

from torch import Tensor
import torch.nn as nn
from torch_geometric.nn.conv import MessagePassing
from torch_geometric.typing import OptPairTensor, Adj, Size, OptTensor
from torch_geometric.utils import softmax
from torch_sparse import SparseTensor
import torch.nn.functional as F


class GraFrankConv(MessagePassing):
    """
    Modality-specific neighbor aggregation in GraFrank implemented by stacking message-passing layers that are
    parameterized by friendship attentions over individual node features and pairwise link features.
    """

    def __init__(self, in_channels: Union[int, Tuple[int, int]],
                 out_channels: int, normalize: bool = False,
                 bias: bool = True, **kwargs):  # yapf: disable
        kwargs.setdefault('aggr', 'add')
        super(GraFrankConv, self).__init__(**kwargs)

        self.in_channels = in_channels
        self.out_channels = out_channels
        self.normalize = normalize
        self.negative_slope = 0.2
        if isinstance(in_channels, int):
            in_channels = (in_channels, in_channels)

        self.self_linear = nn.Linear(in_channels[1], out_channels, bias=bias)
        self.message_linear = nn.Linear(in_channels[0], out_channels, bias=bias)

        self.attn = nn.Linear(out_channels, 1, bias=bias)
        self.attn_i = nn.Linear(out_channels, 1, bias=bias)

        self.lin_l = nn.Linear(out_channels, out_channels, bias=bias)
        self.lin_r = nn.Linear(out_channels, out_channels, bias=False)

        self.reset_parameters()
        self.dropout = 0

    def reset_parameters(self):
        self.lin_l.reset_parameters()
        self.lin_r.reset_parameters()

    def forward(self, x: Union[Tensor, OptPairTensor], edge_index: Adj, edge_attr: OptTensor = None,
                size: Size = None) -> Tensor:
        if isinstance(x, Tensor):
            x: OptPairTensor = (x, x)

        x_l, x_r = x[0], x[1]
        self_emb = self.self_linear(x_r)
        alpha_i = self.attn_i(self_emb)
        out = self.propagate(edge_index, x=(x_l, x_r), alpha=alpha_i, edge_attr=edge_attr, size=size)
        out = self.lin_l(out) + self.lin_r(self_emb)  # dense layer.

        if self.normalize:
            out = F.normalize(out, p=2., dim=-1)

        return out

    def message(self, x_j: Tensor, alpha_i: Tensor, edge_attr: Tensor, index: Tensor, ptr: OptTensor,
                size_i: Optional[int]) -> Tensor:
        message = torch.cat([x_j, edge_attr], dim=-1)
        out = self.message_linear(message)
        alpha = self.attn(out) + alpha_i
        alpha = F.leaky_relu(alpha, self.negative_slope)
        alpha = softmax(alpha, index, ptr, size_i)
        self._alpha = alpha
        alpha = F.dropout(alpha, p=self.dropout, training=self.training)
        out = out * alpha
        return out

    def message_and_aggregate(self, adj_t: SparseTensor) -> Tensor:
        pass

    def __repr__(self):
        return '{}({}, {})'.format(self.__class__.__name__, self.in_channels,
                                   self.out_channels)


class CrossModalityAttention(nn.Module):
    """
    Cross-Modality Fusion in GraFrank implemented by an attention mechanism across the K modalities.
    """

    def __init__(self, hidden_channels):
        super(CrossModalityAttention, self).__init__()
        self.hidden_channels = hidden_channels
        self.multi_linear = nn.Linear(hidden_channels, hidden_channels, bias=True)
        self.multi_attn = nn.Sequential(self.multi_linear, nn.Tanh(), nn.Linear(hidden_channels, 1, bias=True))

    def forward(self, modality_x_list):
        """
        :param modality_x_list: list of modality-specific node embeddings.
        :return: final node embedding after fusion.
        """
        result = torch.cat([x.relu().unsqueeze(-2) for x in modality_x_list], -2)  # [...., K, hidden_channels]
        wts = torch.softmax(self.multi_attn(result).squeeze(-1), dim=-1)
        return torch.sum(wts.unsqueeze(-1) * self.multi_linear(result), dim=-2)

    def __repr__(self):
        return '{}({}, {})'.format(self.__class__.__name__, self.hidden_channels,
                                   self.hidden_channels)
