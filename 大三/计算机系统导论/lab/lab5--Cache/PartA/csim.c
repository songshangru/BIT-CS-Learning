/*
 * name : Bowen Liu
 * ID	: 1120201883
*/ 
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <getopt.h>
#include <unistd.h>
#include "cachelab.h"
#define ADDRLEN 64  //地址长度64位
#define MAXS  128    //最多有128个Set
// (tag)   (set index: s bit)  (offset: b bit)

//存储访问相关信息的结构体
struct Access{
	char type;		//访问类型
	long address;	//访问地址
	int size;		//一次访问大小
};

typedef struct{
    int valid;
    long tag;
    int stamp;	//时间戳，实现LRU
}Cache_Line, *Cache_Set, **Cache;

// 全局定义的参数变量
int h=0,v=0;
// tag, set index, offset的位数
int t=0,s=0,b=0;
// set, line, byte数
int S=0,E=0,B=0;
// 要输出的hit miss eviction数
int hit_count=0, miss_count=0, eviction_count=0;
// 输入文件路径
char tracefile[100];
// 全局可访问的Cache指针
Cache cache = NULL;

// 获取参数
void GetArgs(int argc,char** argv,char* optString);
// 打印参数(只在debug时有用)
void PrintArgs();
// 根据全局变量创建缓存
void CreateCache();
// 获取文件中的输入, 获取成功返回1，失败0
int GetInput(FILE *fp,char* input);
// 解析原始输入，获取我们想要的信息也就是struct Access
void Parser(char* input,struct Access * access);
// 打印Cache相关信息用于Debug
void PrintCache();
// 根据结构体Access进行处理
void Process(struct Access access);
void CacheRead(long address);
// 更新时间戳，以实现LRU
void UpdateStamp();


int main(int argc,char** argv){
	//获取参数详情
    GetArgs(argc,argv,"hvs:E:b:t:");
	//PrintArgs();
    CreateCache();
	FILE *fp = fopen(tracefile,"r");
	char input[25];
	struct Access access;
	while(GetInput(fp,input)){
		Parser(input,&access);
		Process(access);
	}
	free(cache);
	printSummary(hit_count, miss_count, eviction_count);
    return 0;
}

void GetArgs(int argc,char** argv,char* optString){
	int arg;
	opterr = 0;
	while((arg = getopt(argc,argv,optString)) != -1){
		switch(arg){
			case 'h':
				h = 1;
				break;	
			case 'v':
				v = 1;
				break;
			case 's':
				s = optarg[0] - 0x30;
				break;
			case 'E':
				E = optarg[0] - 0x30;
				break;
			case 'b':
				b = optarg[0] - 0x30;
				break;
			case 't':
				strcpy(tracefile,optarg);
		}
	}
	S = 2<<(s-1);
	B = 2<<(b-1);
	t = 64-s-b;
}

void PrintArgs(){
	printf("h = %d, v = %d\n",h,v);
	printf("s = %d, E = %d, b = %d\n",s,E,b);
	printf("tracefile = %s\n",tracefile);
}

void CreateCache(){
	//多维数组的开辟要一行行malloc
    cache = (Cache)malloc(sizeof(Cache_Set) * S); 
	for(int i = 0; i < S; ++i)
	{
		cache[i] = (Cache_Set)malloc(sizeof(Cache_Line) * E);
		for(int j = 0; j < E; ++j)
		{
			cache[i][j].valid = 0;
			cache[i][j].tag = -1;
			cache[i][j].stamp = -1;
		}
	}

}

int GetInput(FILE *fp,char* input){
	if (fgets(input,25,fp)!=NULL){
		return 1;
	}else{
		fclose(fp);
		return 0;
	}
}

void Parser(char* input,struct Access * access){
	char temp;
	sscanf(input,"%c%c %lX,%d",&temp,&access->type,&access->address,&access->size);
	//printf("%c %lX %d\n",access->type,access->address,access->size);
}

void Process(struct Access access){
	switch (access.type)
	{
		case 'L':
			CacheRead(access.address);
			break;
		case 'M':
			CacheRead(access.address);
			CacheRead(access.address);
			break;
		case 'S':
			CacheRead(access.address);
			break;
		default:
			break;
	}
}

void CacheRead(long address){

	//PrintCache();
	// 用位运算获取tag与set index
	long tag = address >> (b + s);
	int set_index = (address >> b) & ((-1U) >> (64 - s));
	//printf("tag = %ld, set index = %d\n",tag,set_index);
	UpdateStamp();
	// 检查是否命中
	for(int i = 0; i < E; ++i){
		if(cache[set_index][i].tag == tag){
			cache[set_index][i].stamp = 0;
			++hit_count;
			return;
		}
	}

	// 丢失,优先更新空行
	for(int i = 0; i < E; ++i){
		if(cache[set_index][i].valid == 0){
			cache[set_index][i].valid = 1;
			cache[set_index][i].tag = tag;
			cache[set_index][i].stamp = 0;
			++miss_count;
			return ;
		}
	}

	// 替换,LRU
	++eviction_count;
	++miss_count;
	int max_stamp = -1;
	int max_stamp_index = -1;
	for(int i = 0; i < E; ++i){
		if(cache[set_index][i].stamp > max_stamp){
			max_stamp = cache[set_index][i].stamp;
			max_stamp_index = i;
		}
	}
	cache[set_index][max_stamp_index].tag = tag;
	cache[set_index][max_stamp_index].stamp = 0;
}


void UpdateStamp(){
	for(int i = 0; i < S; ++i)
		for(int j = 0; j < E; ++j)
			if(cache[i][j].valid == 1)
				++cache[i][j].stamp;
}

void PrintCache(){
	for(int i = 0; i < S; ++i)
		for(int j = 0; j < E; ++j)
			printf("%d set, %d line:valid:%d tag:%ld stamp:%d\n",i,j,cache[i][j].valid,cache[i][j].tag,cache[i][j].stamp);
}