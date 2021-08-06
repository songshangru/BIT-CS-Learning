#include<mutex>
#include<condition_variable>
#include<queue>
#include<random>
#include<set>
#include<map>
#include<time.h>
#include"Timer.cpp"
#include"Physical.cpp"
#include"Frame.cpp"
#include"Record.cpp"
using namespace std;

const string save_path = "E:\\aaa\\"; //收到文件的保存地址

typedef pair<Frame,int> pp;
typedef pair<string,pp> pi;

class TaskQueue{
public:
    TaskQueue()
	{
        while(q.size()) q.pop();
    }

    inline void push_one(pi f)
	{
        unique_lock<mutex> lock(mtx);
        q.push(f);
        cv.notify_one();
    }

    inline pi get_one()
	{
        unique_lock<mutex> lock(mtx);
//        while(q.empty())
//		{
//            cv.wait(lock, [this] {return !q.empty()});
//        }
        cv.wait(lock, [this] {return !q.empty()});
        auto f = q.front();
        q.pop();
        return f;
    }
	inline int size(){
		return q.size();
	}
private:
    mutex mtx;
    condition_variable cv;
    queue<pi> q;
};

vector<string> split(string s,set<char> cs)
{
    vector<string> res;
    string x;
    for (auto c:s)
	{
        if (cs.count(c))
		{
            if (x.length())
			{
                res.push_back(x);
                x = "";
            }
        }
		else
		{
            x.push_back(c);
        }
    }
    if (x.size()) res.push_back(x);
    return res;
}


string to_string(Frame &f)
{
    f.h.len = f.info.length();
    string a,b,c,d;
	a.resize(sizeof(uint16_t));
	b.resize(sizeof(uint8_t));
	c.resize(sizeof(uint8_t));
	d.resize(sizeof(uint8_t));
	*(uint16_t*)a.data() = f.h.len;
	*(uint8_t*)b.data() = f.h.type;
	*(uint8_t*)c.data() = f.h.seq;
	*(uint8_t*)d.data() = f.h.ack;
    string s = a+b+c+d;
    return s + f.info;
}

//将接收到的string，转为frame
Frame to_frame(const string &s)
{
    Frame f;
    string a = s.substr(0,2);
    string b = s.substr(2,1);
    string c = s.substr(3,1);
    string d = s.substr(4,1);
    f.h.len = *(uint16_t*)a.data();
    f.h.type = *(uint8_t*)b.data();
    f.h.seq = *(uint8_t*)c.data();
    f.h.ack = *(uint8_t*)d.data();
    f.info = s.substr(5, f.h.len);
    f.h.len-=2;
    return f;
}

class GBN
{
private:
	int port = 0;
	int dst_port = 0;
    int error_rate = -1;
    int loss_rate = -1;
    Physical *p = NULL;
    Record* record_in = NULL;
	Record* record_out = NULL;
	string dir_name;
	
	FILE* fp = NULL;
    
	//与接收有关 
	int frame_expected;
	
	//与发送有关
    int next_frame_to_send;
    int ack_expected;
    bool ack[25];
    int send_end_frame=-1;

	int datasize = 1024;
    int wait_time = 100;//超时时间 
	int win_size = 10;//窗口大小 
	int init_seq_no = 0;
	
	int loss_cnt = 0;
	int error_cnt = 0;
	
	
	int buff_cnt=0;
	map<int,Frame> buffer;
	map<int,Timer*> frame_timer;
	
	clock_t active_time,recv_start_time;
	double time;
	
	string recv_file_name="Tmp_file";
	bool is_recving=false;
	bool is_sending=false;
	bool is_send_start=false;
    
    mutex mtx;
    bool is_ok = true;
	bool ttt = true;
	//接受一个string并直接转化为frame
    Frame recv_frame()
	{
        string s = p->recv();
		Frame frame = to_frame(s);
        return frame;
    }
	
//	double time_diff(clock_t t1,clock_t t2){
//		return (double)(t2-t1)/CLK_TCK;
//	}
	
	int inc(int num){
		return (num+1)%(win_size+1);
	}
	
	bool between(int a,int b,int c)
	{
		if(((a<=b)&&(b<c))||((c<a)&&(a<=b))||((b<c)&&(c<a))) return true;
		return false;
	}
	
