#include "GBN1.cpp"
using namespace std;
//配置文件名 
const string config_file = "config1.txt";

int main()
{
    GBN host(config_file);
	//发送给的12345端口 
    thread([&host] { host.excute(12345); }).detach();
    //输入文件名以发送 
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
