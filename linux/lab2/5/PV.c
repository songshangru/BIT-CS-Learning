#include<stdio.h>
#include<stdlib.h>
#include<sys/time.h>
#include<sys/types.h>
#include<sys/wait.h>
#include<sys/ipc.h>
#include<sys/sem.h>
#include<sys/shm.h>
#include<unistd.h>

#define maxn 105

#define SHMKEY 1024
#define SEMKEY 2048

struct share_memory
{
    int a[maxn][maxn];
};

int x[maxn][maxn];

int Create_Mux()
{
    int semid=semget(SEMKEY,3,0666|IPC_CREAT);
    semctl(semid,1,SETVAL,1); //rw
    return semid;
}


void P(int semid,int n)
{
	struct sembuf temp;
	temp.sem_num=n;
	temp.sem_op=-1;
	temp.sem_flg=0;
	semop(semid,&temp,1);
}

void V(int semid,int n)
{
	struct sembuf temp;
	temp.sem_num=n;
	temp.sem_op=1;
	temp.sem_flg=0;
	semop(semid,&temp,1);
}

int Init_Share_Memory()
{
    int shmid=shmget(SHMKEY,sizeof(struct share_memory),0666|IPC_CREAT);
    struct share_memory* sm=(struct share_memory*)shmat(shmid,0,0);
    for(int i=0;i<100;i++)
    {
        for(int j=0;j<100;j++)
	{
	    sm->a[i][j]=0;
	}
    }
    return shmid;
}



void Matrix_Mul(int ID,int shmid,int semid)
{
	printf("%d\n",ID);
    struct share_memory *sm=(struct share_memory*)shmat(shmid,0,0);
    int beg,end;
    if(ID==1)
    {
        beg = 0;
        end = 49;
    }
    else
    {
        beg = 50;
        end = 99;
    }
    for(int i=beg;i<=end;i++)
    {
	for(int j=0;j<100;j++)
	{
	    for(int k=0;k<100;k++)
	    {
		int tmp=x[i][k]*x[k][j];
		//P(semid,0);
	        sm->a[i][j] += tmp;
		//V(semid,0); 
	    }
	    printf("%d %d %d\n",ID,i,j);
	}
    }
}

int main(int argc,char *argv[])
{
    int semid=Create_Mux();
    int shmid=Init_Share_Memory();
    for(int i=0;i<100;i++)
    {
        for(int j=0;j<100;j++)
	{
	    x[i][j]=1;
	}
    }

    for(int i=1;i<=2;i++)
    {
        int pid=fork();
    	if(pid==0)
    	{
            //子进程
    	    Matrix_Mul(i,shmid,semid);
            return 0;
    	}
    }
    //主进程
    for(int i=1;i<=2;i++)
    {
        wait(NULL);
    }
    printf("0号进程:子进程运行完成\n");

    struct share_memory *sm=(struct share_memory*)shmat(shmid,0,0);
    for(int i=0;i<100;i++)
    {
        for(int j=0;j<100;j++)
	{
	    printf("%d ",sm->a[i][j]);
	}
        printf("\n");
    }
    semctl(semid,IPC_RMID,0);
    shmctl(shmid,IPC_RMID,0);
    return 0;
}
