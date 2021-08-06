# -*- coding: utf-8 -*-
"""
Created on Sat May  9 21:43:38 2020

@author: 94824
"""
import torch
import torch.nn.functional as F
import matplotlib.pyplot as plt
from torch.utils.data.dataset import Dataset
from torch.utils.data.dataloader import DataLoader
#参数设置:size，one-hot向量大小，max_sample训练集样本数，batch
size=50
epochs=10
alpha=0.0003
sep = '/'
file_list="list.txt"
file_train="../data/train.txt"
file_verify="../data/verify.txt"
file_test="../data/test.txt"
file_vector="../data/ctb.50d.vec"
use_gpu=torch.cuda.is_available()


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
    
class Net(torch.nn.Module):
    def __init__(self):
        super().__init__()
        self.lstm=torch.nn.LSTM(
            input_size=50,
            hidden_size=100,
            num_layers=1,
            #dropout=0.3,
            batch_first=True,
            bidirectional=True,
        )
        self.word_embeds=torch.nn.Embedding(len(dist),size)
        self.word_embeds.weight = torch.nn.Parameter(torch.FloatTensor(dist))
        self.linear=torch.nn.Linear(100*2,3)
    def forward(self,x):
        x=self.word_embeds(x)
        out,_=self.lstm(x)
        out=self.linear(out)
        return out.squeeze(0)
model=Net()
if use_gpu:
    model=model.cuda()

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
        if use_gpu:
            x=x.cuda()
        out=model.forward(x).argmax(dim=1)
        out=out.cpu()
        targ=targ+y.detach().numpy().tolist()
        pred=pred+out.detach().numpy().tolist()
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

loss_func=torch.nn.CrossEntropyLoss()
optimize=torch.optim.Adam(model.parameters(), lr=alpha)
if use_gpu:
    loss_func=loss_func.cuda()

list_F1=[]
list_loss=[]


for epoch in range(epochs):
    for batchs,(train_x,train_y) in enumerate(loader_train):
        train_y=train_y.squeeze(0)
        if use_gpu:
            train_x=train_x.cuda()
            train_y=train_y.cuda()
        #预测结果
        out = model.forward(train_x)
        #计算loss
        loss = loss_func(out, train_y.long())
        # 梯度清零
        optimize.zero_grad()
        # 反向传播
        loss.backward()
        # 更新参数
        optimize.step()
        if batchs%5000==0:
            print(loss.item())
    #计算验证集的F1
    F1=cal_F1_measure(loader_verify)
    print("epoch:"+str(epoch)+" verify F1:"+str(F1))
    #若出现过拟合则终止迭代
    if len(list_F1) and F1<list_F1[-1]:
        list_F1.append(F1)
        break
    list_F1.append(F1)
F1=cal_F1_measure(loader_test)
print("test F1:"+str(F1))

#画图，并生成日志文件
plt.plot(list_F1)
fl=open(file_list,"w",encoding='UTF-8')
for i in range(len(list_F1)):
    fl.write("epoch:"+str(i)+" verify F1:"+str(list_F1[i])+"\n")
fl.write("test F1:"+str(F1))
fl.close()