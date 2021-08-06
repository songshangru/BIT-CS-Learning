#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/types.h>
#include <errno.h>
#include <sys/stat.h>
#include <dirent.h>
#include <utime.h>
#include <fcntl.h>

const int buffer_size=1024;

void Change_Attr(char *file_sor,char *file_tar);
void Copy_File(char *file_sor,char *file_tar);
void Copy_Link(char *lnk_sor,char *lnk_tar);
void Copy_Dir(char *dir_sor,char *dir_tar);

char cmd[128];
char his[128][128];
char tmpdir[128];

int switchcmd(char * s)
{
  if(!strncasecmp(s, "cd", 2)) return 1;
  else if(!strncasecmp(s, "ls", 2)) return 2;
  else if(!strncasecmp(s, "pwd", 3)) return 3;
  else if(!strncasecmp(s, "rm", 2)) return 4;
  else if(!strncasecmp(s, "mkdir", 5)) return 5;
  else if(!strncasecmp(s, "mv", 2)) return 6;
  else if(!strncasecmp(s, "cp", 2)) return 7;
  else if(!strncasecmp(s, "exit", 4)) return 8;
  else if(!strcmp(s, "history" )) return 9;
  else return 0;
}

int main(int argc, char ** argv)
{
    memset(his, 0, sizeof(his));
    getcwd(tmpdir,128);
    char b = 'F';
    int choice;
    int count=0;

    while(1)
    {
        memset(cmd, 0, sizeof(cmd));
        printf("%s > ",tmpdir);
        fgets(cmd, 128, stdin);
        cmd[strlen(cmd) - 1] = 0;

        //judge command
        choice = switchcmd(cmd);
        if(choice == 8)
            break;

        //save history
        memset(his[count],0,128);
        strcpy(his[count],cmd);
        count=(count+1)%32;

        switch(choice)
        {
            //cd
            case 1:
            {
                if(chdir(cmd + 3) != 0)
                    printf("chdir[%s] error!%s\n", cmd + 3, strerror(errno));
                else
                    getcwd(tmpdir, 100);
                break;
            }
            //ls
            case 2:
            {
                DIR* dirinfo;
                dirinfo=opendir(".");
                struct dirent *entry;
                while((entry=readdir(dirinfo))!=NULL)
                {
                    if(strcmp(entry->d_name,"..")==0||
                       strcmp(entry->d_name,".")==0)
                        continue;
                    else
                        printf("%s\n",entry->d_name);
                }
                break;
            }
            //pwd
            case 3:
            {
                char * dir;
                dir=get_current_dir_name();
                printf("%s\n",dir);
                break;
            }
            //rm
            case 4:
            {
                if(remove(cmd + 3) != 0)
                    printf("remove[%s] error! %s\n", cmd + 3, strerror(errno));
                break;
            }
            //mkdir
            case 5:
            {
                mkdir(cmd + 6, 0755);
                break;
            }
            //mv
            case 6:
            {
                char *p = strchr(cmd + 3, ' ');
                *p = 0;
                if(rename(cmd + 3, p + 1) != 0)
                    printf("mv[%s] error! %s\n", cmd + 3, strerror(errno));
                break;
            }
            //cp
            case 7:
            {
                char tmp[256];
                char dest[256];
                char src[256];
                strcpy(tmp,cmd);

                char *p2 = strchr(tmp + 3, ' ');
                *p2 = 0; p2++;
                char *p1 = tmp + 3;
                strcpy(src,p1);
                strcpy(dest,p2);

                struct stat statbuf;
                lstat(src,&statbuf);
                if(S_ISDIR(statbuf.st_mode))
                {
                    if(opendir(src)==NULL)
                    {
                        printf("cp[%s] error! couldn't find source\n",src);
                    }
                    else
                    {
                        if(opendir(dest)==NULL)
                            mkdir(dest,statbuf.st_mode);
                        Copy_Dir(src,dest);
                    }
                }
                else
                {

                    Copy_File(src,dest);
                }
                break;
            }
            //exit
            case 8:
            {
                break;
            }
            //history
            case 9:
            {
                int i=0;
                for (i=0;i<32;i++){
                    if(strcmp(his[i],"")==0)
                        continue;
                    else
                        printf("%s\n",his[i]);
                }
                break;
            }
            case 0:
            {
                printf("Bad command.\n");
                break;
            }
        }
    }
    return 0;
}



void Change_Attr(char *file_sor,char *file_tar)
{
    //保存源文件属性信息结构
    struct stat statbuf;
    lstat(file_sor,&statbuf);
    //保存源文件属性信息结构
    chmod(file_tar,statbuf.st_mode);
    //修改文件所有者
    chown(file_tar,statbuf.st_uid,statbuf.st_gid);
    if(S_ISLNK(statbuf.st_mode))
    {
        //修改链接文件访问和修改时间
        struct timeval time_sor[2];
        time_sor[0].tv_sec=statbuf.st_mtime;
        time_sor[1].tv_sec=statbuf.st_ctime;
        lutimes(file_tar,time_sor);
    }
    else
    {
        //修改文件访问和修改时间
        struct utimbuf utime_sor;
        utime_sor.actime=statbuf.st_atime;
        utime_sor.modtime=statbuf.st_mtime;
        utime(file_tar,&utime_sor);
    }
}

void Copy_File(char *file_sor,char *file_tar)
{
    if(access(file_sor, R_OK) != 0)
    {
        printf("cp[%s] error! couldn't find source\n",file_sor);
        return;
    }
    //打开源文件
    int fd_sor=open(file_sor,O_RDONLY);

    //创建目标文件
    int fd_tar=creat(file_tar,O_WRONLY);
    //文件读写
    unsigned char buff[buffer_size];
    int len;
    while((len=read(fd_sor,buff,buffer_size))>0)
    {
        write(fd_tar,buff,len);
    }
    //修改属性
    Change_Attr(file_sor,file_tar);

    close(fd_sor);
    close(fd_tar);

}

void Copy_Link(char *lnk_sor,char *lnk_tar)
{
    unsigned char path[buffer_size];
    //读取软连接内容
    readlink(lnk_sor,path,buffer_size);
    //复制内容到目标链接文件
    symlink(path,lnk_tar);
    //修改属性
    Change_Attr(lnk_sor,lnk_tar);
}

void Copy_Dir(char *dir_sor,char *dir_tar)
{
    //打开文件
    DIR *pd_sor=opendir(dir_sor);
    struct dirent *entry_sor=NULL;
    struct stat statbuf;
    while((entry_sor=readdir(pd_sor)))
    {
        //跳过当前目录和上级目录
        if(strcmp(entry_sor->d_name,".")==0||
           strcmp(entry_sor->d_name,"..")==0)
            continue;

        char ts[buffer_size],tt[buffer_size];
        strcpy(ts,dir_sor);
        strcat(ts,"/");
        strcat(ts,entry_sor->d_name);
        strcpy(tt,dir_tar);
        strcat(tt,"/");
        strcat(tt,entry_sor->d_name);
        //保存源文件属性信息结构
        lstat(ts,&statbuf);
        if(S_ISLNK(statbuf.st_mode))
        {
            Copy_Link(ts,tt);
        }
        else if(S_ISDIR(statbuf.st_mode))
        {

            mkdir(tt,statbuf.st_mode);
            Copy_Dir(ts,tt);
        }
        else if(S_ISREG(statbuf.st_mode))
        {
            Copy_File(ts,tt);
        }
    }
    Change_Attr(dir_sor,dir_tar);
}
