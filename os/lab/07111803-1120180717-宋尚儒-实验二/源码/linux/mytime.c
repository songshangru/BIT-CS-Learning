#include<math.h>
#include<stdio.h>
#include<string.h>
#include<stdlib.h>
#include<sys/time.h>
#include<sys/types.h>
#include<signal.h>
#include<unistd.h>

int main(int argc,char *argv[])
{
    struct timeval start;
    struct timeval end;

    char path[105],temp[105];
    strcpy(path,getenv("PATH"));
    getcwd(temp,sizeof(temp));
    strcat(path,":");
    strcat(path,temp);
    setenv("PATH",path,1);
    
    int pid=fork();
    
    if(pid<0)
    {
        printf("fork fail");
        exit(0);
    }
    else if(pid==0)
    {
        execvp(argv[1],argv+1);
    }
    else
    {
    	gettimeofday(&start,NULL);
    	wait(NULL);
    	gettimeofday(&end,NULL);
    	int sec=end.tv_sec-start.tv_sec;
    	int usec=end.tv_usec-start.tv_usec;
    	if(usec<0)
    	{
    	    sec-=1;
            usec+=1000000;
    	}
        int h=sec/3600; sec=sec%3600;	    
        int m=sec/60; sec=sec%60;
        int mm=usec/1000; usec=usec%1000;
        printf("%d小时%d分%d秒%d毫秒%d微秒\n",h,m,sec,mm,usec);
    	
    }
    return 0;
}
