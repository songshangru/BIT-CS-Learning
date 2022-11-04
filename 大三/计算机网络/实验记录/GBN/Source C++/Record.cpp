#include<fstream>
#include<string>
#include<iostream>
#include<io.h>
#include<windows.h>
using namespace std;

class Record{
private:
	ofstream f;
	int seq = 1;
	
public:
	Record(string dir_name,string ip,int port,int type)
	{
		string s=dir_name+"/";
		if(type == 0) s +="recvfrom_";
		else s += "sendto_";
		s+="('"+ip+"',"+to_string(port)+").txt";
		f.open(s,ios::out);
	}
	void close()
	{
		f.close();
	}
	void receive_record(int pdu_exp,int pdu_recv,string status)
	{
		if(f.is_open())
		{
			f << to_string(seq)+", recv_num="+to_string(pdu_recv)+", recv_exp="+to_string(pdu_exp)+", status="+status+"\n";
			seq++;
		}
		else
		{
			printf("[Error] Record file open failed\n");
		}
	}
	void send_record(int pdu_to_send, string status,int ackedNo)
	{
		if(f.is_open())
		{
			f << to_string(seq)+", send_num="+to_string(pdu_to_send)+", send_ack="+to_string(ackedNo)+", status="+status+"\n";
			seq++;
		}
		else
		{
			printf("[Error] Record file open failed\n");
		}
	}
	void record_time(double t)
	{
		if(f.is_open())
		{
			f <<"Time cost:" +to_string(t)+"s\n";
		}
		else
		{
			printf("[Error] Record file open failed\n");
		}
	}
};
