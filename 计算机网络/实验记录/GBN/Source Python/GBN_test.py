import socket
import time
import json
import sys
import threading
from queue import Queue
import os
import random

with open("setting.json", 'r') as f:
    param = json.load(f)
data_size = param["data_size"]
error_rate = param["error_rate"]
lost_rate = param["lost_rate"]
SW_size = param["SW_size"]
init_seq_no = param["init_seq_no"]
time_out = param["time_out"] / 1000

# 下面的代码为将 socket 绑定到端口上
######################################################################

flag = int(sys.argv[1])

if flag == 1:
    port = 12345
    to_port = 10000
else:
    port = 10000
    to_port = 12345

server_socket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
host_name = socket.gethostname()
host_name = socket.gethostbyname(host_name)
address = (host_name, port)
server_socket.bind(address)
server_socket.settimeout(120)  # 设置监听最长时间为 20 s
if not os.path.exists(str(address)):
    os.makedirs(str(address))

to_port = (host_name,to_port)

######################################################################




def inc(num):
    return (num + 1) % (SW_size + 1)


def between(a, b, c):
    if ((a <= b) and (b < c)) or ((c < a) and (a <= b)) or ((b < c) and (c < a)):
        return True
    else:
        return False


def from_physical_layer(data):
    file_state = int(data[0])
    seq_num = int(data[1])
    ack_num = int(data[2])
    data_len = int(data[3]) * 256 + int(data[4])
    info = data[5:len(data) - 2]
    return seq_num, ack_num, file_state, info, data_len


def check_data(data):
    data_len = len(data)
    check = int(data[data_len - 1]) + int(data[data_len - 2]) * 256
    data = data[:len(data) - 2]
    if calculateCRC(data) != check:
        return False
    else:
        return True


def calculateCRC(data):
    crc = 0
    for dat in data:
        crc = (crc >> 8) | (crc << 8)
        crc ^= dat
        crc ^= (crc & 0xFF) >> 4
        crc ^= crc << 12
        crc ^= (crc & 0x00FF) << 5
        crc &= 0xFFFF
    return crc


