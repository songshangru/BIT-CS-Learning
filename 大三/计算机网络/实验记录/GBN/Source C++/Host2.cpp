#include "GBN1.cpp"
using namespace std;
//配置文件名 
const string config_file = "config2.txt";

int main()
{
    GBN host(config_file);
	//发送给10000端口 
    thread([&host] { host.excute(10000); }).detach();
    
    string s;
    while(cin>>s)
	{
//		if(s=="debug")
//		{
//			host.debug();
//		}
//        else 
		host.send_file(s);
    }
    return 0;
}
