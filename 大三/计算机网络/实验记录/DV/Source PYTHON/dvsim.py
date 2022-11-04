'''
The default IP address is 127.0.0.1
'''

import socket
import sys
import threading
import time
import six
import ctypes
import inspect
from time import sleep

'''启动时，从系统配置文件中读取'''
Frequency = 1000 * 0.001  # 定期时间间隔 毫秒
MaxValidTime = 30000 * 0.001  # 最大等待时间 毫秒
Unreachable = 20.0  # 不可达距离或代价

LogPath="Log2/"

'''  dvsim a 51000 a.txt   ;dvsim 路由器名称 端口号 输入文件 '''
'''
P	;暂停此路由器
S	;恢复此路由器
K	;人为终止运行
'''


class Node:
    def __init__(self, id, port_num, filename):
        self.id = id
        self.port = int(port_num)
        self.state = True;        # 标志节点在运行状态
        self.createtime = time.time()  # 节点创建时间
        self.SendNum = 0  # 发送包的Sequence Number
        self.RecNum = 0   # 接收包的Sequence Number
        # dv使用的路由表 节点id :[dis, nexthop]
        self.RouterTable = {}
        # 邻居节点信息表 节点id: [UDP端口号，运行状态，上次收到此邻居节点信息的时间,距离dis]
        self.Neighbors = {}
        '''
        b 2.0 52001 	;邻居名称 距离 端口号
        d 2.0 52003 
        f 2.0 52005
        '''
        with open(sys.argv[3], "r") as f:
            lines = f.read().splitlines()
        # f = open(sys.argv[3])
        # f = open("x.txt")
        for line in lines:
            items = line.split(" ")
            items[1] = float(items[1])   # 距离
            items[2] = int(items[2])     # 端口号
            # 路由表 初始化信息
            self.RouterTable[items[0]] = [items[1], items[0]]
            # 邻居节点信息表 初始化信息
            self.Neighbors[items[0]] = [items[2], True, self.createtime, items[1]]
        # self.RouterTable[self.id] = [0, self.id]  # 把自己加入路由表

        # 清空日志文件
        file = open(LogPath + self.id + ".txt", "w").close()

        '''启动线程'''
        # 控制节点通信的线程
        self.node_thread = threading.Thread(target = self.communication)
        self.node_thread.start()
        # 控制键盘事件的线程
        self.keyboard_thread = threading.Thread(target = self.keyboard)
        self.keyboard_thread.start()

    # 判断节点是否存活
    def check_state(self):
        current_time = time.time()
        # 邻居节点信息表 节点id: [UDP端口号，运行状态，上次收到此邻居节点信息的时间,距离dis]
        for i in self.Neighbors.keys():
            if (current_time-self.Neighbors[i][2])>MaxValidTime:
                # 长时间没有接收到邻居节点发来的消息 判断邻居节点故障 修改其状态
                self.Neighbors[i][1]=False

    # 控制节点通信
    def communication(self):
        # mod = int(time.time())%Frequency
        last_time = -1
        self.socket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        self.socket.bind(("127.0.0.1", self.port))
        self.socket.settimeout(0.5)  # 针对会阻塞的recvfrom()设置timeout异常
        while True:
            current_time = int(time.time())
            # 更新当前邻居节点运行状态
            self.check_state()
            # 此结点运行正常、按频率到了需要传信息的时候、且保证在同一秒内不重复操作
            if self.state == True and (current_time % Frequency) == 0 and current_time != last_time:
                self.send()
                # 发送消息后，更新last_time（记录上次发信息时间）
                last_time=current_time
            # 节点正常运行，接收信息
            if self.state:
                self.receive()


    # 接受键盘改变节点状态的控制信息
    def keyboard(self):
        '''
        P	;暂停此路由器
        S	;恢复此路由器
        K	;人为终止运行
        '''
        while True:
            op = input()
            if op == "P" and self.state == True:
                stop_thread(self.node_thread) # 停止此结点的通信线程
                self.state=False
                print("Successfully Paused")
            elif op == "S" and self.state == False:
                # 重新新建一个用于此结点通信的线程 清除此结点暂停期间缓冲区收到的信息
                self.node_thread = threading.Thread(target= self.communication)
                self.node_thread.start()
                self.state=True
                print("Successfully Recover")
            elif op == "K":
                print("Successfully Exit")
                stop_thread(self.node_thread)
                stop_thread(self.keyboard_thread)
                sys.exit(0)
            else:
                print("Wrong Command")


    # 节点发送信息
    def send(self):
        '''
        # dv使用的路由表 节点id :[dis, nexthop]
        # 邻居节点信息表 节点id: [UDP端口号，运行状态，上次收到此邻居节点信息的时间,距离dis]
        '''
        # 发送的信息字符串
        msg = ''
        # 用于输出到日志文件中
        log = "## Sent. Source Node = {}; Sequence Number = {}\n".format(self.id, self.SendNum)
        print(log,end='')
        for i in self.RouterTable.keys():
            dest_id = i
            dis = self.RouterTable[dest_id][0]
            next_hop = self.RouterTable[dest_id][1]
            '''
            信息格式：
            源节点 目标节点 距离 next_hop
            每行中间用空格隔开 行与行之间用$隔开
            '''
            line = self.id + " " + dest_id + " " + str(dis) +" " +next_hop
            if msg != '':
                msg +="$"
            msg+=line

        if type(msg) == six.text_type:
            msg = msg.encode('UTF-8')

        # 把信息发送给所有邻居
        for n in self.Neighbors.keys():
            self.socket.sendto(msg,("127.0.0.1", self.Neighbors[n][0]))
            # 将发送的消息输出到日志文件中
            addlog = "DestNode = {}; Distance = {}; Neighbor = {}\n".format(n, self.RouterTable[n][0], self.RouterTable[n][1])
            print(addlog,end="")
            log += addlog
        print("\n")
        self.SendNum+=1

        # 写进日志
        with open(LogPath + self.id + ".txt","a") as f:
            f.write(log)
            f.write("\n")


    # 节点接收信息
    def receive(self):
        start_time = time.time()
        while True:
            try:
                msg, address = self.socket.recvfrom(1024)
                break
            except:
                now_time = time.time()
                if now_time - start_time > 0.5:
                    return
        receive_time = time.time()  # 记录收到信息的时间
        '''
            信息格式：
            源节点 目标节点 距离 next_hop
            每行中间用空格隔开 行与行之间用$隔开
        '''
        # 处理接收到的msg
        lines=msg.decode('UTF-8')
        lines = lines.split("$")
        neighbor_id = lines[0][0]            # 源节点id / 邻居节点id
        dis_to_neighbor = self.Neighbors[neighbor_id][3]
        log = "## Received. Source Node = {}; Sequence Number = {}\n".format(neighbor_id, self.RecNum)
        print(log,end='')
        self.RecNum += 1
        for line in lines:
            items=line.split(" ")
            # print(items)
            #neighbor_id = items[0]           # 源节点id / 邻居节点id
            destination_id = items[1]        # 目标节点id
            dis = float(items[2])            # 距离
            next_hop = items[3]              # 下一跳
            addlog="DestNode = {}; Distance = {}; Neighbor = {}\n".format(destination_id, dis, next_hop)
            print(addlog,end='')
            log+=addlog

            '''Distance Vector Routing'''
            try:
                self.RouterTable[destination_id]
                # 目的节点在路由表中
                my_next_hop = self.RouterTable[destination_id][1] # destination_id是Destnode
                if my_next_hop == neighbor_id: # 如果下一跳是邻居，直接更新
                    self.RouterTable[destination_id][0] = dis + dis_to_neighbor
                elif dis + dis_to_neighbor < self.RouterTable[destination_id][0]: # 否则比较距离，距离小的话更新
                    self.RouterTable[destination_id][0] = dis + dis_to_neighbor
                    self.RouterTable[destination_id][1] = neighbor_id
                if destination_id in self.Neighbors.keys():
                    if self.Neighbors[destination_id][3] < self.RouterTable[destination_id][0]:
                        self.RouterTable[destination_id][0] = self.Neighbors[destination_id][3]
                        self.RouterTable[destination_id][1] = self.id
            except:
                if destination_id != self.id :
                    self.RouterTable[destination_id] = [(dis + dis_to_neighbor),neighbor_id]
        print("")

        # 将接收信息写进日志
        with open(LogPath + self.id + ".txt", "a") as f:
            f.write(log)
            f.write("\n")

        # 打印最新路由表
        print("Latest Router Table")
        print(self.RouterTable)
        print("")

        # 修改邻居节点的状态
        self.Neighbors[neighbor_id][1]=True  # 收到消息 确认邻居节点运行正常
        self.Neighbors[neighbor_id][2]=receive_time




