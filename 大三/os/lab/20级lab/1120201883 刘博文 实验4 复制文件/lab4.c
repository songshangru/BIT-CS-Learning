#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <dirent.h>
#include <unistd.h>
#include <string.h>
#include <libgen.h>
#include <fcntl.h>
#include <utime.h>

//buffer大小
#define BUFFER_SIZE 1024
//linux路径最大长度
#define MAXL 4096


//把一个目录递归地复制到另一个目录下
void copy(char* source,char *target);
//把一个文件复制到另一个目录下
void copyFile(char* file,char* target);
//复制链接文件
void copyLink(char* source,char* target);
//赋值文件属性
void copyAttribute(char* source,char* target);


int main(int argc,char *argv[]){
	//检查参数个数
	if(argc!=3){
		printf("Number of Prameter is Wrong!\n");
		return -1;
	}

	char* source = argv[1];
	char* target = argv[2];
	
	//检查源目录和目标目录是否存在
	if(!(access(source,F_OK)||access(target,F_OK))){
		struct stat srcStat;
		struct stat tgtStat;
		if(!(stat(source,&srcStat)||stat(target,&tgtStat))){
			//确定输入路径是目录还是文件
			if(S_ISDIR(srcStat.st_mode)){
				copy(source,target);
			}else{
				copyFile(source,target);
			}
		}else{
			printf("Error!\n");
		}
	}else{
		printf("Parameter Error!\n");
	}

	return 0;
}

//把一个目录递归地复制到另一个目录下
void copy(char* source,char* target){

	//先在目标目录下创建目录
	//注意此操作会 更改target 
	int len = strlen(target) + strlen(basename(source)) +2;
	char result[len];
	strcpy(result,target);
	strcat(result,basename(source));
	target = result;
	//printf("%s %s\n",source,target);
	mkdir(target,0755);
	
	DIR * dir = opendir(source);
	struct dirent* drt;

	while((drt=readdir(dir))!=NULL){
		
		if(drt->d_type == DT_DIR){
			//排除./和../
			if(!(strcmp(".",drt->d_name)&&strcmp("..",drt->d_name)))  continue;
			
			//源子目录字符串处理
			len = strlen(source) + strlen(drt->d_name)+4;
			char nextSrc[len];
			strcpy(nextSrc,source);
			strcat(nextSrc,"/");
			strcat(nextSrc,drt->d_name);
			strcat(nextSrc,"/");

			//目标目录字符串处理
			len = strlen(target) +2;
			char nextTgt[len];
			strcpy(nextTgt,target);
			strcat(nextTgt,"/");

			//printf("%s %s\n",nextSrc,nextTgt);
			copy(nextSrc,nextTgt);
		}else if(drt->d_type == DT_LNK){

			//源文件路径字符串处理
			len = strlen(source) + strlen(drt->d_name)+3;
			char nextSrc[len];
			strcpy(nextSrc,source);
			strcat(nextSrc,"/");
			strcat(nextSrc,drt->d_name);

			//目标文件路径字符串处理
			len = strlen(target) + strlen(drt->d_name)+3;
			char nextTgt[len];
			strcpy(nextTgt,target);
			strcat(nextTgt,"/");
			strcat(nextTgt,drt->d_name);

			copyLink(nextSrc,nextTgt);
		}else{
			//源文件路径字符串处理
			len = strlen(source) + strlen(drt->d_name)+3;
			char nextSrc[len];
			strcpy(nextSrc,source);
			strcat(nextSrc,"/");
			strcat(nextSrc,drt->d_name);

			//目标文件路径字符串处理
			len = strlen(target) + strlen(drt->d_name)+3;
			char nextTgt[len];
			strcpy(nextTgt,target);
			strcat(nextTgt,"/");
			strcat(nextTgt,drt->d_name);

			//printf("%s %s\n",nextSrc,nextTgt);
			copyFile(nextSrc,nextTgt);
		}
	}	
	//最后复制文件夹的访问与修改时间
	copyAttribute(source,target);
}


void copyFile(char* file,char* target){
	
	int srcFD = open(file,O_RDONLY);
	int tgtFD = creat(target,O_WRONLY);

	//检查文件是否被正确打开或创建
	if(!((srcFD==-1)||(tgtFD==-1))){

		//复制文件
		unsigned char buf[BUFFER_SIZE];
    	int len = 0;
		while((len=read(srcFD,buf,BUFFER_SIZE))>0){
        	write(tgtFD,buf,len);
    	}
    	
		//复制属性
    	copyAttribute(file,target);
		
		//关闭文件
    	close(srcFD);
    	close(tgtFD);
	}else{
		printf("Open File Error!\n");
	}
}

//复制链接文件
void copyLink(char* source,char* target){
	unsigned char buf[MAXL];
    //读取链接文件内容
    readlink(source,buf,MAXL);
    //复制链接文件内容到目标链接文件
    symlink(buf,target);
    //复制属性
    copyAttribute(source,target);
}

//复制文件属性
void copyAttribute(char* source,char* target){
	//保存源文件属性信息结构
    struct stat srcStat;
    lstat(source, &srcStat);
    //保存源文件属性信息结构
    chmod(target,srcStat.st_mode);
    //修改文件所有者
    chown(target,srcStat.st_uid,srcStat.st_gid);
    if(S_ISLNK(srcStat.st_mode)){
        //修改链接文件访问和修改时间
        struct timeval timeVal[2];
		//访问时间
        timeVal[0].tv_sec = srcStat.st_atime;
		//修改时间
        timeVal[1].tv_sec = srcStat.st_mtime;
        lutimes(target,timeVal);
    }else{
	    //修改文件访问和修改时间
        struct utimbuf timeBuf;
		//访问时间
        timeBuf.actime = srcStat.st_atime;
		//修改时间
        timeBuf.modtime = srcStat.st_mtime;
        utime(target,&timeBuf);
    }
}
