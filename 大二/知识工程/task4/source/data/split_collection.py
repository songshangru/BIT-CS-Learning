# -*- coding: utf-8 -*-
"""
Created on Thu Apr 30 12:09:45 2020

@author: 94824
"""

f0=open("renming.txt",encoding='UTF-8')
f1=open("19980101-19980120.txt","w",encoding='UTF-8')
f2=open("19980121-19980125.txt","w",encoding='UTF-8')
f3=open("19980126-19980131.txt","w",encoding='UTF-8')
flag1=0
flag2=0
flag3=0
while True:
    text=f0.readline()
    if text.startswith("19980121"):
        flag1=1
    elif text.startswith("19980126"):
        flag2=1
    elif not text:
        break
    if flag1==0:
        f1.write(text)
    elif flag2==0:
        f2.write(text)
    else:
        f3.write(text)
f0.close()
f1.close()
f2.close()
f3.close()
      