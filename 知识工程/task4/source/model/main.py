# -*- coding: utf-8 -*-
"""
Created on Sat May  9 21:43:38 2020

@author: 94824
"""
import torch
import torch.nn as nn
import sys
import matplotlib.pyplot as plt
from torch.utils.data.dataset import Dataset
from torch.utils.data.dataloader import DataLoader
#参数设置:size，one-hot向量大小，max_sample训练集样本数，batch
size=50
epochs=20
alpha=0.001
sep = '/'
file_list="list.txt"
file_train="../data/train.txt"
file_verify="../data/verify.txt"
file_test="../data/test.txt"
file_vector="../data/ctb.50d.vec"

use_gpu=torch.cuda.is_available()
device = torch.device("cuda:0" if torch.cuda.is_available() else "cpu")
torch.set_default_tensor_type('torch.cuda.FloatTensor')

'''
根据词向量文件建立词典
word_to_id将词映射为序号，dist根据词序号存储词向量
'''
word_to_id={}
dist=[]
cnt=0
fd=open(file_vector,encoding='UTF-8')
while True:
    text=fd.readline()
    if not text:
        break
    text=text.split()
    word_to_id[text[0]]=cnt
    dist.append([])
    for i in range(1,len(text)):
        dist[cnt].append(float(text[i]))
    cnt+=1
    
class custom_Dataset(Dataset):
    """
    自定义数据集
    参数列表:
        data:存储每个文本段用例的序列标签二元组的列表
        cnt:data长度
    """
    def __init__(self, text_path):
        super(Dataset, self).__init__()
        self.data = []
        f1=open(text_path,encoding='UTF-8')
        cnt=0
        while True:
            text=f1.readline()
            if not text:
                break
            senten=[]
            labels=[]
            for word in text.split():
                word1=word.split(sep,1)[0]
                word2=word.split(sep,1)[1]
                if word1 in word_to_id:
                    l=word_to_id[word1]
                else:
                    l=word_to_id["-unknown-"]
                senten.append(l)
                labels.append(int(word2))
            if len(senten):
                self.data.append([senten,labels])
                cnt+=1
        f1.close()
        self.cnt=cnt
    
    def __len__(self):
        return len(self.data)

    def __getitem__(self, item):
        vec=torch.tensor(self.data[item][0])
        labels=torch.tensor(self.data[item][1])
        sample=(vec,labels)
        return sample

    

def argmax(vec):
    '''
    输入为二维tensor张量，
    返回行向量最大值的索引
    '''
    _, idx = torch.max(vec, 1)
    return idx.item()
 
def log_sum_exp(vec):
    '''
    输入为二维tensor张量，
    返回log_sum_exp的值
    结果等同于torch.log(torch.sum(torch.exp(vec)))
    但在Exp内先减去最大值，可以防止计算溢出
    奇妙的技巧
    '''
    max_score = vec[0, argmax(vec)]
    max_score_broadcast = max_score.view(1, -1).expand(1, vec.size()[1])
    return max_score + torch.log(torch.sum(torch.exp(vec - max_score_broadcast)))

  
