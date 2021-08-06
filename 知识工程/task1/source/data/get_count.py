# -*- coding: utf-8 -*-
"""
Created on Thu Apr 30 12:09:45 2020

@author: 94824
"""

from collections import Counter

size=5000

#基于停用词表的常用字典选取

f0=open("19980101-19980120.txt",encoding='UTF-8')
fd=open("dist.txt","w",encoding='UTF-8')
fuu=open("stopusing.txt",encoding='UTF-8')

dist_unuse=fuu.read().split()

cnt=0
count=Counter()

sep = '/'
while True:
    text=f0.readline()
    if not text:
        break
    for word in text.split():
        word1=word.split(sep,1)[0]
        if word1[0]=='[':
            word1=word1[1:]
        if word1 in dist_unuse:
            continue
        if word1 in count:
            count[word1]+=1
        else:
            count[word1]=1
id=0
for (k,v) in count.most_common(size):
    fd.write("%s\n"%(k))
    id+=1
print(id)
f0.close()
fd.close()

      