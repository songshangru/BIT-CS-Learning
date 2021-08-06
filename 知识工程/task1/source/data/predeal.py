# -*- coding: utf-8 -*-
"""
Created on Thu Apr 30 12:09:45 2020

@author: 94824
"""
size=5000
max_sample=732289


def get_dist(inp):
    f=open(inp,encoding='UTF-8')
    dist={}
    id=0
    for text in f.read().splitlines():
        if not text:
            break
        dist[text]=id
        id=id+1
    f.close()
    return dist

def trans(inp,outp,dist):
    f_in=open(inp,encoding='UTF-8')
    f_out=open(outp,"w",encoding='UTF-8')
    sep = '/'
    while True:
        text=f_in.readline()
        if not text:
            break
        queue=[]
        top=0
        for word in text.split():
            word1=word.split(sep,1)[0]
            word2=word.split(sep,1)[1]
            if top==0:
                if word.find("[")>=0:
                    top=1
                    queue.append(word1[1:])
                else:
                    if(word2=="nt"):
                        y=1
                    else:
                        y=0
                    if word1 in dist.keys():
                        x=dist[word1]
                    else:
                        x=size-1
                    f_out.write(str(x)+"/"+str(y)+" ")
            else:
                if word.find("]")==-1:
                    queue.append(word1)
                else:
                    queue.append(word1)
                    word3=word2.split("]",1)[1]
                    if word3=="nt":
                        y=1
                    else:
                        y=0
                    for mem in queue:
                        if mem in dist.keys():
                            x=dist[mem]
                        else:
                            x=size-1
                        f_out.write(str(x)+"/"+str(y)+" ")
                    top=0
                    queue.clear()
    f_in.close()
    f_out.close()

dist0=get_dist("../data/dist.txt")
dist1=get_dist("../data/dist1.txt")


trans("19980101-19980120.txt","train.txt",dist0)
trans("19980121-19980125.txt","verify.txt",dist0)
trans("19980126-19980131.txt","test.txt",dist0)  
trans("19980101-19980120.txt","train1.txt",dist1)
trans("19980121-19980125.txt","verify1.txt",dist1)
trans("19980126-19980131.txt","test1.txt",dist1)             
