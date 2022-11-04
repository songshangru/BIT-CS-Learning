#include<iostream>
#include<fstream>
#include<thread>
#include<map>
#include<mutex>
#include<condition_variable>
#include<queue>
#include<windows.h>
#include <ctime>
#include"Physical.cpp"
#include"Utils.cpp"

using namespace std;

const string config_file = R"(config\params.txt)";

typedef pair<string, time_t> str_time;

class PiQueue
{
private:
    mutex mtx;
    condition_variable cv;
    queue<str_time> q;

public:
    PiQueue()
    {
        while (!q.empty())
        {
            q.pop();
        }
    }

    inline void push_pi(const str_time &s)
    {
        unique_lock<mutex> lock(mtx);
        q.push(s);
        cv.notify_one();
    }

    inline str_time get_pi()
    {
        unique_lock<mutex> lock(mtx);
        cv.wait(lock, [this]
        { return !q.empty(); });
        auto s = q.front();
        q.pop();
        return s;
    }

    inline void clear()
    {
        unique_lock<mutex> lock(mtx);
        while (!q.empty())
        {
            q.pop();
        }
    }
};

class RoutTable
{
private:
    string local;
    float unreachdis;    // 不可达距离
    // rout 路由表: dest -> (neighbor, dis)
    map<string, pair<string, float> > rout;
    // history 历史路由表: (dest, neighbor) -> dis
    map<pair<string, string>, float> history;

    mutex mtx;

public:
    RoutTable(const string &id)
    {
        local = id;
        rout.clear();
        history.clear();
    }

    void set_unreachdis(float dis)
    {
        unreachdis = dis;
    }

    /* 将某个目标路径设为不可达 */
    void set_unreachable(const string &dest)
    {
        unique_lock<mutex> lock(mtx);
        auto item = rout[dest];
        history[make_pair(dest, item.first)] = unreachdis;
        update_rout();
    }

    /* 根据路由项更新历史路由表：常用于初始化 */
    void update_history(const string &dest, const string &neighbor, float dis)
    {
        unique_lock<mutex> lock(mtx);
        if (dis < 0)
            dis = unreachdis;
        history[make_pair(dest, neighbor)] = dis;
    }

    /* 根据发送的路由表，更新本机历史路由表 */
    void update_history(const string &sender, const vector<pair<string, float> > &recv_rout)
    {
        unique_lock<mutex> lock(mtx);

        // 判断是否为新连接上的邻居
        pair<string, string> direct_key(sender, sender);
        if (!history.count(direct_key))
        {
            for (const auto &item : recv_rout)
            {
                if (item.first == local)
                {
                    history[direct_key] = item.second;
                }
            }
        }

        // 获取 local 直接到达 sender 的距离
        float direct_dis = history[direct_key];

        // 更新历史路由
        for (auto &item : recv_rout)
        {             /*                         dest     sender */
            pair<string, string> update_key(item.first, sender);
            if (item.first != local)    // 跳过目标是 local 的路由项
            {
                history[update_key] = min(direct_dis + item.second, unreachdis);
            }
        }
    }

    /* 根据历史路由表，更新路由表 */
    void update_rout()
    {
        unique_lock<mutex> lock(mtx);
        map<string, pair<string, float> > new_rout;
        // 根据当前的 history 更新路由表
        for (auto &item : history)
        {
            if (!new_rout.count(item.first.first))
            {
                new_rout[item.first.first] = make_pair(item.first.second, item.second);
            }
            else if (item.second < new_rout[item.first.first].second)
            {
                new_rout[item.first.first].first = item.first.second;   // neighbor
                new_rout[item.first.first].second = item.second;    // distance
            }
        }
        rout = new_rout;
    }

    /* 将路由表序列化为字符串 */
    string to_string()
    {
        unique_lock<mutex> lock(mtx);
        string res = "#" + local;
        for (auto &item : rout)
        {
            res += "#" + item.first + " " + std::to_string(item.second.second);
        }
        res += "#";
        return res; // 格式：#id#dst1 dis1#dst2 dis2#...#
    }

    /* 将路由表序列化为字符串 */
    string log(int num)
    {
        unique_lock<mutex> lock(mtx);
        string res = "## Sent. SourceNode = " + local + "; SequenceNumber = " + std::to_string(num) + "\n";
        for (auto &item : rout)
        {
            res += "DestNode = " + item.first;
            res += ";\tDistance = " + std::to_string(item.second.second);
            res += ";\tNeighbor = " + item.second.first + "\n";
        }
        return res;
    }

    /* 打印路由表 */
    void debug()
    {
        unique_lock<mutex> lock(mtx);
        cout << "--------------------------------------------" << endl;
        cout << "Router Id: " << local << endl;

        for (auto &item : history)
        {
            // dst dis nei
            cout << "DestNode: " << item.first.first;
            cout << "\tDistance: " << item.second;
            cout << "\tNeighbor: " << item.first.second;
            cout << endl;
        }

        cout << "---------history------------" << endl;

        for (auto &item : rout)
        {
            // dst dis nei
            cout << "DestNode: " << item.first;
            cout << "\tDistance: " << item.second.second;
            cout << "\tNeighbor: " << item.second.first;
            cout << endl;
        }
        cout << "--------------------------------------------" << endl;
    }
};

