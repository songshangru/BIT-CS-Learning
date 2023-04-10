import os
import torch


# 指定读取文件夹和文件格式批量读取featnames并统一featnames
def read_featuresNames(path, suffix):
    files = os.listdir(path)
    result = []
    for file in files:
        pos = path + "\\" + file
        if os.path.splitext(file)[1] != suffix:
            continue
        f = open(pos, 'r')
        f_data = f.readlines()
        for row in f_data:
            tmp_list = row.split(' ')
            str_fea = tmp_list[1] + tmp_list[2] + tmp_list[3]
            result.append(str_fea)
    return list(set(result))


# 一共4039个用户88234条边，每个用户有1406个特征维度
# nodes = []
# for i in range(0, 4039):
#     nodes.append(i)
# 读取边
def read_edges(path, suffix):
    files = os.listdir(path)
    result = []
    for file in files:
        pos = path + "\\" + file
        if os.path.splitext(file)[1] != suffix:
            continue
        f = open(pos, 'r')
        f_data = f.readlines()
        for row in f_data:
            tmp_list = row.split(' ')
            result.append((int(tmp_list[0]), int(tmp_list[1])))
            result.append((int(tmp_list[1]), int(tmp_list[0])))
    return list(set(result))


def getNodefeas(feas):
    nodes_fea = torch.zeros([4039, 1406], dtype=torch.float32)
    circles_list = [0, 107, 348, 414, 686, 698, 1684, 1912, 3437, 3980]
    for ego in circles_list:
        path1 = './facebook/' + str(ego) + '.featnames'
        f1 = open(path1, 'r')
        fea_list = []
        fea_list.clear()
        f_data1 = f1.readlines()
        for row in f_data1:
            tmp_list = row.split(' ')
            y = feas.index(tmp_list[1] + tmp_list[2] + tmp_list[3])
            fea_list.append(y)

        path2 = './facebook/' + str(ego) + '.egofeat'
        f2 = open(path2, 'r')
        f_data2 = f2.readlines()
        for row in f_data2:
            tmp_list = row.split(' ')
            for i in range(0, len(tmp_list)):
                nodes_fea[ego][fea_list[i]] = int(tmp_list[i])

        path3 = './facebook/' + str(ego) + '.feat'
        f3 = open(path3, 'r')
        f_data3 = f3.readlines()
        for row in f_data3:
            tmp_list = row.split(' ')
            x = int(tmp_list[0])
            for i in range(1, len(tmp_list)):
                nodes_fea[x][fea_list[i - 1]] = int(tmp_list[i])
    return nodes_fea