def _async_raise(tid, exctype):
    """raises the exception, performs cleanup if needed"""
    tid = ctypes.c_long(tid)
    if not inspect.isclass(exctype):
        exctype = type(exctype)
    res = ctypes.pythonapi.PyThreadState_SetAsyncExc(tid, ctypes.py_object(exctype))
    if res == 0:
        raise ValueError("invalid thread id")
    elif res != 1:
        # """if it returns a number greater than one, you're in trouble,
        # and you should call it again with exc=NULL to revert the effect"""
        ctypes.pythonapi.PyThreadState_SetAsyncExc(tid, None)
        raise SystemError("PyThreadState_SetAsyncExc failed")


def stop_thread(thread):
    _async_raise(thread.ident, SystemExit)


if __name__ == "__main__":
    f = open("config.TXT")
    for line in f.readlines():
        thing = line.split(" ")
        if thing[0] == "\"Frequency\":":
            Frequency = int(thing[1])*0.001
        elif thing[0] == "\"Unreachable\":":
            Unreachable = float(thing[1])
        elif thing[0] == "\"MaxValidTime\":":
            MaxValidTime = int(thing[1])*0.001
    # node = Node('x', 52004, "x.txt")
    f.close()
    if len(sys.argv) == 4:
        node = Node (sys.argv[1], sys.argv[2], sys.argv[3])
    else:
        print("输入格式错误，正确格式为：dvsim 节点id 节点UDP端口号 节点初始化文件名")
        sys.exit(1)
