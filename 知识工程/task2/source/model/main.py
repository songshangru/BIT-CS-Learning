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
from torch.utils.data.sampler import SubsetRandomSampler
#参数设置:size，one-hot向量大小，max_sample训练集样本数，batch
size=50
max_sample=732289
batch=128
epochs=10
alpha=0.01
sep = '/'
file_theta="theta_MBGD.txt"
file_list="list.txt"
file_train="../data/train.txt"
file_verify="../data/verify.txt"
file_test="../data/test.txt"
file_vector="../data/ctb.50d.vec"

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
        data:存储数据标签二元组的列表
        cnt:data长度
    每个样本自动拼接前中后三个词的词向量形成新样本存入data内
    """
    def __init__(self, text_path):
        super(Dataset, self).__init__()
        self.data = []
        self.cnt=0
        f1=open(text_path,encoding='UTF-8')
        cnt=0
        text=f1.read()
        for word in text.split():
            word1=word.split(sep,1)[0]
            word2=word.split(sep,1)[1]
            if word1 in word_to_id:
                l=word_to_id[word1]
            else:
                l=0
            self.data.append((l,int(word2)))
            cnt+=1
        f1.close() 
        self.cnt=cnt

    def __len__(self):
        return len(self.data)

    def __getitem__(self, item):
        vec = torch.zeros(size*3, 1)
        x_now=dist[self.data[item][0]]
        if item>=1 and item<self.cnt-1:
            x_pre=dist[self.data[item-1][0]]
            x_nxt=dist[self.data[item+1][0]]
        elif item==0:
            x_pre=dist[0]
            x_nxt=dist[self.data[item+1][0]]
        else:
            x_pre=dist[self.data[item-1][0]]
            x_nxt=dist[0]
        for k in range(size):
            vec[k]=x_pre[k]
            vec[k+size]=x_now[k]
            vec[k+size*2]=x_nxt[k]
        sample = (vec, self.data[item][1])
        return sample
    

    
class Softmax(torch.nn.Module):
    '''
    softmax模型，包含正向传播函数
    '''
    def __init__(self):
        super().__init__()
        self.linear = torch.nn.Linear(3*size,3)
    def forward(self,x):
        output=self.linear(x)
        output=F.softmax(output,dim=1)
        output=torch.log(output)
        return output

def get_set(label,cnt):
    '''
    用于计算F1，返回命名实体集合
    输入:label为[cnt,1]形状的张量
    返回:集合,集合元素形式为元组(b,e),
    b为该命名实体起始字符在原集合中的序号，e为结束字符序号
    '''
    flag=0
    reset=set()
    temp=[0,0]
    for i in range(cnt):
        if flag==0:
            if int(label[i,0])==2:
                flag=1
                temp[0]=i
        else:
            if int(label[i,0])==0:
                flag=0
                temp[1]=i-1
                mem=tuple(temp)
                reset.add(mem)
                temp=[0,0]
            elif int(label[i,0])==2:
                temp[1]=i-1
                mem=tuple(temp)
                reset.add(mem)
                temp=[0,0]
    return reset

def cal_F1_measure(x,cnt,set_true):
    '''
    计算F1的函数，
    输入:x为形状[cnt,1]形状的张量,即待遇测的样本集,set_true为真实值的命名实体集合
    返回:F1-measure值
    '''
    TP=0
    out = softmax_model.forward(x)
    pred = out.argmax(dim=1)
    pred=pred.view(-1,1)
    set_pred=get_set(pred,cnt)
    set_inter=set_true&set_pred
    t_pre=len(set_pred)
    t_tru=len(set_true)
    TP=len(set_inter)
    if TP!=0 and t_pre!=0 and t_tru!=0:
        P=TP/t_pre
        R=TP/t_tru
        F1=2*P*R/(P+R)
    else:
        F1=0
    return F1
    #P=TP/(len(set_true))
    #R=TP/(len(set_pred))
    #print("P:"+str(P)+" R:"+str(R))
    #return 2*P*R/(P+R)

data_train = custom_Dataset(file_train)
data_verify = custom_Dataset(file_verify)
data_test = custom_Dataset(file_test)

train_sampler = SubsetRandomSampler(range(len(data_train)))

loader_train = DataLoader(data_train, batch_size=batch, sampler=train_sampler)
loader_verify = DataLoader(data_verify,batch_size=data_verify.cnt)
loader_test = DataLoader(data_test,batch_size=data_test.cnt)

softmax_model = Softmax()

loss_func = torch.nn.NLLLoss()

optimize=torch.optim.Adam(softmax_model.parameters(), lr=alpha)

'''
获得验证集的命名实体集,减少此后运算量
'''
for verify_x,verify_y in loader_verify:
    verify_x = verify_x.view(-1, 3*size)
    verify_y = verify_y.view(-1, 1)
    set_true_verify=get_set(verify_y,data_verify.cnt)

for test_x,test_y in loader_test:
    test_x = test_x.view(-1, 3*size)
    test_y = test_y.view(-1, 1)
    set_true_test=get_set(test_y,data_test.cnt)

list_F1=[]
list_loss=[]

for epoch in range(epochs):
    for batchs, (train_x, train_y) in enumerate(loader_train):
        train_x = train_x.view(-1, 3*size)
        train_y = train_y.view(-1)
        #预测结果
        out = softmax_model.forward(train_x)
        #计算loss
        loss = loss_func(out, train_y)
        # 梯度清零
        optimize.zero_grad()
        # 反向传播
        loss.backward()
        # 更新参数
        optimize.step()
        list_loss.append(loss.item())
    #计算验证集的F1
    F1=cal_F1_measure(verify_x,data_verify.cnt,set_true_verify)
    list_F1.append(F1)
    print(F1)

plt.plot(list_loss[0:100])

print(cal_F1_measure(test_x,data_test.cnt,set_true_test))


    