# 发送包的函数
def send_data(frame_num, frame_expected, file_state, info, client_address):
    data = b""
    data += bytes([file_state])
    data += bytes([frame_num])
    data += bytes([(frame_expected + SW_size) % (SW_size + 1)])
    data_len = len(info)
    data += bytes([data_len // 256])
    data += bytes([data_len % 256])
    data += info
    crc = calculateCRC(data)
    data += bytes([crc // 256])
    data += bytes([crc % 256])
    if thread[client_address].lost_cnt != lost_rate:
        thread[client_address].lost_cnt += 1
        if thread[client_address].wrong_cnt != error_rate:
            thread[client_address].wrong_cnt += 1
        else:
            index = random.randint(0, len(data) - 1)
            num = random.randint(0, 255)
            temp = list(data)
            temp[index] = num
            data = b""
            for i in temp:
                data += bytes([i])
            thread[client_address].wrong_cnt = 0
        # print("send:", data)
        server_socket.sendto(data, client_address)
    else:
        thread[client_address].lost_cnt = 0
    thread[client_address].start_timer(frame_num)


# 下面为接收包的函数，通过创建一个线程监听发送到端口的包，然后将包消息发送到对应处理线程的消息队列中
###########################################################################


def recv_data_thread():
    global server_socket,address,port
    while True:
        receive_data, client = server_socket.recvfrom(data_size + 20)

        # print("receive:", receive_data)
        file_state = int(receive_data[0])
        if client not in thread:
            if file_state != 0:
                return
            else:
                thread[client] = host(client)
                thread[client].recv_start_time = time.time()
        elif file_state == 0:
            thread[client].recv_start_time = time.time()

        thread[client].msg.put(("recv_data", receive_data))


recv_thread = threading.Thread(target=recv_data_thread)
recv_thread.setDaemon(True)
recv_thread.start()

###########################################################################

thread = dict()  # 负责保存每一个端口交互的处理线程
del_thread = Queue()  # 负责删除处理线程

# 下面是处理线程，也是 udp 传输的核心部分，对于来自不同端口的包，用不同的处理线程处理
###########################################################################


class host(threading.Thread):
    def __init__(self, host_id):
        threading.Thread.__init__(self)
        self.host_id = host_id  # 线程处理的端口
        self.next_frame_to_send = init_seq_no  # GBN协议中的发送包序号
        self.frame_expected = init_seq_no  # GBN协议中对方接受包的序号
        self.ack_expected = init_seq_no  # GBN协议中接受对方包的序号
        self.recv_file_name = str(host_id) + '_to_' + str(address)  # 保存数据的文件名

        # 将之前运行的数据、日志文件删除
        ##################################################################
        if os.path.exists(self.recv_file_name):
            os.remove(self.recv_file_name)
        if os.path.exists(str(address) + "/" + "recvfrom_" + str(self.host_id)):
            os.remove(str(address) + "/" + "recvfrom_" + str(self.host_id))
        if os.path.exists(str(address) + "/" + "sendto_" + str(self.host_id)):
            os.remove(str(address) + "/" + "sendto_" + str(self.host_id))
        ##################################################################

        self.frame_timer = dict()  # 保存每一个帧计时器线程
        self.buffer = dict()  # 发送缓冲区
        self.buffer_cnt = 0  # 发送缓冲区计数
        # 超时计数，如果超时次数过多，关闭线程
        self.send_file_handle = None  # 发送文件的指针

        # 对于文件发送开始和结束的标记，可以放到后面看
        ##################################################################
        self.is_sending = False
        self.is_send_start = False
        self.send_end_frame = None
        self.is_recving = False
        ##################################################################

        self.msg = Queue()  # 消息队列，用来保存发送、接收、超时消息
        self.time_lock = Queue(1)  # TODO
        self.isDaemon = True  # 守护线程，为了防止主程序中途退出线程不能结束，可以不用管
        self.send_cnt = 0  # 发送序号，用于保存消息日志
        self.recv_cnt = 0  # 接受序号，用于保存消息日志
        self.lost_cnt = 0  # 丢包计数，当丢包到达 lost_rate 的时候就进行丢包处理
        self.wrong_cnt = 2  # 出错计数，当计数到达wrong_rate 的时候随机修改数据
        self.ack = [False for _ in range(SW_size + 1)]  # 判断帧是否受到了 ack ，防止计时器在收到ack后依然发送超时信号
        self.recv_start_time = None
        self.time = None
        self.active_time = time.time()
        self.start()  # 线程启动

    # 发送超时信号
    def send_time_out(self, frame_num):
        self.time_lock.put(0)
        if not self.ack[frame_num]:
            self.msg.put(("time_out", None))
        self.time_lock.get()

    # 设置计时器
    def start_timer(self, frame_num):
        self.stop_timer(frame_num)
        self.ack[frame_num] = False
        self.frame_timer[frame_num] = threading.Timer(time_out, self.send_time_out, (frame_num, ))
        self.frame_timer[frame_num].setDaemon(True)
        self.frame_timer[frame_num].start()

    # 受到 ack 包后，需要将对应的帧的计时器取消
    def stop_timer(self, frame_num):
        if frame_num not in self.frame_timer:
            return
        self.frame_timer[frame_num].cancel()

    # 处理消息队列中的消息,其实大致和书上的代码类似
    def wait_for_event(self):
        msg = self.msg.get()
        self.time_lock.put(0)

        if msg[0] == "recv_data":
            self.active_time = time.time()
            data = msg[1]
            seq_num, ack_num, file_state, info, data_len = from_physical_layer(data)

            # 下面为记录日志部分，可以先不看
            ##################################################################
            status = "OK"
            if seq_num != self.frame_expected:
                status = "NumErr"
            if not check_data(data) or len(info) != data_len:
                status = "DataErr"

            with open(str(address) + "/" + "recvfrom_" + str(self.host_id), "a") as f:
                record = "recv_num = " + str(self.recv_cnt) + ' , '
                record += "recv_exp = " + str(self.frame_expected) + ' , '
                record += "status = " + status + '\n'
                f.writelines(record)
                self.recv_cnt += 1
            ##################################################################

            if seq_num == self.frame_expected and status != "DataErr":
                if file_state == 0:
                    self.is_recving = True
                elif file_state == 2:
                    self.time = time.time() - self.recv_start_time

                    self.is_recving = False
                    print("receive end!")

                self.frame_expected = inc(self.frame_expected)
                if info:
                    with open(self.recv_file_name, "ab") as f:
                        f.write(info)

                while between(self.ack_expected, ack_num, self.next_frame_to_send):
                    self.stop_timer(self.ack_expected)
                    self.ack[self.ack_expected] = True
                    self.buffer_cnt = self.buffer_cnt - 1
                    self.buffer.pop(self.ack_expected)
                    self.ack_expected = inc(self.ack_expected)

                if self.send_end_frame != None and self.ack_expected == self.send_end_frame:
                    self.is_sending = False

        elif msg[0] == "send_data":
            send_num = msg[1]

            self.active_time = time.time()
            # 下面为记录日志部分，可以先不看
            ##################################################################
            with open(str(address) + "/" + "sendto_" + str(self.host_id), "a") as f:
                record = "send_num = " + str(self.send_cnt) + ' , '
                record += "send_ack = " + str(self.ack_expected) + ' , '
                record += "status = " + "NEW\n"
                f.writelines(record)
                self.send_cnt += 1
            ##################################################################

            # 这里发送部分和书上不一样，因为构造包的过程已经在另一个函数中处理了，所以这里只是单纯地发送包
            send_data(send_num, self.frame_expected, self.buffer[send_num][0], self.buffer[send_num][1], self.host_id)

        elif msg[0] == "time_out":
            frame_index = self.ack_expected
            for _ in range(self.buffer_cnt):

                # 下面为记录日志部分，可以先不看
                ##################################################################
                with open(str(address) + "/" + "sendto_" + str(self.host_id), "a") as f:
                    record = "send_num = " + str(self.send_cnt) + ' , '
                    record += "send_ack = " + str(self.ack_expected) + ' , '
                    record += "status = " + "TO\n"
                    f.writelines(record)
                    self.send_cnt += 1
                ##################################################################

                send_data(frame_index, self.frame_expected, self.buffer[frame_index][0], self.buffer[frame_index][1], self.host_id)
                frame_index = inc(frame_index)
            self.next_frame_to_send = frame_index

        self.time_lock.get()

    # 创建发送包
    def create_send_data(self):
        if (self.buffer_cnt < SW_size):

            # 如果需要向对放端口发送文件，就进行捎带确认
            buffer_index = self.next_frame_to_send
            if self.send_file_handle != None:
                if not self.is_send_start:
                    # 如果是刚刚开始发送文件，需要发送一个特殊的包告诉对方开始传送数据
                    self.is_send_start = True
                    self.buffer[buffer_index] = (0, b'')
                    self.msg.put(("send_data", buffer_index))
                else:
                    data = self.send_file_handle.read(data_size)
                    if data:
                        # 传送数据
                        self.buffer[buffer_index] = (1, data)
                        self.msg.put(("send_data", buffer_index))
                    else:
                        # 如果读到文件末尾，需要发送一个特殊的包告诉对方传送结束
                        self.send_file_handle.close()
                        self.send_file_handle = None
                        self.send_end_frame = buffer_index

                        self.buffer[buffer_index] = (2, b'')
                        self.msg.put(("send_data", buffer_index))

            # 如果没有向对方端口发送文件的需求，就只发送 ack 确认包
            else:
                self.buffer[buffer_index] = (1, b'')
                self.msg.put(("send_data", buffer_index))

            self.next_frame_to_send = inc(self.next_frame_to_send)
            self.buffer_cnt += 1

    # 可以不用管
    def __del__(self):
        if self.send_file_handle != None:
            self.send_file_handle.close()
        for x in self.frame_timer.values():
            x.cancel()

    # 线程运行的主函数，通过消息队列阻塞，每次循环通过创建一个发送包保持端口的活性
    def run(self):
        while True:
            self.wait_for_event()
            self.create_send_data()
            if (not self.is_recving and not self.is_sending) or (time.time() - self.active_time > 4):
                break
        with open(str(address) + "/" + "recvfrom_" + str(self.host_id), "a") as f:
            f.writelines(str(self.time))
        print(str(self.host_id) + " thread end!")
        del_thread.put(self.host_id)

time.sleep(0.4)
if to_port not in thread:
    thread[to_port] = host(to_port)
thread[to_port].is_sending = True
thread[to_port].is_send_start = False
thread[to_port].send_end_frame = None
thread[to_port].send_file_handle = open("send_file.txt", "rb")
thread[to_port].msg.put(("sending_file"))



###########################################################################

# 运行的主线程，通过删除队列阻塞
###########################################################################

while True:
    try:
        thread_id = del_thread.get()
        temp = thread.pop(thread_id)
        del temp
    except socket.timeout:
        print("Time out")

###########################################################################