	//生成需要发送的内容
	void create_send_data()
	{
		if(buff_cnt<win_size){
			int buffer_index = next_frame_to_send;
			if(fp!=NULL){
				//文件头 
				if(!is_send_start){
					is_send_start = true;
					Frame f;
					f.h.type = 0;
					f.h.seq = buffer_index;
					buffer[buffer_index] = f;
					
					pp tmpp;
					tmpp.second = buffer_index;
					msg.push_one((pi){"send_data",tmpp});
				}
				else{
					char buf[datasize+10];
					int siz=fread(buf,1,datasize,fp);
					//文件内容 
					if(siz!=0)
					{
						Frame f;
						f.h.type = 1;
						f.h.seq = buffer_index;
						f.h.len = siz;
						string tmp(buf,siz);
						f.info = tmp;
						buffer[buffer_index] = f;
						
						pp tmpp;
						tmpp.second = buffer_index;
						msg.push_one((pi){"send_data",tmpp});
					}
					//文件尾 
					else{
						fclose(fp);
						fp = NULL;
						send_end_frame = buffer_index;
						
						Frame f;
						f.h.type=2;
						f.h.seq = buffer_index;
						buffer[buffer_index] = f;
						
						pp tmpp;
						tmpp.second = buffer_index;
						msg.push_one((pi){"send_data",tmpp});
					}
				}
			}
			else
			{
				Frame f;
				f.h.type = 1;
				f.h.seq = buffer_index;
				buffer[buffer_index] = f;
				
				pp tmpp;
				tmpp.second = buffer_index;
				msg.push_one((pi){"send_data",tmpp});
			}
			next_frame_to_send = inc(next_frame_to_send);
			buff_cnt++;
		}
	}
		
	void stop_timer(int frame_num)
	{
		if(frame_timer.count(frame_num)==0) return ;
		frame_timer[frame_num]->stop();
		free(frame_timer[frame_num]);
		auto x = frame_timer.find(frame_num);
		frame_timer.erase(x);
	}

	void start_timer(int frame_num)
	{
		stop_timer(frame_num);
		ack[frame_num]=false;
		
		Timer* t = new Timer;
		frame_timer[frame_num] = t;
		t->setTimeout([this,frame_num]{
			unique_lock<mutex> lock(mtx);
			if(this->ack[frame_num]==false){
				if(this->is_ok)
				{
					is_ok=false;
					pp tmp;
					this->msg.push_one((pi){"time_out",tmp});
				}
			}
		},wait_time);
	}
	
	void send_frame(int frame_num)
	{		
		Frame tmp = buffer[frame_num];
		tmp.h.ack = (frame_expected+win_size)%(win_size+1);
		
		tmp.gen();
		p->send_to_port(to_string(tmp),dst_port);
		
		start_timer(frame_num);
		
//		if(loss_cnt!=loss_rate)
//		{
//			loss_cnt++;
//			if(error_cnt!=error_rate)
//			{
//				error_cnt++;
//			}
//			else{
//				f.info[0]+='1';
//				error_cnt = 0;
//			}
//			p->send_to_port(to_string(f),dst_port);
//		}
//		else{
//			loss_cnt = 0;
//		}
		
	}
	