class BiLSTM_CRF(nn.Module):
 
    def __init__(self):
        super(BiLSTM_CRF, self).__init__()
        self.embedding_dim = 50
        self.hidden_dim = 100
        self.vocab_size = len(dist)
        self.tagset_size = 5
        self.word_embeds = nn.Embedding(self.vocab_size, self.embedding_dim)
        self.lstm = nn.LSTM(self.embedding_dim, self.hidden_dim // 2, num_layers=1, bidirectional=True)
        self.hidden2tag = nn.Linear(self.hidden_dim, self.tagset_size)
        '''
        转移矩阵，大小为5*5， i\j表示从j转移到i的分数。
        转移矩阵由训练的得来，随机初始化。
        约束条件，不可有任何tag转移到start，也不可从stop转移，故将相应的行与列分数设置为-10000
        '''
        self.transitions = nn.Parameter(torch.randn(self.tagset_size, self.tagset_size))
        self.transitions.data[3, :] = -10000 
        self.transitions.data[:, 4] = -10000  
        
        self.hidden = self.init_hidden()
 
    def init_hidden(self):
        #隐层初始化函数
        return (torch.randn(2, 1, self.hidden_dim // 2),
                torch.randn(2, 1, self.hidden_dim // 2))
    
    def neg_log_likelihood(self, sentence, tags):
        '''
        损失函数，分为三个部分
        第一部分为根据输入的sentence获取lstm层输出特征
        第二部分使用前向算法获得的所有可能路径分数的log_sum_exp值
        第三部分获取该序列的分数
        二三部分结果相减即为loss
        '''
        feats = self._get_lstm_features(sentence)
        forward_score = self._forward_alg(feats)
        gold_score = self._score_sentence(feats, tags)
        return forward_score - gold_score
 
    def _get_lstm_features(self, sentence):
        '''
        双向lstm层，返回lstm特征
        '''
        sentence=sentence.view(-1)
        self.hidden = self.init_hidden()
        embeds = self.word_embeds(sentence).view(len(sentence), 1, -1)
        lstm_out, self.hidden = self.lstm(embeds, self.hidden)
        lstm_out = lstm_out.view(len(sentence), self.hidden_dim)
        lstm_feats = self.hidden2tag(lstm_out)
        return lstm_feats
 
    def _score_sentence(self, feats, tags):
        '''
        给出提供的标签序列的分数
        分数为从标签i转移到标签i+1的分数之和，加上feat对标签i的输出结果（即标签i对应的lstm输出值）之和
        注意需要加上start和stop标签对应的分数
        '''
        score = torch.zeros(1)
        tags = torch.cat([torch.tensor([3], dtype=torch.long), tags])
        for i, feat in enumerate(feats):
            score = score + self.transitions[tags[i + 1], tags[i]] + feat[tags[i + 1]]
        score = score + self.transitions[4, tags[-1]]
        
        return score
    
    def _forward_alg(self, feats):
        '''
        根据随机的转移矩阵，前向传播计算log_sum_exp(score)，使用了dp思想
        设置前向传播向量forward_var，大小为[1,5],除了start外均置为-10000，start位置为0，表示开始网络的传播
        第i步中的forward_var变量保存步骤i-1的前向向量
        '''
        forward_var = torch.full((1, self.tagset_size), -10000.)
        forward_var[0][3] = 0.
        
        for feat in feats:
            #迭代feat特征的每一行，alphas_t为这一行的前向变量
            alphas_t = []
            for next_tag in range(self.tagset_size):
                #next_tag表示下一个标签值，从0遍历至4
                #emit_score表示next_tag对应的feat概率特征值，即feat[next_tag]概率值,需要扩充为1*5
                emit_score = feat[next_tag].view(1, -1).expand(1, self.tagset_size)
                # trans_score表示各标签转移到next_tag的转移分数
                trans_score = self.transitions[next_tag].view(1, -1)
                #从上个标签每一个状态转移到next_tag的分数，为两个分数向量和forward向量之和
                next_tag_var = forward_var + trans_score + emit_score
                # 前向变量列表添加分数的log-sum-exp的值
                alphas_t.append(log_sum_exp(next_tag_var).view(1))
            #将alpha_t赋值给forward_var
            forward_var = torch.cat(alphas_t).view(1, -1)
        #将forward_var与转移到stop的分数相加。
        terminal_var = forward_var + self.transitions[4]
        alpha = log_sum_exp(terminal_var)       
        return alpha
    
    def forward(self, sentence):  
        '''
        用于预测句子，不参与训练，分为两个部分
        第一部分是lstm层获得特征输出feats
        第二部分是将feats输入crf层并进行解码，得到预测值
        '''
        feats = self._get_lstm_features(sentence)
        tag_seq = self._viterbi_decode(feats)
        return tag_seq
    
    def _viterbi_decode(self, feats):
        """
        用于解码，不在训练中使用
        预测序列的得分以获得最优序列路径,前向传播向量forward_var初值设置同_forward_alg
        第i步中的forward_var变量保存步骤i-1的viterbi向量
        backpointers用于存储后向指针，便于最后查找最优序列路径
        """
        backpointers = []
        forward_var = torch.full((1, self.tagset_size), -10000.)
        forward_var[0][3] = 0 
        for feat in feats:
            #bptrs_t为这一步的后向指针
            #viterbivars_t为这一步的viterbi向量
            bptrs_t = []  
            viterbivars_t = []  
            for next_tag in range(self.tagset_size):
                #next_tag_var为上一步viterbi变量加上从标签i转换到next_tag的转移分数
                #bptrs_t添加该next_tag_var最大值的索引
                #本步viterbi变量添加索引对应的最大值
                next_tag_var = forward_var + self.transitions[next_tag]
                best_tag_id = argmax(next_tag_var)
                bptrs_t.append(best_tag_id)
                viterbivars_t.append(next_tag_var[0][best_tag_id].view(1))
            #为viterbi变量加上feat特征值分数，并赋值给forward_var
            #backpointers添加bptrs_t
            forward_var = (torch.cat(viterbivars_t) + feat).view(1, -1)
            backpointers.append(bptrs_t)
 
        # terminal_var为最终转移到stop的转移概率向量，通过其最大值索引可以得到最优路径的终点
        terminal_var = forward_var + self.transitions[4]
        best_tag_id = argmax(terminal_var)
 
        #利用建立好的backpointer，从路径最后一个元素开始建立反向路径
        best_path = [best_tag_id]
        for bptrs_t in reversed(backpointers):
            best_tag_id = bptrs_t[best_tag_id]
            best_path.append(best_tag_id)
        
        #弹出start标签并进行完整性检查
        start = best_path.pop()
        assert start == 3
        
        #将反向路径列表做反向操作即可获得正向序列路径
        best_path.reverse()
        return best_path
 

model = BiLSTM_CRF()
model.to(device)
        
def get_set(labels):
    '''
    用于计算F1，返回命名实体集合
    输入:label为列表
    返回:集合,集合元素形式为元组(b,e),
    b为该命名实体起始字符在原集合中的序号，e为结束字符序号
    '''
    flag=0
    reset=set()
    temp=[0,0]
    for i in range(len(labels)):
        if flag==0:
            if int(labels[i])==1:
                flag=1
                temp[0]=i
        else:
            if int(labels[i])==0:
                flag=0
                temp[1]=i-1
                mem=tuple(temp)
                reset.add(mem)
                temp=[0,0]
            elif int(labels[i])==1:
                temp[1]=i-1
                mem=tuple(temp)
                reset.add(mem)
                temp=[i,0]
    return reset

def cal_F1_measure(loader):
    '''
    计算F1的函数，
    输入:loader数据加载器，比如计算验证集F1就输入loader_verify
    返回:F1-measure值
    '''
    pred=[]
    targ=[]
    for x,y in loader:
        y=y.squeeze(0)
        #if use_gpu:
        #    x=x.cuda()
        out=model.forward(x)
        y=y.cpu()
        targ=targ+y.detach().numpy().tolist()
        pred=pred+out
    set_pred=get_set(pred)
    set_targ=get_set(targ)
    set_inter=set_targ&set_pred
    t_pre=len(set_pred)
    t_tar=len(set_targ)
    TP=len(set_inter)
    if TP!=0 and t_pre!=0 and t_tar!=0:
        P=TP/t_pre
        R=TP/t_tar
        F1=2*P*R/(P+R)
    else:
        F1=0
    return F1

data_train = custom_Dataset(file_train)
data_verify = custom_Dataset(file_verify)
data_test = custom_Dataset(file_test)

loader_train = DataLoader(data_train, batch_size=1)
loader_verify = DataLoader(data_verify,batch_size=1)
loader_test = DataLoader(data_test,batch_size=1)

optimize=torch.optim.Adam(model.parameters(), lr=alpha)



list_F1=[]
list_loss=[]
list_F1_test=[]

F1=cal_F1_measure(loader_verify)

for epoch in range(epochs):
    for batchs,(train_x,train_y) in enumerate(loader_train):
        train_y=train_y.squeeze(0)
        #梯度清零
        model.zero_grad()
        #计算loss
        loss = model.neg_log_likelihood(train_x.long(), train_y.long())
        #反向传播
        loss.backward()
        # 更新参数
        optimize.step()
        if batchs%5000==0:
            print(loss.item())
    #计算验证集和测试集的F1
    F1=cal_F1_measure(loader_verify)
    print("epoch:"+str(epoch)+" verify F1:"+str(F1))
    list_F1.append(F1)
    F1=cal_F1_measure(loader_test)
    print("test F1:"+str(F1))
    list_F1_test.append(F1)
    
#画图，并生成日志文件
plt.plot(list_F1)

