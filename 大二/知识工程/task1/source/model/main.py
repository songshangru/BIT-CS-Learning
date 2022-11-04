# -*- coding: utf-8 -*-
"""
Created on Sat May  9 21:43:38 2020

@author: 94824
"""
import torch
import math
#参数设置:size，one-hot向量大小，max_sample训练集样本数，batch
size=500
max_sample=732289
batch=128
epochs=10
alpha=0.01
file_theta="theta_MBGD.txt"
file_list="list.txt"
file_train="../data/train.txt"
file_verify="../data/verify.txt"


#根据需要选择一个随机值作为theta初值，或读入theta文件存储的历史值
#theta=torch.randn(1,size*3,requires_grad=False)

ft=open(file_theta,encoding='UTF-8')
theta=torch.zeros(1,size*3,requires_grad=False)
text=ft.read().split()
cnt=0
for word in text:
    i=float(word)
    theta[0,cnt]=i
    cnt+=1
ft.close()

x_label=torch.LongTensor(max_sample)
y_data=torch.zeros(max_sample,requires_grad=True)

def sigmoid(X):
    return 1.0/(1+math.exp(-X))

def cal_F1_feature(fin):
    sep = '/'
    f=open(fin,encoding='UTF-8')
    text=f.read().split()
    TP=FP=FN=TN=0
    word_pre=word_now=word_nxt=size-1
    length=len(text)
    for i in range(length):
        word=text[i]
        word1=word.split(sep,1)[0]
        word2=word.split(sep,1)[1]
        y_true=int(word2)
        if i==0:
            word_now=int(word1)
            word_nxt=int(text[i+1].split(sep,1)[0])
        if i>0 and i<length-1:
            word_pre=word_now
            word_now=word_nxt
            word_nxt=int(text[i+1].split(sep,1)[0])
        if i==length-1:
            word_pre=word_now
            word_now=word_nxt
            word_nxt=size-1
        x_data=torch.zeros(1,size*3)
        x_data[0,word_pre]=x_data[0,size+word_now]=x_data[0,size*2+word_nxt]=1
        temp=theta.mm(x_data.t())
        out=float(temp[0,0])
        del x_data
        del temp
        if out>=0:
            y_predict=1
        else:
            y_predict=0
        if y_predict==1 and y_true==1:
            TP+=1
        elif y_predict==1 and y_true==0:
            FP+=1
        elif y_predict==0 and y_true==1:
            FN+=1
        else:
            TN+=1
    f.close()
    P=TP/(TP+FP)
    R=TP/(TP+FN)
    print("P:"+str(P)+" R:"+str(R))
    return 2*P*R/(P+R)

print("read train")
f1=open(file_train,encoding='UTF-8')
sep = '/'
cnt=0
text=f1.read()
for word in text.split():
    word1=word.split(sep,1)[0]
    word2=word.split(sep,1)[1]
    y_data[cnt]=int(word2)
    x_label[cnt]=int(word1)
    cnt+=1
f1.close()

for epoch in range(epochs):
    print("begin iteration")
    #小批量梯度下降
    l=r=1
    while l<cnt-1:
        r=min(l+batch,cnt-1)
        grad=torch.zeros(1,size*3)
        for i in range(l,r):
            x_data=torch.zeros(1,size*3)
            x_data[0,x_label[i-1]]=x_data[0,size+x_label[i]]=x_data[0,size*2+x_label[i+1]]=1
            temp=theta.mm(x_data.t())
            grad=torch.add(grad,float(alpha*(y_data[i]-sigmoid(temp[0,0])))*x_data)
            del x_data
            del temp
        theta=torch.add(theta,grad)
        del grad
        l+=batch
    print(epoch)
    print(theta)
    #更新theta最新值
    ft=open(file_theta,'w',encoding='UTF-8')
    for i in range(size*3):
        temp=float(theta[0,i])
        ft.write(str(temp)+'\n')
    ft.close()
    #计算测试集F1，将F1和对应theta值写入历史文件list
    F1=cal_F1_feature(file_verify)
    print(F1)
    fl=open(file_list,'a+',encoding='UTF-8')
    fl.write(str(F1)+" ")
    for i in range(size*3):
        temp=float(theta[0,i])
        fl.write(str(temp)+" ")
    fl.write("\n")
    fl.close()
    