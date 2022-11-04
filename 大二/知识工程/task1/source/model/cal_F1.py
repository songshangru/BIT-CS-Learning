# -*- coding: utf-8 -*-
"""
Created on Sat May  9 21:43:38 2020

@author: 94824
"""
import torch
import math
size=5000

def sigmoid(X):
    return 1.0/(1+math.exp(-X))

ft=open("theta_MBGD.txt",encoding='UTF-8')
theta=torch.zeros(1,size*3,requires_grad=False)
text=ft.read().split()
cnt=0
for word in text:
    i=float(word)
    theta[0,cnt]=i
    cnt+=1
ft.close()

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


F1=cal_F1_feature("../data/test.txt")
print(F1)