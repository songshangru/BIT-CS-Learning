#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <windows.h>

#define COUNT_BUFFER 6          //6个缓冲区
#define BUFFER_LENGTH 10        //每个缓冲区数组最低长度为10
#define COUNT_PRODUCER 2        //2个生产者进程
#define REPEAT_PRODUCER 12      //重复12次
#define COUNT_CONSUMER 3        //3个消费者进程
#define REPEAT_CONSUMER 8       //重复8次
#define COUNT_PROCESS 5         //总进程数

struct BufferPool{
    char bufferZones[COUNT_BUFFER * BUFFER_LENGTH]; //存储具体数据
    char * bufferZoneStart[COUNT_BUFFER];           //存储每个缓冲区的起始指针
    char * bufferZoneEnd[COUNT_BUFFER];             //存储每个缓冲区的尾指针, 默认状态下与起始指针相同, 在写入内容后变化
}BufferPool;

//用于处理三个信号量的全局变量
HANDLE signalEmpty,signalFull,signalMutex;
//用于处理进程的全局handle
HANDLE handleProcess[COUNT_PROCESS+6];

void ShowAllBuffer(struct BufferPool *bufferPool){
    printf("现在缓冲池的数据为:\n");
    for(int i=0; i < COUNT_BUFFER; ++i){
        printf("第%d个缓冲区的数据为: ",i);
        if(bufferPool->bufferZoneStart[i] == bufferPool->bufferZoneEnd[i]){
            printf("empty");
        }else{
            for(int j=0; j < BUFFER_LENGTH; ++j){
                printf("%c",bufferPool->bufferZones[10*i+j]);
            }
        }
        printf("\n");
    }
}

//创建共享内存区
HANDLE CreateSharedMemory()
{
    //创建内存映射用于共享内存, 大小足够一个BufferPool即可
    HANDLE hMapping = CreateFileMapping(INVALID_HANDLE_VALUE,NULL,PAGE_READWRITE,0, sizeof(struct BufferPool),"SHARE_MEM");
    //将一个文件映射对象映射到当前应用程序的地址空间
    LPVOID pData = MapViewOfFile(hMapping,FILE_MAP_ALL_ACCESS,0,0,0);
    //使用0填充共享内存初始化
    ZeroMemory(pData, sizeof(struct BufferPool));

    //进行共享内存的格式化
    struct BufferPool *bufferPool = (struct BufferPool*)(pData);
    for(int i = 0; i < COUNT_BUFFER; ++i){
        bufferPool->bufferZoneStart[i] = &bufferPool->bufferZones[10*i];
        bufferPool->bufferZoneEnd[i] = &bufferPool->bufferZones[10*i];
    }

    UnmapViewOfFile(pData);
    return(hMapping);
}

//创建锁
void CreateMux()
{
    //注册信号量
    signalEmpty = CreateSemaphore(NULL, COUNT_BUFFER, COUNT_BUFFER, "SEM_EMPTY");
    signalFull = CreateSemaphore(NULL, 0, COUNT_BUFFER, "SEM_FILL");
    signalMutex = CreateSemaphore(NULL, 1, 1, "SEM_MUTEX");
}

//打开锁
void OpenMux()
{
    signalEmpty = OpenSemaphore(SEMAPHORE_ALL_ACCESS,FALSE,"SEM_EMPTY");
    signalFull = OpenSemaphore(SEMAPHORE_ALL_ACCESS, FALSE, "SEM_FILL");
    signalMutex = OpenSemaphore(SEMAPHORE_ALL_ACCESS,FALSE,"SEM_MUTEX");
}

//关闭Mutex
void CloseMux()
{
    //直接关闭Handle即可
    CloseHandle(signalEmpty);
    CloseHandle(signalFull);
    CloseHandle(signalMutex);
}

void CreateSubProcess(int ID)
{
    //创建STARTUPINFO
    STARTUPINFO startupinfo;
    memset(&startupinfo,0,sizeof(startupinfo));
    startupinfo.cb=sizeof(startupinfo);

    //创建PROCESS_INFO
    PROCESS_INFORMATION processInformation;

    char commandLine[205];
    char CurFile[205];

    GetModuleFileName(NULL, CurFile, sizeof(CurFile));
    sprintf(commandLine, "%s %d", CurFile, ID);

    CreateProcess(NULL,commandLine,NULL,NULL,FALSE,0,NULL,NULL,&startupinfo,&processInformation);
    handleProcess[ID]=processInformation.hProcess;
}