class Simulator
{
private:
    int state;           // 0暂停，1运行，-1结束
    string id;           // 本路由名字
    int frequency;       // 每几秒给相邻路由发一次信息
    float unreachdis;    // 不可达距离
    int maxtime;         // 最大等待时间
    string init_file;
    string log_file;

    Physical *p;
    PiQueue Q;        //保存接收到内容的队列

    // 路由表
    RoutTable rout;

    // 判断接受超时
    fd_set rset;
    map<string, time_t> timeout;
    // timeout map 读写互斥锁
    mutex timeout_mtx;

    // run 函数中存活的线程数 recv、send、timeout、process
    int alive_thread_num;
    mutex alive_num_mtx;
    condition_variable alive_num_cv;

    // 用于故障时使路由暂停的锁
    mutex mtx;
    condition_variable cv;

    // 从字符串反序列化为路由表；最后一个元素代表sender，之前代表路由表
    static vector<pair<string, float> > str2table(const string &s, string &sender)
    {
        vector<pair<string, float> > res;
        int l = 0, r = 0;
        while (true)
        {
            r = s.find('#', l + 1);
            string tmp = s.substr(l + 1, r - l - 1);
            vector<string> info = split(tmp, set<char>{' '});
            if (info.size() == 1)
            {
                sender = info[0];
            }
            else
            {
                res.emplace_back(info[0], atof(info[1].data()));
            }
            l = r;
            if (r == s.size() - 1)
                break;
        }
        return res;
    }

public:
    Simulator(string id, int port, string &init_file) : rout(id)
    {
        state = 1;
        this->alive_thread_num = 0;
        this->id = move(id);
        this->init_file = init_file;
        this->log_file = init_file;
        this->log_file.replace(init_file.find("txt"), 3, "log");

        char in[500];
        // 解析配置文件
        ifstream config(config_file.data());
        while (config.getline(in, 500))
        {
            auto x = split(in, set<char>({' ', ':', '\t'}));
            if (x[0] == "Frequency")
            {
                frequency = atoi(x[1].data());
            }
            else if (x[0] == "Unreachable")
            {
                unreachdis = atof(x[1].data());
            }
            else if (x[0] == "MaxValidTime")
            {
                maxtime = atoi(x[1].data());
            }
        }

        p = new Physical(port);
        rout.set_unreachdis(unreachdis);

        // 初始化路由表
        ifstream f(init_file.data());
        while (f.getline(in, 1000))
        {
            auto x = split(in, set<char>({' ', ':', '\t'}));
            if (x.size() < 3)
            {
                cout << "Initial file content error" << endl;
                continue;
            }
            // 添加到 udp 发送目标
            p->add_nei(x[0], atoi(x[2].data()));
            // 记录每个邻居的超时时间
            timeout_mtx.lock();
            timeout[x[0]] = time(nullptr) + maxtime / 1000;
            timeout_mtx.unlock();
            // 添加到路由表
            rout.update_history(x[0], x[0], atof(x[1].data()));
        }
        rout.update_rout();
    }

