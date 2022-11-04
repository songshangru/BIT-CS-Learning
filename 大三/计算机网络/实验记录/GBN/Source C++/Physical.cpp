#include<Winsock.h>
#include<string>
#include<thread>
using namespace  std;
#pragma comment(lib,"ws2_32.lib")

class Physical {
private:
	const int BUFF_LEN = 1024*5;
    SOCKET socket_id;
    SOCKADDR_IN us;
    SOCKADDR_IN last_src;
	int last_src_addrlen;
	BOOL fBroadcast = TRUE;
	
public:
    Physical(int port)
	{
		WSADATA wsaData;
	    if(WSAStartup(MAKEWORD(1, 1), &wsaData)!=0)
	    {
	        printf("[Error] Can't initiates windows socket!\n");
	    }
	    if((socket_id = socket(AF_INET, SOCK_DGRAM, 0))<0)
	    {
	    	printf("[Error] Socket build error\n");
		}
    	setsockopt(socket_id, SOL_SOCKET, SO_BROADCAST, (CHAR*)&fBroadcast, sizeof(BOOL));
    	
        us.sin_family = AF_INET;
        us.sin_addr.s_addr = htonl(INADDR_ANY);
        us.sin_port = htons(port);
        
        if((bind(socket_id, (SOCKADDR FAR*)&us, sizeof(us)))<0)
		{
            printf("[Error] Socket bind fail\n");
        }
    }
	//发送给目的端口 
    void send_to_port(string info, int dst_port) {
    	
        SOCKADDR_IN dst;
        dst.sin_family = AF_INET;
        dst.sin_addr.s_addr = htonl(INADDR_BROADCAST);
        dst.sin_port = htons(dst_port);
        
        sendto(socket_id, info.data(), info.length(), 0, (SOCKADDR*)&dst, sizeof(SOCKADDR_IN));
        return ; 
    }
	//发送给上次收到内容的发送方地址
    void send_back(string info) {
        sendto(socket_id, info.data(), info.length(), 0, (SOCKADDR*)&last_src, sizeof(SOCKADDR_IN));
        return ;
    }
	
	//接受一个string等10ms
    string recv()
	{
		int nSize;
        last_src_addrlen = sizeof(SOCKADDR_IN);
        char buf[BUFF_LEN];

        if((nSize = recvfrom(socket_id, buf, BUFF_LEN, 0,(SOCKADDR FAR*)&last_src, &last_src_addrlen))<0)
        {
            printf("[Error] Can't receive information\n");
        }
		
        string s(buf,nSize);
        this_thread::sleep_for(chrono::milliseconds(10));
        
        return s;
    }
    string get_ip()
    {
    	string res;
    	PHOSTENT hostinfo;
    	char name[256];
		if(gethostname(name,sizeof(name)) == 0)
		{
			if((hostinfo = gethostbyname(name))!= NULL)
			{
				LPCSTR ip = inet_ntoa(*(struct in_addr *)*hostinfo->h_addr_list);
				res=ip;
			}
		}
		return res;
	}
};
