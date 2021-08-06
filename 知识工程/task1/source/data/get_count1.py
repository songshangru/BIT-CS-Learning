# -*- coding: utf-8 -*-
"""
Created on Thu Apr 30 12:09:45 2020

@author: 94824
"""

from collections import Counter

size=5000

#基于高频机构名的词典选取

f0=open("19980101-19980120.txt",encoding='UTF-8')
fd=open("dist1.txt","w",encoding='UTF-8')

cnt=0
count=Counter()
            
def getcount(inp):
    f_in=open(inp,encoding='UTF-8')
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
                    if (word1 in count) and word2=="nt":
                        count[word1]+=1
                    else:
                        count[word1]=1
            else:
                if word.find("]")==-1:
                    queue.append(word1)
                else:
                    queue.append(word1)
                    word3=word2.split("]",1)[1]
                    if word3=="nt":
                        for mem in queue:
                            if mem in count:
                                count[mem]+=1
                            else:
                                count[mem]=1
                    top=0
                    queue.clear()
    f_in.close()

getcount("19980101-19980120.txt")

id=0
for (k,v) in count.most_common(size):
    fd.write("%s\n"%(k))
    id+=1
print(id)
f0.close()
fd.close()

      