# OS lab3 内存监视

能实时显示某个进程的虚拟地址空间布局和工作集信息等。

在Windows平台上做。相关的系统调用：

  GetSystemInfo, VirtualQueryEx,VirtualAlloc, GetPerformanceInfo, GlobalMemoryStatusEx …



## 要用到的函数以及一些结构体

### 结构体SYSTEM_INFO

就和名字一样，这个结构体描述了系统的一些基本信息，重要的信息用注释标注了出来：

```cpp
typedef struct _SYSTEM_INFO {
  	union {
    	DWORD dwOemId;
    	struct {
      	WORD wProcessorArchitecture;
      	WORD wReserved;
    	} 	DUMMYSTRUCTNAME;
  	} DUMMYUNIONNAME;
  	//页面大小以及页面保护和承诺的粒度。这是VirtualAlloc函数使用的页面大小 。
  	DWORD     dwPageSize;
  	//可访问的最低内存地址的指针。   
  	LPVOID    lpMinimumApplicationAddress;
  	//可访问的最高内存地址的指针。
 	LPVOID    lpMaximumApplicationAddress;
  	DWORD_PTR dwActiveProcessorMask;
  	//逻辑处理器的数量。
  	DWORD     dwNumberOfProcessors;
  	DWORD     dwProcessorType;
  	DWORD     dwAllocationGranularity;
  	WORD      wProcessorLevel;
  	WORD      wProcessorRevision;
} SYSTEM_INFO, *LPSYSTEM_INFO;
```

### 函数GetSystemInfo

```cpp
WINBASEAPI VOID WINAPI GetSystemInfo (LPSYSTEM_INFO lpSystemInfo);
```

lpSystemInfo指向接收信息的SYSTEM_INFO结构的指针 ，系统的信息会返回到参数的指针指向的SYSTEM_INFO类型的结构体

### 结构体PERFORMANCE_INFORMATION

```cpp
typedef struct _PERFORMANCE_INFORMATION {
	//结构体大小
  	DWORD  cb;
    //系统当前提交的页数
  	SIZE_T CommitTotal;
    //系统可以提交的最大页数
  	SIZE_T CommitLimit;
    //系统自上次重启以来的处于已提交状态的最大页数
  	SIZE_T CommitPeak;
  	SIZE_T PhysicalTotal;
  	SIZE_T PhysicalAvailable;
    //以页为单位的系统缓存内存量。 这是备用列表的大小以及系统工作集。
  	SIZE_T SystemCache;
    //分页和非分页内核池中当前内存的总和（以页为单位）
  	SIZE_T KernelTotal;
  	SIZE_T KernelPaged;
  	SIZE_T KernelNonpaged;
    //页大小
  	SIZE_T PageSize;
    //总HANDLE数
  	DWORD  HandleCount;
    //总进程数
  	DWORD  ProcessCount;
    //总线程数
  	DWORD  ThreadCount;
} PERFORMANCE_INFORMATION, *PPERFORMANCE_INFORMATION, PERFORMACE_INFORMATION, *PPERFORMACE_INFORMATION;
```

### 函数GetPerformanceInfo

```cpp
WINBOOL WINAPI GetPerformanceInfo (PPERFORMACE_INFORMATION pPerformanceInformation,DWORD cb);
```

将内存性能信息返回到第一个参数中

### 结构体MEMORYSTATUSEX

```cpp
typedef struct _MEMORYSTATUSEX
{
    //本结构长度
  	DWORD     dwLength;
    //已用内存百分比
  	DWORD     dwMemoryLoad; 
    //物理内存总量
  	DWORDLONG    ullTotalPhys; 
    //可用物理内存
 	DWORDLONG    ullAvailPhys; 
    //页交换文件总大小
  	DWORDLONG    ullTotalPageFile;
    //页交换文件可用大小
  	DWORDLONG    ullAvailPageFile;
    //用户区总的虚拟地址空间
  	DWORDLONG    ullTotalVirtual; 
    //用户区当前可用的虚拟地址空间
  	DWORDLONG    ullAvailVirtual; 
  	DWORDLONG    ullAvailExtendedVirtual;
} MEMORYSTATUSEX,  *MEMORYSTATUSEX;
```

### 函数GlobalMemoryStatusEx

```cpp
WINBASEAPI WINBOOL WINAPI GlobalMemoryStatusEx (LPMEMORYSTATUSEX lpBuffer);
```

参数是一个指向一个MEMORYSTATUSEX结构的指针，函数会将系统当前的全局内存信息写入到该指针所指向的MEMORYSTATUSEX结构，并返回一个bool值来确定该次内存信息获取是否成功

注意：lpBuffer指向的结构体的dwLength字段必须在调用该函数前赋值为该结构体的长度，不然该函数不会返回正确结果

### 结构体PROCESSENTRY32

```cpp
typedef struct tagPROCESSENTRY32 {
    //结构体大小，使用之前也要赋值
    DWORD dwSize;
    DWORD cntUsage;
    //进程唯一的PID
    DWORD th32ProcessID;
    ULONG_PTR th32DefaultHeapID;
    DWORD th32ModuleID;
    //进程启动的执行线程数
    DWORD cntThreads;
    DWORD th32ParentProcessID;
    LONG pcPriClassBase;
    DWORD dwFlags;
    //进程文件的名称
    CHAR szExeFile[MAX_PATH];
} PROCESSENTRY32;
```

### 函数CreateToolhelp32Snapshot

```cpp
HANDLE WINAPI CreateToolhelp32Snapshot(DWORD dwFlags,DWORD th32ProcessID);
```

拍摄指定进程以及这些进程使用的堆，模块和线程的快照，返回一个HANDLE

### 函数Process32First  Process32Next

```cpp
WINBOOL WINAPI Process32First(HANDLE hSnapshot,LPPROCESSENTRY32 lppe);
WINBOOL WINAPI Process32Next(HANDLE hSnapshot,LPPROCESSENTRY32 lppe);
```

函数Process32First的作用是检索快照hSnapshot中第一个进程的信息，并把这些信息存储在了指针lppe所指向的结构体中。检索成功则返回true，否则返回false

函数Process32Next的作用是检索快照hSnapshot中第下一个进程的信息，并把这些信息存储在了指针lppe所指向的结构体中。检索成功则返回true，否则返回false

### 函数OpenProcess

```cpp
WINBASEAPI HANDLE WINAPI OpenProcess (DWORD dwDesiredAccess, WINBOOL bInheritHandle, DWORD dwProcessId);
```

该函数的作用是打开一个本地进程对象。第一个参数是访问权限，第二个是进程是否继承句柄，第三个是要打开的进程的PID

若函数成功，则返回指定进程的打开HANDLE；若失败则返回NULL

### 结构体MEMORY_BASIC_INFORMATION

```cpp
//存储页面信息
typedef struct _MEMORY_BASIC_INFORMATION {
    //页面基地址
    PVOID BaseAddress;
    PVOID AllocationBase;
    DWORD AllocationProtect;
    //区域大小
    SIZE_T RegionSize;
    //页面状态
	DWORD State;
    //页面保护权限
	DWORD Protect;
    //页面类型
	DWORD Type;
} MEMORY_BASIC_INFORMATION,*PMEMORY_BASIC_INFORMATION;
```

### VirtualQueryEx

```cpp
WINBASEAPI SIZE_T WINAPI VirtualQueryEx (HANDLE hProcess, LPCVOID lpAddress, PMEMORY_BASIC_INFORMATION lpBuffer, SIZE_T dwLength);
```

检索有关指定进程的虚拟地址空间内的页面范围的信息







