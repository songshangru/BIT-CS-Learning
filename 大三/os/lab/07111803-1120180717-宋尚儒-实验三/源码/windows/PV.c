#include<stdio.h>
#include<stdlib.h>
#include<time.h>
#include<windows.h>

#define Cnt_Producer 2
#define Rep_Producer 6
#define Cnt_Consumer 3
#define Rep_Consumer 4
#define Cnt_Process 5
#define Len_buffer 3


struct share_memory
{
    int a[Len_buffer];
    int beg;
    int end;
};

HANDLE s_empty,s_fill,s_rw;
HANDLE Handle_process[Cnt_Process+5];

void show_buffer(struct share_memory *sm)
{
    printf("现缓冲区数据为: ");
    for(int i=0;i<Len_buffer;i++)
    {
        printf("%d ",sm->a[i]);
    }
    printf("\n");
}

HANDLE MakeSharedFile()
{
	HANDLE hMapping=CreateFileMapping(INVALID_HANDLE_VALUE,NULL,PAGE_READWRITE,0, sizeof(struct share_memory),"SHARE_MEM");
	LPVOID pData=MapViewOfFile(hMapping,FILE_MAP_ALL_ACCESS,0,0,0);
	ZeroMemory(pData, sizeof(struct share_memory));
	UnmapViewOfFile(pData);
	return(hMapping);
}


void Create_Mux()
{
    s_empty=CreateSemaphore(NULL, Len_buffer, Len_buffer, "SEM_EMPTY");
    s_fill=CreateSemaphore(NULL, 0, Len_buffer, "SEM_FILL");
    s_rw=CreateSemaphore(NULL, 1, 1, "SEM_RW");
}


void Open_Mux()
{
    s_empty=OpenSemaphore(SEMAPHORE_ALL_ACCESS,FALSE,"SEM_EMPTY");
    s_fill=OpenSemaphore(SEMAPHORE_ALL_ACCESS,FALSE,"SEM_FILL");
    s_rw=OpenSemaphore(SEMAPHORE_ALL_ACCESS,FALSE,"SEM_RW");
}

void Close_Mux()
{
    CloseHandle(s_empty);
    CloseHandle(s_fill);
    CloseHandle(s_rw);
}

void New_SubProcess(int ID)
{
    STARTUPINFO si;
    memset(&si,0,sizeof(si));
    si.cb=sizeof(si);
    PROCESS_INFORMATION pi;

    char Cmdstr[105];
    char CurFile[105];

    GetModuleFileName(NULL, CurFile, sizeof(CurFile));
    sprintf(Cmdstr, "%s %d", CurFile, ID);

    CreateProcess(NULL,Cmdstr,NULL,NULL,FALSE,0,NULL,NULL,&si,&pi);
    Handle_process[ID]=pi.hProcess;

    return;
}

void Producer(int ID)
{
    HANDLE hMapping=OpenFileMapping(FILE_MAP_ALL_ACCESS,FALSE,"SHARE_MEM");
    LPVOID pFile = MapViewOfFile(hMapping, FILE_MAP_ALL_ACCESS, 0, 0, 0);
    struct share_memory *sm=(struct share_memory*)(pFile);
    Open_Mux();
    for(int i=0;i<Rep_Producer;i++)
    {
        srand((unsigned int)time(NULL) + ID);
        int temp=(rand()%5+1)*500;
        Sleep(temp);

        WaitForSingleObject(s_empty,INFINITE);
        WaitForSingleObject(s_rw,INFINITE);

        printf("%d号进程:生产者在%d号缓冲区生产%d\n",ID,sm->end,temp);
        sm->a[sm->end]=temp;
        sm->end=(sm->end+1)%Len_buffer;
        show_buffer(sm);

        ReleaseSemaphore(s_fill,1,NULL);
        ReleaseSemaphore(s_rw,1,NULL);
    }
    Close_Mux();
    UnmapViewOfFile(pFile);
    CloseHandle(hMapping);
}

void Consumer(int ID)
{
    HANDLE hMapping=OpenFileMapping(FILE_MAP_ALL_ACCESS,FALSE,"SHARE_MEM");
    LPVOID pFile = MapViewOfFile(hMapping, FILE_MAP_ALL_ACCESS, 0, 0, 0);
    struct share_memory *sm=(struct share_memory*)(pFile);
    Open_Mux();
    for(int i=0;i<Rep_Consumer;i++)
    {
        srand((unsigned int)time(NULL) + ID);
        int temp=(rand()%5+1)*1000;
        Sleep(temp);

        WaitForSingleObject(s_fill,INFINITE);
        WaitForSingleObject(s_rw,INFINITE);

        printf("%d号进程:消费者在%d号缓冲区消费%d\n",ID,sm->beg,sm->a[sm->beg]);
        sm->a[sm->beg]=0;
        sm->beg=(sm->beg+1)%Len_buffer;
        show_buffer(sm);

        ReleaseSemaphore(s_empty,1,NULL);
        ReleaseSemaphore(s_rw,1,NULL);
    }
    Close_Mux();
    UnmapViewOfFile(pFile);
    CloseHandle(hMapping);
}


int main(int argc,char *argv[])
{
    if(argc==1)
    {
        HANDLE hMapping=MakeSharedFile();
        Create_Mux();
        printf("0号进程:创建子进程，1~2号为生产者进程，3~5号为消费者进程\n");
        for(int i=1;i<=Cnt_Process;i++)
        {
            New_SubProcess(i);
        }
        WaitForMultipleObjects(Cnt_Process,Handle_process+1,TRUE,INFINITE);
        for(int i=1;i<=Cnt_Process;i++)
        {
            CloseHandle(Handle_process[i]);
        }
        Close_Mux();
        printf("0号进程:子进程运行完成\n");
        CloseHandle(hMapping);
    }
    else
    {
        int ID=atoi(argv[1]);
        if(ID<=Cnt_Producer)
            Producer(ID);
        else
            Consumer(ID);
    }

    return 0;
}

