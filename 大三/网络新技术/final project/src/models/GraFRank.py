import torch
import torch.nn as nn
import torch.nn.functional as F
from models.layers import GraFrankConv, CrossModalityAttention


class GraFrank(nn.Module):
    """
    GraFrank Model for Multi-Faceted Friend Ranking with multi-modal node features and pairwise link features.
    (a) Modality-specific neighbor aggregation: modality_convs
    (b) Cross-modality fusion layer: cross_modality_attention
    """

    def __init__(self, in_channels, hidden_channels, edge_channels, num_layers, input_dim_list):
        """
        :param in_channels: total cardinality of node features.
        :param hidden_channels: latent embedding dimensionality.
        :param edge_channels: number of link features.
        :param num_layers: number of message passing layers.
        :param input_dim_list: list containing the cardinality of node features per modality.
        """
        super(GraFrank, self).__init__()
        self.num_layers = num_layers
        self.modality_convs = nn.ModuleList()
        self.edge_channels = edge_channels
        # we assume that the input features are first partitioned and then concatenated across the K modalities.
        self.input_dim_list = input_dim_list

        for inp_dim in self.input_dim_list:
            modality_conv_list = nn.ModuleList()
            for i in range(num_layers):
                in_channels = in_channels if i == 0 else hidden_channels
                modality_conv_list.append(GraFrankConv((inp_dim + edge_channels, inp_dim), hidden_channels))

            self.modality_convs.append(modality_conv_list)

        self.cross_modality_attention = CrossModalityAttention(hidden_channels)

    def forward(self, x, adjs, edge_attrs):
        """ Compute node embeddings by recursive message passing, followed by cross-modality fusion.
        :param x: node features [B', in_channels] where B' is the number of nodes (and neighbors) in the mini-batch.
        :param adjs: list of sampled edge indices per layer (EdgeIndex format in PyTorch Geometric) in the mini-batch.
        :param edge_attrs: [E', edge_channels] where E' is the number of sampled edge indices per layer in the mini-batch.
        :return: node embeddings. [B, hidden_channels] where B is the number of target nodes in the mini-batch.
        """
        result = []
        for k, convs_k in enumerate(self.modality_convs):
            emb_k = None
            for i, ((edge_index, _, size), edge_attr) in enumerate(zip(adjs, edge_attrs)):
                x_target = x[:size[1]]  # Target nodes are always placed first.
                x_list = torch.split(x, split_size_or_sections=self.input_dim_list, dim=-1)  # modality partition
                x_target_list = torch.split(x_target, split_size_or_sections=self.input_dim_list, dim=-1)
                x_k, x_target_k = x_list[k], x_target_list[k]

                emb_k = convs_k[i]((x_k, x_target_k), edge_index, edge_attr=edge_attr)

                if i != self.num_layers - 1:
                    emb_k = emb_k.relu()
                    emb_k = F.dropout(emb_k, p=0.5, training=self.training)

            result.append(emb_k)
        return self.cross_modality_attention(result)

    def full_forward(self, x, edge_index, edge_attr):
        """ Auxiliary function to compute node embeddings for all nodes at once for small graphs.
        :param x: node features [N, in_channels] where N is the total number of nodes in the graph.
        :param edge_index: edge indices [2, E] where E is the total number of edges in the graph.
        :param edge_attr: link features [E, edge_channels] across all edges in the graph.
        :return: node embeddings. [N, hidden_channels] for all nodes in the graph.
        """
        x_list = torch.split(x, split_size_or_sections=self.input_dim_list, dim=-1)  # modality partition
        result = []
        for k, convs_k in enumerate(self.modality_convs):
            x_k = x_list[k]
            emb_k = None
            for i, conv in enumerate(convs_k):
                emb_k = conv(x_k, edge_index, edge_attr=edge_attr)

                if i != self.num_layers - 1:
                    emb_k = emb_k.relu()
                    emb_k = F.dropout(emb_k, p=0.5, training=self.training)

            result.append(emb_k)
        return self.cross_modality_attention(result)