    void run()
    {
        // 输出初始邻接表
        debug();
        // 接收线程
        thread([this]
               {
                   alive_num_mtx.lock();
                   this->alive_thread_num++;
                   alive_num_mtx.unlock();

                   int fd = p->get_sockid();
                   FD_ZERO(&rset);
                   FD_SET(fd, &rset);
                   struct timeval tv{};
                   //毫秒转为秒
                   int sec = frequency / 1000;
                   int msec = frequency % 1000;
                   tv.tv_sec = sec;
                   tv.tv_usec = msec * 1000;

                   int flag;
                   while (true)
                   {
                       // cout << "recv thread start" << endl;
                       while (state != 1)
                       {
                           unique_lock<mutex> lock(mtx);
                           if (state == -1)          // state=-1：结束循环
                               break;
                           if (state == 0)
                               Q.clear();
                           cv.wait(lock);
                       }
                       if (state == -1)          // state=-1：结束循环
                           break;
                       // 非阻塞接收
                       flag = select(fd + 1, &rset, nullptr, nullptr, nullptr);
                       if (flag > 0)
                       {
                           string s = p->recv();
                           time_t pi_time = time(nullptr);
                           if (state != 0)
                               Q.push_pi((str_time) {s, pi_time});
                       }
                   }

                   cout << "Receive thread stop." << endl;

                   alive_num_mtx.lock();
                   this->alive_thread_num--;
                   alive_num_mtx.unlock();
                   alive_num_cv.notify_all();
               }).detach();
        // 定时发送线程
        thread([this]
               {
                   alive_num_mtx.lock();
                   this->alive_thread_num++;
                   alive_num_mtx.unlock();

                   int seq_num = 0;
                   ofstream log;
                   log.open(this->log_file.data(), ios_base::out);
                   if (!log.is_open())
                   {
                       cout << "error open " << this->log_file << endl;
                   }
                   while (true)
                   {
                       // cout << "send thread start" << endl;
                       while (state != 1)
                       {
                           unique_lock<mutex> lock(mtx);
                           if (state == -1)          // state=-1：结束循环
                               break;
                           cv.wait(lock);
                       }
                       if (state == -1)             // state=-1：结束循环
                           break;
                       string ss = rout.to_string();
                       p->send_to_nei(ss);
                       log << rout.log(seq_num) << endl;
                       seq_num++;
                       // cout << "sent success" << endl;

                       Sleep(frequency);
                   }
                   log.close();
                   cout << "Send thread stop." << endl;

                   alive_num_mtx.lock();
                   this->alive_thread_num--;
                   alive_num_mtx.unlock();
                   alive_num_cv.notify_all();
               }).detach();
        // 定时检查超时连接
        thread([this]
               {
                   alive_num_mtx.lock();
                   this->alive_thread_num++;
                   alive_num_mtx.unlock();

                   bool all_dead;

                   while (true)
                   {
                       // cout << "timeout thread start" << endl;
                       while (state != 1)
                       {
                           unique_lock<mutex> lock(mtx);
                           if (state == -1)          // state=-1：结束循环
                               break;
                           cv.wait(lock);
                       }
                       if (state == -1)          // state=-1：结束循环
                           break;
                       time_t now = time(nullptr);
                       // 遍历 timeout 检查超时
                       timeout_mtx.lock();
                       auto it = timeout.begin();
                       auto itEnd = timeout.end();
                       while (it != itEnd)
                       {
                           if (now > it->second)
                           {
                               cout << it->first << "->" << id << " timeout." << endl;
                               p->disconnect(it->first);
                               // 设为不可达
                               rout.set_unreachable(it->first);
                           }
                           it++;
                       }
                       timeout_mtx.unlock();
                       Sleep(maxtime);
                   }
                   cout << "Timeout thread stop." << endl;

                   alive_num_mtx.lock();
                   this->alive_thread_num--;
                   alive_num_mtx.unlock();
                   alive_num_cv.notify_all();
               }).detach();
        // 处理接收到的路由信息
        thread([this]
               {
                   alive_num_mtx.lock();
                   this->alive_thread_num++;
                   alive_num_mtx.unlock();

                   while (true)
                   {
                       // cout << "process thread start" << endl;
                       while (state != 1)
                       {
                           unique_lock<mutex> lock(mtx);
                           if (state == -1)          // state=-1：结束循环
                               break;
                           if (state == 0)
                               Q.clear();
                           cv.wait(lock);
                       }
                       if (state == -1)          // state=-1：结束循环
                           break;

                       /* ********************************* Bug *****************************************
                        *      desc: 发出结束命令k后，其他线程结束，此时队列如果为空，则该处get_pi导致线程阻塞不能退出，
                        *      fix: stop函数向消息队列Q中push一个特殊消息，结束process线程
                        * ******************************************************************************/

                       // 从队列中获取报文
                       str_time task = Q.get_pi();

                       // 检查是否为终止报文
                       if (task.first == "over")
                           break;

                       // 报文反序列化
                       string sender;
                       vector<pair<string, float> > recv_table = str2table(task.first, sender);

                       // cout << "recv " << sender << endl;

                       // 更新邻居的超时时间
                       timeout_mtx.lock();
                       timeout[sender] = task.second + maxtime / 1000;
                       timeout_mtx.unlock();

                       // 确保连接状态
                       p->connect(sender);

                       // 更新路由表
                       rout.update_history(sender, recv_table);
                       rout.update_rout();
                   }

                   cout << "Process thread stop." << endl;

                   alive_num_mtx.lock();
                   this->alive_thread_num--;
                   alive_num_mtx.unlock();
                   alive_num_cv.notify_all();
               }).join();
    }

    //输出邻接表
    void debug()
    {
        rout.debug();
    }

    //路由故障
    void fault()
    {
        state = 0;
        Q.clear();
        cout << "The router paused." << endl;
    }

    //结束路由
    void stop()
    {
        state = -1;
        cv.notify_all();
        // 向消息队列Q中添加over消息，终止Process线程
        str_time over("over", 0);
        Q.push_pi(over);

        unique_lock<mutex> lock(alive_num_mtx);
        alive_num_cv.wait(lock, [this]
        { return this->alive_thread_num == 0; });
    }

    //重启
    void restart()
    {
        if (state == 1)
        {
            cout << "The router is running." << endl;
            return;
        }
        // 重新初始化
        char in[500];
        ifstream f(init_file.data());
        while (f.getline(in, 1000))
        {
            auto x = split(in, set<char>({' ', ':', '\t'}));
            if (x.size() < 3)
            {
                cout << "Initial file content error" << endl;
                continue;
            }
            p->connect(x[0]);
            // 记录每个邻居的超时时间
            timeout_mtx.lock();
            timeout[x[0]] = time(nullptr) + maxtime / 1000;
            timeout_mtx.unlock();
            // 添加到路由表
            rout.update_history(x[0], x[0], atof(x[1].data()));
        }
        rout.update_rout();
        cout << "The router reboot." << endl;
        // 清空消息队列
        Q.clear();
        state = 1;
        cv.notify_all();
    }
};
