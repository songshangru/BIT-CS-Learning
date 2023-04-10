import community.community_louvain
import networkx as nx
import pandas as pd
import numpy as np
import pylab
import matplotlib.pyplot as plt
from networkx.algorithms.community import k_clique_communities
from community import community_louvain
from random import randint

G = nx.Graph()

path = 'facebook_combined.txt'
edge_list = []
node_set = set()
with open(path, 'r') as f:
    for line in f:
        cols = line.strip().split(' ')
        y1 = int(cols[0])
        y2 = int(cols[1])
        node_set.add(y1)
        node_set.add(y2)
        edge = (y1, y2)  # 元组代表一条边
        edge_list.append(edge)

list_1 = []
list_2 = []


for i in range(0, len(edge_list), 500):
    ad_edges = edge_list[i:i+500]
    G.add_edges_from(ad_edges)
    dia = nx.diameter(G)
    list_1.append(i)
    list_1.append(dia)

plt.plot(list_1, list_2)
pylab.show()