#include <windows.h>
#include <iostream>
#include <tlhelp32.h>
#include <cstdio>
#include <tchar.h>
#include <psapi.h>

#define MEGA 1048576
using namespace std;

//打印中文就出错, 所以打印的输出全换成英文
int main() {

    //保存系统信息的结构
    SYSTEM_INFO systemInfo;
    //初始化内存
    memset(&systemInfo, 0, sizeof(systemInfo));
    //获取系统信息到systemInfo中
    GetSystemInfo(&systemInfo);
    //打印系统信息
    cout << "System Info: " << endl;
    cout << "Minimum address: " << systemInfo.lpMinimumApplicationAddress << endl;
    cout << "Maximum address: " << systemInfo.lpMaximumApplicationAddress << endl;
    printf("Size of the page: %lu Byte\n", systemInfo.dwPageSize);
    cout << "--------------------------------------------" << endl;

    //存储内存性能信息的结构
    PERFORMANCE_INFORMATION performanceInformation;
    int cb = sizeof(performanceInformation);
    //获取内存性能信息
    GetPerformanceInfo(&performanceInformation, cb);
    //打印内存性能信息
    cout << "Memory Performance Info:" << endl;
    printf("Total Commit Pages: %lu\n", performanceInformation.CommitTotal);
    printf("Limit Commit Pages: %lu\n", performanceInformation.CommitLimit);
    printf("System Cache: %lu\n", performanceInformation.SystemCache);
    printf("Total Kernel: %lu\n", performanceInformation.KernelTotal);
    printf("Page Size: %lu Byte\n", performanceInformation.PageSize);
    printf("HANDLE Count: %lu\n", performanceInformation.HandleCount);
    printf("System Process Count: %lu\n", performanceInformation.ProcessCount);
    printf("System Thread Count: %lu\n", performanceInformation.ThreadCount);
    cout << "--------------------------------------------" << endl;

    //保存内存状态的结构
    MEMORYSTATUSEX memoryStatus;
    memset(&memoryStatus, 0, sizeof(memoryStatus));
    //先给长度赋值再获取信息
    memoryStatus.dwLength = sizeof(memoryStatus);
    //获取内存状态到memoryStatus中
    GlobalMemoryStatusEx(&memoryStatus);
    //打印内存信息
    cout << "Memory Status: " << endl;
    printf("Total Physical Memory: %lld MB\n", memoryStatus.ullTotalPhys / MEGA);
    printf("Available Physical Memory: %lld MB\n", memoryStatus.ullAvailPhys / MEGA);
    printf("Memory Usage: %lu%% \n", memoryStatus.dwMemoryLoad);
    printf("Total Virtual Memory: %lld MB\n", memoryStatus.ullTotalVirtual / MEGA);
    printf("Available Virtual Memory: %lld MB\n", memoryStatus.ullAvailVirtual / MEGA);
    printf("Total Page File: %lld MB\n", memoryStatus.ullTotalPageFile / MEGA);
    printf("Available Page File: %lld MB\n", memoryStatus.ullAvailPageFile / MEGA);
    cout << "--------------------------------------------" << endl;

    //获取所有进程的PID
    PROCESSENTRY32 processEntry;
    memset(&processEntry, 0, sizeof(processEntry));
    processEntry.dwSize = sizeof(processEntry);
    //创建系统快照
    HANDLE snapshot = CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
    //打印进程信息
    cout << "Process Info:" << endl;
    bool snap = Process32First(snapshot, &processEntry);
    while (snap) {
        printf("%ws: %lu\n", processEntry.szExeFile,processEntry.th32ProcessID);
        //获取下一个快照
        snap = Process32Next(snapshot, &processEntry);
    }
    cout << "--------------------------------------------" << endl;

    //查询特定进程
    int pid;
    cout << "Please enter the pid you want to search:" << endl;
    cin >> pid;
    //若输入的pid正确则返回该进程的HANDLE, 若错误则返回空
    HANDLE process = OpenProcess(PROCESS_ALL_ACCESS, FALSE, pid);
    //若查询的进程错误, 则一直要求用户重新输入
    while (process == nullptr) {
        cout << "Process not found! Please Re-enter the pid:" << endl;
        cin >> pid;
        process = OpenProcess(PROCESS_ALL_ACCESS, FALSE, pid);
    }

    //存储页面信息的结构
    MEMORY_BASIC_INFORMATION memoryInfo;
    memset(&memoryInfo, 0, sizeof(memoryInfo));
    LPCVOID block = (LPVOID)systemInfo.lpMinimumApplicationAddress;
    while (block < systemInfo.lpMaximumApplicationAddress) {

        if (VirtualQueryEx(process, block, &memoryInfo, sizeof(memoryInfo))) {

            // 计算得到块的结尾
            LPCVOID end = (PBYTE)block + memoryInfo.RegionSize;
            // 输出地址
            cout << "Address: 0x" << block << " - 0x" << end;

            // 输出页面状态
            cout << "    State: ";
            switch (memoryInfo.State)
            {
            case MEM_COMMIT:
                cout << "COMMIT";
                break;
            case MEM_FREE:
                cout << "FREE";
                break;
            case MEM_RESERVE:
                cout << "RESERVE";
                break;
            }

            if (memoryInfo.State == MEM_FREE) {
                cout << endl;
                block = end;
                continue;
            }

            // 输出页面保护状态
            cout << "    Protect: ";
            switch (memoryInfo.AllocationProtect)
            {
            case PAGE_EXECUTE:
                cout << "EXECUTE";
                break;
            case PAGE_EXECUTE_READ:
                cout << "EXECUTE_READ";
                break;
            case PAGE_EXECUTE_READWRITE:
                cout << "EXECUTE_READWRITE";
                break;
            case PAGE_EXECUTE_WRITECOPY:
                cout << "EXECUTE_WRITECOPY";
                break;
            case PAGE_NOACCESS:
                cout << "NOACCESS";
                break;
            case PAGE_READONLY:
                cout << "READONLY";
                break;
            case PAGE_READWRITE:
                cout << "READWRITE";
                break;
            case PAGE_WRITECOPY:
                cout << "WRITECOPY";
                break;
            }

            // 输出页面类型
            cout << "    Type: ";
            switch (memoryInfo.Type)
            {
            case MEM_IMAGE:
                cout << "IMAGE";
                break;
            case MEM_MAPPED:
                cout << "MAPPED";
                break;
            case MEM_PRIVATE:
                cout << "PRIVATE";
                break;
            }

            cout << endl;

            //切换下一页
            block = end;
        }
    }
    cout << "--------------------------------------------" << endl;

    cout << "Press enter to exit" << endl;
    getchar();
    getchar();
    return 0;
}