	//处理消息队列的内容 
	void wait_for_event(){
//		if(msg.size()==0)
//		{
////			Sleep(300);
//			return;
//		}
		pi info = msg.get_one();
		unique_lock<mutex> lock(mtx);
		if(info.first == "recv_data"){
			ttt = true;
			pp x = info.second;
			Frame f = x.first;
			
			string status = "OK";
			if(f.verify()){
				if(f.h.seq!=frame_expected){
					status = "NumErr";
				}
			}
			else{
				status = "DataErr";
				printf("DaraErr\n");
			}
			record_in->receive_record(frame_expected,f.h.seq,status);
			//TODO:写记录
			if(status!="DataErr"&&f.h.seq==frame_expected){
//				//文件头 
				if(f.h.type==0) is_recving = true;
				//文件尾
				else if(f.h.type==2){
//					time = time_diff(recv_start_time,clock());
					is_recving = false;
					printf("receive end!");
				}
				frame_expected = inc(frame_expected);

				if(f.h.len!=0){
					string x = recv_file_name+to_string(port)+".txt";					
					FILE* ff = fopen(x.c_str(),"ab");
					string s = f.info;
					fwrite(s.data(),1,s.length(),ff);
					fclose(ff);
				}

				while(between(ack_expected,f.h.ack,next_frame_to_send)){
					printf("%d,%d,%d\n",ack_expected,f.h.ack,next_frame_to_send);
					ack[ack_expected] = true;
					stop_timer(ack_expected);
					
					buff_cnt--;
					auto x = buffer.find(ack_expected);
					buffer.erase(x);
					
					ack_expected = inc(ack_expected);
				}
				//最后一个发完 
				if(send_end_frame!=-1&&ack_expected==send_end_frame){
					is_sending=false;
				} 
			}
//			if(status!="DataErr"){
//				while(between(ack_expected,f.h.ack,next_frame_to_send)){
//					printf("%d,%d,%d\n",ack_expected,f.h.ack,next_frame_to_send);
//					stop_timer(ack_expected);
//					ack[ack_expected] = true;
//					buff_cnt--;
//					auto x = buffer.find(ack_expected);
//					if(x!=buffer.end()) buffer.erase(x);
//					
//					ack_expected = inc(ack_expected);
//				}
//			}
		}
		else if(info.first == "send_data"){
			pp tmp = info.second;
			int send_num = tmp.second;
			record_out->send_record(send_num,"NEW",ack_expected);
			send_frame(send_num);
		}
		else if(info.first == "time_out")
		{
			int frame_index = ack_expected;
			for(int i=0;i<buff_cnt;i++)
			{
				record_out->send_record(frame_index,"TO",ack_expected);
				send_frame(frame_index);
				frame_index = inc(frame_index);
			}
			next_frame_to_send = frame_index;
			is_ok = true;
		}
	}
public:
    TaskQueue msg;

	//开启接收子线程,并不断处理队列 
    void excute(int dst)
	{
		dst_port = dst;
        //接收frame的子线程
        thread recv([this]
		{
            while(true)
			{
                Frame f = this->recv_frame();
				pp tmpp;
                tmpp.first = f;
				msg.push_one((pi){"recv_data",tmpp});
            }
        });
        recv.detach();
		
		pp l;
		msg.push_one((pi){"nihao",l});
//		Sleep(300);
		//处理framequeue事务的子线程
        while(true)
		{
            wait_for_event();
			if(ttt)
			{
				create_send_data();
				ttt = false;
			}
        }
        //TODO:打开文件并记录结束时间 
    }
    
    void send_file(string file_path){
		fp = fopen(file_path.c_str(),"rb");
	}
	
	void debug(){
		printf("ack expected=%d\n",ack_expected);
		printf("next to send=%d\n",next_frame_to_send);
		printf("frame expected=%d\n",frame_expected);

	}
    //从文件中读取参数,并初始化
    GBN(string config_file){
		memset(ack,0,sizeof(ack));
        ifstream config(config_file.data());
        char in[500];
        while (config.getline(in, 1000))
		{
            auto x = split(in, set<char>({' ', ':', '\t'}));
            if(x[0]=="error_rate"){
            	error_rate = atoi(x[1].data());
			}
			else if(x[0]=="lost_rate"){
            	loss_rate = atoi(x[1].data());
			}
			else if(x[0]=="UDPPort"){
            	port = atoi(x[1].data());
			}
			else if(x[0]=="SW_size"){
            	win_size = atoi(x[1].data());
			}
			else if(x[0]=="time_out"){
            	wait_time = atoi(x[1].data());
			}
			else if(x[0]=="init_seq_no"){
            	init_seq_no = atoi(x[1].data());
			}
			else if(x[0]=="data_size"){
            	datasize = atoi(x[1].data());
			}
        }
		p = new Physical(port);
		next_frame_to_send = init_seq_no;
        frame_expected = init_seq_no;
        ack_expected = init_seq_no;
		
		dir_name = "('"+p->get_ip()+"',"+to_string(port)+")";
		if(access(dir_name.c_str(),0)==-1) CreateDirectory(dir_name.c_str(), NULL);
		
		record_in = new Record(dir_name,"12",12,0);
		record_out = new Record(dir_name,"12",12,1);
		fp = fopen("send_file.txt", "rb");
	}
};