void Producer(int ID){
    //获取共享内存缓冲池指针
    HANDLE hMapping=OpenFileMapping(FILE_MAP_ALL_ACCESS,FALSE,"SHARE_MEM");
    LPVOID pFile = MapViewOfFile(hMapping, FILE_MAP_ALL_ACCESS, 0, 0, 0);
    struct BufferPool *bufferPool = (struct BufferPool*)(pFile);

    OpenMux();

    for(int i=0;i<REPEAT_PRODUCER;i++){
        //生成随机数,等待随机时间
        srand((unsigned int)time(NULL) + ID + i);
        int temp = (rand()%5+1)*500;
        Sleep(temp);

        WaitForSingleObject(signalEmpty,INFINITE);
        WaitForSingleObject(signalMutex,INFINITE);

        //生产缓冲区
        int number = 0;
        //寻找空缓冲区
        for(int j = 0;j < COUNT_BUFFER; ++j){
            if (bufferPool->bufferZoneStart[j] == bufferPool->bufferZoneEnd[j]){
                number = j;
                break;
            }
        }
        printf("%d号进程:生产者在%d号缓冲区生产\n",ID,number);
        //将内容写入空缓冲区
        for (int j = 0; j < BUFFER_LENGTH; ++j) {
            srand((unsigned int)time(NULL) + ID + j);
            bufferPool->bufferZones[10*number+j] = rand()%95+31;
        }
        bufferPool->bufferZoneEnd[number] = bufferPool->bufferZoneStart[number] + BUFFER_LENGTH - 1;

        ShowAllBuffer(bufferPool);

        //V(full)与V(mutex)操作
        ReleaseSemaphore(signalFull, 1, NULL);
        ReleaseSemaphore(signalMutex,1,NULL);
    }

    //释放资源
    CloseMux();
    UnmapViewOfFile(pFile);
    CloseHandle(hMapping);

    printf("%d号进程运行完成!\n",ID);
}

void Consumer(int ID){
    //获取共享内存缓冲池指针
    HANDLE hMapping=OpenFileMapping(FILE_MAP_ALL_ACCESS,FALSE,"SHARE_MEM");
    LPVOID pFile = MapViewOfFile(hMapping, FILE_MAP_ALL_ACCESS, 0, 0, 0);
    struct BufferPool *bufferPool = (struct BufferPool*)(pFile);

    OpenMux();

    for(int i=0;i<REPEAT_CONSUMER;i++){
        //生成随机数,等待随机时间
        srand((unsigned int)time(NULL) + ID + i);
        int temp = (rand()%5+1)*1000;
        Sleep(temp);

        WaitForSingleObject(signalFull, INFINITE);
        WaitForSingleObject(signalMutex,INFINITE);

        //消费缓冲区
        int number = 0;
        //寻找满缓冲区
        for(int j = 0;j < COUNT_BUFFER; ++j){
            if (bufferPool->bufferZoneStart[j] != bufferPool->bufferZoneEnd[j]){
                number = j;
                break;
            }
        }
        printf("%d号进程:消费者在%d号缓冲区消费\n",ID,number);
        bufferPool->bufferZoneEnd[number] = bufferPool->bufferZoneStart[number];

        ShowAllBuffer(bufferPool);

        //V(empty)与V(mutex)操作
        ReleaseSemaphore(signalEmpty,1,NULL);
        ReleaseSemaphore(signalMutex,1,NULL);
    }

    CloseMux();
    UnmapViewOfFile(pFile);
    CloseHandle(hMapping);

    printf("%d号进程运行完成!\n",ID);
}

int main(int argc,char *argv[]) {

    if(argc==1){
        //创建共享内存区
        HANDLE hMapping=CreateSharedMemory();
        //创建信号量
        CreateMux();
        printf("0号进程:创建子进程，1~2号为生产者进程，3~5号为消费者进程\n");
        for(int i=1;i<=COUNT_PROCESS;i++)
        {
            CreateSubProcess(i);
        }
        //等待所有子进程结束
        WaitForMultipleObjects(COUNT_PROCESS,handleProcess+1,TRUE,INFINITE);
        //关闭句柄
        for(int i=1;i<=COUNT_PROCESS;i++)
        {
            CloseHandle(handleProcess[i]);
        }
        CloseMux();
        printf("0号进程运行完成\n");
        CloseHandle(hMapping);
    }else{
        int ID=atoi(argv[1]);

        if(ID<=COUNT_PRODUCER)  Producer(ID);
        else    Consumer(ID);

    }
    return 0;
}
