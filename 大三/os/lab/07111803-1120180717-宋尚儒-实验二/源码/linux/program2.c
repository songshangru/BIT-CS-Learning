#include<math.h>
#include<stdio.h>
#include<stdlib.h>
#include<sys/time.h>
#include<sys/types.h>
#include<signal.h>
#include<unistd.h>

int main(int argc,char *argv[])
{
	printf("%d\n",argc);
	int con_t=0,p=0;
        con_t=atoi(argv[1]);
        sleep(con_t);
        return 0;
}
