#include<stdio.h>
#include<stdlib.h>
#include<Windows.h>
#include<Windowsx.h>
#include<string.h>

const int buff_size=1024*4;

void Change_Attr(char *sor,char *tar,HANDLE hsor,HANDLE htar)
{
    DWORD attr=GetFileAttributes(sor);
    SetFileAttributes(tar,attr);

    FILETIME t_cre,t_acc,t_wri;
    GetFileTime(hsor,&t_cre,&t_acc,&t_wri);
    SetFileTime(htar,&t_cre,&t_acc,&t_wri);
}

void Copy_File(char *file_sor,char *file_tar)
{
    //��Դ�ļ�
    HANDLE hsor=CreateFile(file_sor,          //源文件路径
                           GENERIC_READ,      //只读访问
                           FILE_SHARE_READ,   //共享读
                           NULL,              //默认安全
                           OPEN_EXISTING,     //打开已存在的文件
                           FILE_ATTRIBUTE_NORMAL|FILE_FLAG_BACKUP_SEMANTICS,
                           NULL);
    //����Ŀ���ļ�
    HANDLE htar=CreateFile(file_tar,          //源文件路径
                           GENERIC_READ|GENERIC_WRITE,  //读写访问
                           FILE_SHARE_READ,   //共享读
                           NULL,              //默认安全
                           CREATE_ALWAYS,     //创建新文件
                           FILE_ATTRIBUTE_NORMAL|FILE_FLAG_BACKUP_SEMANTICS,
                           NULL);
    if(htar==INVALID_HANDLE_VALUE)
        printf("%s error\n",file_sor);

    char buff[buff_size];
    DWORD tp=0;  //记录每次读取的数据长度
    while(ReadFile(hsor,buff,buff_size,&tp,NULL))
    {
        WriteFile(htar,buff,tp,&tp,NULL);
        if(tp<buff_size)
            break;
    }

    Change_Attr(file_sor,file_tar,hsor,htar);

    CloseHandle(hsor);
    CloseHandle(htar);
}

void Copy_Dir(char *dir_sor,char *dir_tar)
{
    char ts[buff_size],tt[buff_size];
    strcpy(ts,dir_sor);
    strcat(ts,"\\*.*");
    WIN32_FIND_DATA lffd;
    HANDLE hfile=FindFirstFile(ts,&lffd);
    while(FindNextFile(hfile,&lffd))
    {
        if(strcmp(lffd.cFileName,".")==0||strcmp(lffd.cFileName,"..")==0)
            continue;
        strcpy(ts,dir_sor);
        strcat(ts,"\\");
        strcat(ts,lffd.cFileName);
        strcpy(tt,dir_tar);
        strcat(tt,"\\");
        strcat(tt,lffd.cFileName);
        if(lffd.dwFileAttributes==FILE_ATTRIBUTE_DIRECTORY)
        {
            CreateDirectory(tt,NULL);
            Copy_Dir(ts,tt);
        }
        else
        {
            Copy_File(ts,tt);
        }
    }
    HANDLE hsor=CreateFile(dir_sor,
                           GENERIC_READ|GENERIC_WRITE,
                           FILE_SHARE_READ,
                           NULL,
                           OPEN_ALWAYS,
                           FILE_ATTRIBUTE_NORMAL|FILE_FLAG_BACKUP_SEMANTICS,
                           NULL);
    HANDLE htar=CreateFile(dir_tar,
                           GENERIC_READ|GENERIC_WRITE,
                           FILE_SHARE_READ,
                           NULL,
                           OPEN_ALWAYS,
                           FILE_ATTRIBUTE_NORMAL|FILE_FLAG_BACKUP_SEMANTICS,
                           NULL);
    Change_Attr(dir_sor,dir_tar,hsor,htar);
    CloseHandle(hsor);
    CloseHandle(htar);
    CloseHandle(hfile);
}

int main(int argc,char *argv[])
{
    if(argc!=3)
    {
        printf("input error\n");
        return 0;
    }
    WIN32_FIND_DATA lffd;
    if(FindFirstFile(argv[1],&lffd)==INVALID_HANDLE_VALUE)
    {
        printf("couldn't find source\n");
        return 0;
    }
    if(lffd.dwFileAttributes==FILE_ATTRIBUTE_DIRECTORY)
    {
        if(FindFirstFile(argv[2],&lffd)==INVALID_HANDLE_VALUE)
        {
            CreateDirectory(argv[2],NULL);
        }
        Copy_Dir(argv[1],argv[2]);
    }
    return 0;
}
