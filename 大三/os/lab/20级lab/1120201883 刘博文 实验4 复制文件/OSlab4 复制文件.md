# OSlab4 复制文件

说明：

在Linux平台上做。

Linux： mkdir,opendir,readdir,symlink,readlink等系统调用

## 三、实验步骤（或三、程序设计与实现）（黑体四号字）

### 实验分析

这个实验相当于是要求我们自己完成一个cp命令，那么要自己完成一个"mycp"命令，就应该先看看linux自带的cp命令有什么样的功能，cp命令语法：

```shell
cp [-options] source_file dest_file
```

cp命令参数：



可以看到cp命令有着非常多的参数，逐个实现有些过于费劲而且其中很多重复工作感觉也是没有必要的，所以我根据我的使用体验也就是我平时使用cp命令附带的最多的参数来调整我自己的mycp命令：默认带有-a, -f这两个个参数，也就是会**支持复制目录**，并在在复制目录时**保留链接、文件属性，默认覆盖重复文件**。





需要用到的函数和结构体：

### 结构体DIR

```c
struct __dirstream   
{   
    void *__fd;    
    char *__data;    
    int __entry_data;    
    char *__ptr;    
    int __entry_ptr;    
    size_t __allocation;    
    size_t __size;    
	 __libc_lock_define (, __lock)    
};   
typedef struct __dirstream DIR;  
```

结构体是目录的抽象结构体定义

### 结构体dirent

```c
struct dirent   
{   
    //索引节点号
    long d_ino;
　　 //在目录文件中的偏移
    off_t d_off; 
    //文件名长
    unsigned short d_reclen;
    //文件类型
    unsigned char d_type;
    //文件名，最长255字符
    char d_name [NAME_MAX+1]; 
}  
```

### 结构体stat

```c
struct stat {   
        mode_t     st_mode;       //文件访问权限   
        ino_t      st_ino;       //索引节点号   
        dev_t      st_dev;        //文件使用的设备号   
        dev_t      st_rdev;       //设备文件的设备号   
        nlink_t    st_nlink;      //文件的硬连接数   
        uid_t      st_uid;        //所有者用户识别号   
        gid_t      st_gid;        //组识别号   
        off_t      st_size;       //以字节为单位的文件容量   
        time_t     st_atime;      //最后一次访问该文件的时间   
        time_t     st_mtime;      //最后一次修改该文件的时间   
        time_t     st_ctime;      //最后一次改变该文件状态的时间   
        blksize_t st_blksize;    //包含该文件的磁盘块的大小   
        blkcnt_t   st_blocks;     //该文件所占的磁盘块   
};  
```

### 函数stat

```c
int stat(const char *path, struct stat *buf);
```

获取参数path指向文件或目录的信息，并将其保存在参数buf中。成功返回0，失败返回-1

### 函数opendir

```c
DIR * opendir(const char * addr);
```

打开路径为addr的一个文件，成功则返回该文件的DIR，不成功则返回NULL

### 函数readdir

```c
struct dirent *readdir(DIR *dir);  
```

返回参数dir目录流的下个目录进入点，若有错误发生或读取到目录文件尾则返回NULL

### 函数mkdir

```c
int mkdir(const char *pathname, mode_t mode);
```

以参数mode方式创建一个以参数pathname命名的目录，mode定义新创建目录的权限

返回0表示成功，返回-1表示错误

### 函数open

```c
int open(const char *pathname, int flag);
```

以参数flag(O_RDONLY, O_WRONLY, O_RDWR)方式打开参数pathname指向的文件，返回文件描述符

### 函数readlink

```c
ssize_t readlink(const char *path, char *buf, size_t bufsiz);
```

将参数path的符号连接内容到参数buf所指的内存空间，返回的内容不是以NULL作字符串结尾，但会将字符串的字符数返回。若参数bufsiz小于符号连接的内容长度，过长的内容会被截断

### 函数symlink

```c
int symlink(const char * oldpath, const char * newpath);
```

以参数newpath指定的名称来建立一个新的连接(符号连接)到参数oldpath所指定的已存在文件。参数oldpath指定的文件不一定要存在, 如果参数newpath指定的名称为一已存在的文件则不会建立连接

### 函数lstat

```c
int lstat(const char *pathname, struct stat *buf);
```

对于普通文件，函数lstat与函数stat相同；对于链接文件，lstat函数会获取链接文件本身的属性信息而stat函数会获取链接文件指向的文件的属性信息

### 函数chmod

```c
int chmod(const char *path, mode_t mode);
```

以参数mode的权限来更新参数path指定文件的权限

### 函数chown

```c
int chown(const char *path, uid_t owner, gid_t group);
```

将参数path指定文件的所有用户与组改成参数owner与参数group

### 结构体timaval

```c
struct timeval {
    //秒
	long tv_sec;
    //毫秒
	long tv_usec;
};
```

### 函数lutimes

```c
int lutimes(const char *filename, const struct timeval tv[2]);
```

用于修改软连接文件的属性，修改参数filename指定的文件的时间，参数tv[0]是访问时间，tv[1]是修改时间

### 结构体utimbuf

```c
struct utimbuf {
    //最后访问时间
	time_t actime;
    //最后修改时间
	time_t modtime;
};
```

### 函数utime

```c
int utime(const char *path, const struct utimbuf *times);
```

将参数path指定文件的访问和修改时间修改为参数times所指定的内容





1. 检测输入的参数个数和是否正确，若正确则调用copy函数开始复制
2. 遍历源目录下所有的目录与文件，并根据种类进行不同的处理：
   - 目录文件：递归调用copy函数复制该目录及该目录下的所有文件
   - 软链接文件：调用copyLink函数复制该链接文件
   - 普通文件：调用copyFile函数复制该文件
3. 在复制时还要保持文件的一些属性不变，比如权限、所属用户与组、最后访问时间与修改时间等





### PS:

注意跳过目录..和.

## 四、实验结果及分析（黑体四号字）

小四号宋体字

 

 

## 五、实验收获与体会（黑体四号字）

小四号宋体字

 