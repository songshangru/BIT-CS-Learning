# -*- coding: utf-8 -*-
"""
Created on Tue May 12 20:29:42 2020

@author: 94824
"""

import matplotlib.pyplot as plt

F1=[]
fl=open("list1.txt",encoding='UTF-8')
while True:
    text=fl.readline()
    if not text:
        break
    F1.append(float(text.split()[0]))

print(F1[-1])
plt.plot(F1)