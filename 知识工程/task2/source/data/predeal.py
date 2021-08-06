# -*- coding: utf-8 -*-
"""
Created on Thu Apr 30 12:09:45 2020

@author: 94824
"""
size=5000
max_sample=732289



def trans(inp,outp):
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
                        y=2
                    else:
                        y=0
                    f_out.write(word1+"/"+str(y)+" ")
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
                    for i in range(len(queue)):
                        mem=queue[i]
                        if i==0 and y==1:
                            f_out.write(mem+"/"+str(2)+" ")
                        else:
                            f_out.write(mem+"/"+str(y)+" ")
                    top=0
                    queue.clear()
    f_in.close()
    f_out.close()



trans("19980101-19980120.txt","train.txt")
trans("19980121-19980125.txt","verify.txt")
trans("19980126-19980131.txt","test.txt")  
