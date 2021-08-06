#include<stdio.h>
#include<string.h>
#include<windows.h>

int main(int argc,char *argv[])
{
    SYSTEMTIME start,end;

    STARTUPINFO si;
    memset(&si,0,sizeof(si));
    si.cb=sizeof(si);
    PROCESS_INFORMATION pi;

    char Cmdstr[1005]="";
    for(int i=1;i<argc;i++)
    {
        strcat(Cmdstr,argv[i]);
        strcat(Cmdstr," ");
    }

    if(CreateProcess(
	NULL,      //不指定模块名称，使用命令行
	Cmdstr,    //具体命令行
	NULL,      //不继承进程句柄
	NULL,      //不继承线程句柄
	FALSE,     //不继承当前进程句柄
	0,         //无进程创建标志
	NULL,      //使用父进程环境
	NULL,      //使用父进程目录
	&si,       //进程启动信息地址
	&pi )      //进程信息地址
       )
    GetSystemTime(&start);

    
    WaitForSingleObject(pi.hProcess,INFINITE);
    
    GetSystemTime(&end);
    CloseHandle(pi.hProcess);

    int t[5];
    t[0]=end.wHour-start.wHour;
    t[1]=end.wMinute-start.wMinute;
    t[2]=end.wSecond-start.wSecond;
    t[3]=end.wMilliseconds-start.wMilliseconds;
    if(t[1]<0) t[0]-=1,t[1]+=60;
    if(t[2]<0) t[1]-=1,t[2]+=60;
    if(t[3]<0) t[2]-=1,t[3]+=1000;
    printf("%d小时%d分%d秒%d毫秒\n",t[0],t[1],t[2],t[3]);

    return 0;
}
