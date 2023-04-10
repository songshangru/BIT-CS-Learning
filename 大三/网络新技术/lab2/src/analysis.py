import community.community_louvain
import networkx as nx
import pandas as pd
import numpy as np
import pylab
import matplotlib.pyplot as plt
from networkx.algorithms.community import k_clique_communities
from community import community_louvain
from random import randint

# 从数据文件夹中加载数据
fb = pd.read_csv(
    "data/facebook_combined.txt.gz",
    compression="gzip",
    sep=" ",
    names=["start_node", "end_node"],
)

G = nx.from_pandas_edgelist(fb, "start_node", "end_node")


plot_options = {"node_size": 10, "with_labels": False, "width": 0.15}

# 使用spring_layout函数 考虑节点和边来计算节点位置
pos = nx.spring_layout(G, iterations=15, seed=1721)
fig, ax = plt.subplots(figsize=(15, 9))
ax.axis("off")
nx.draw_networkx(G, pos=pos, ax=ax, **plot_options)
pylab.show()


print("Clustering Coefficient:")
print(nx.average_clustering(G))


print("Average path length:")
print(nx.average_shortest_path_length(G))  # average_path_length




plt.figure(figsize=(15, 8))
plt.hist(nx.clustering(G).values(), bins=50)
plt.title("Clustering Coefficient Histogram ", fontdict={"size": 35}, loc="center")
plt.xlabel("Clustering Coefficient", fontdict={"size": 20})
plt.ylabel("Counts", fontdict={"size": 20})
pylab.show()

# 平均度
d = dict(nx.degree(G))
print(d)
print("平均度为：", sum(d.values()) / len(G.nodes))

# 度分布
print(nx.degree_histogram(G))  # 返回所有位于区间[0, dmax]的度值的频数列表
# 度分布直方图

x = list(range(max(d.values()) + 1))
# y = [i/len(G.nodes) for i in nx.degree_histogram(G)]
y = [i / sum(nx.degree_histogram(G)) for i in nx.degree_histogram(G)]
print(x)
print(y)

plt.bar(x, y, width=0.5, color="blue")
plt.xlabel("$k$")
plt.ylabel("$p_k$")
plt.xlim([0, 350])
pylab.show()


print("Assortativity:")
print(nx.degree_assortativity_coefficient(G))


# network community

# first compute the best partition

partition = community_louvain.best_partition(G)
# drawing
size = float(len(set(partition.values())))
pos = nx.spring_layout(G)
count = 0.0
for com in set(partition.values()):
    count = count + 1.0
    list_nodes = [nodes for nodes in partition.keys() if partition[nodes] == com]
    nx.draw_networkx_nodes(
        G, pos, list_nodes, node_size=20, node_color=str(count / size)
    )
nx.draw_networkx_edges(G, pos, alpha=0.5)
plt.show()
pylab.show()

part = community.community_louvain.best_partition(G)
values = [part.get(node) for node in G.nodes()]
nx.draw_spring(
    G, cmap=plt.get_cmap("jet"), node_color=values, node_size=30, with_labels=False
)
pylab.show()


Gn = nx.Graph()  # 创建无向图
