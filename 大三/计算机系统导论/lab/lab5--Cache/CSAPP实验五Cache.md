# CSAPP实验五:Cache

## Part A

在这个Part中我们要写一个"Cache"，但是仔细分析实验的需求，我们只需要输出正确的hit, miss, eviction数即可，那么也就可以知道，我们不需要**真的对数据做Load等操作，只需要根据地址来模拟即可**

所以L和S操作就没有什么区别，我们要做的就是根据*tag*和*set index*检查是否hit, miss或eviction；而M操作也就等价于一次L操作和一次S操作

源码在csim.c中

### 问题建模

1. 首先我们要获取控制台中的参数：-s -E -b -t
2. 然后我们要为Cache分配空间
3. 打开-t参数对应文件，按行读入并解析
4. 解析得到访问相关的数据，根据这些数据进行cache操作

### 全局变量与结构体、函数定义

因为题目中说地址为64位，那么address的类型为long，tag的类型保险起见也为long

对于cache，我认为它是一个**由一个个Line组成的二位数组**，其中的**每一行对应一个Set，每个元素对应一个Line**

```c
#define ADDRLEN 64  //地址长度64位
#define MAXS  128    //最多有128个Set
// (tag)   (set index: s bit)  (offset: b bit)

//存储访问相关信息的结构体
struct Access{
	char type;		//访问类型
	long address;	//访问地址
	int size;		//一次访问大小
};

// 实际上这是一个定义Line的结构体
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
// 获取文件中的输入，获取成功返回1，失败0
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
```

### main函数

个人认为这个main函数写的比较好理解，其中涉及的函数的作用在注释里也写的比较明白了

```c
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
```

### Update函数

因为我们不需要关注数据是否真的读写到我们的这个"cache"中就能完成这个part，所以Load操作和Store对我们而要都只是在检测Cache中有没有该数据，也就是**都等同于一次Cache读操作**；Modify操作稍微特别一点，因为要修改，所以是先Load再Store，那也就是相当于两次Cache读操作

1. 首先要先从address获取set index与tag，并更新每个line的时间戳
2. 根据set index确定要检查的cache set
3. 根据tag遍历set中的每个line，若找到即hit，return
4. 若没找到则miss，先遍历该set寻找是否有空line，若有空line则更新空line
5. 若无空line则需要eviction，遍历该set，淘汰stamp最大的line

```c
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
```



## Part B

### 实验规则

1. 最多使用12个局部变量
2. 不可以使用递归
3. 不可以修改数组A
4. 不能定义任何数组，不能使用malloc函数
5. $s =5,E=1,b=5$，也就是$C=1024$，一个set中有一个块，可以存储**8个int数据**

矩阵转置与

### 1. 针对$32 \times 32 (M=32, N=32)$的矩阵

#### 优化策略

采取**分块**矩阵，每个Block的大小为$B\times B$，为了实现好的优化，要有$2B^2<C/4$，那么合适的$B$取值为8（取32的因子会比较好操作）

这里我一开始尝试最内层循环是这样的：

```c
for(int jj=j;jj<j+8;j++){
    B[ii][jj] = A[jj][ii];
}
```

但是这样评测出来的结果miss数约为350，所以需要继续提升他的局部性，我的到得到了下面的代码:

```c
int temp0,temp1,temp2,temp3,temp4,temp5,temp6,temp7;
for(int i=0;i<M;i+=8){
	for(int j=0;j<N;j+=8){
		for(int k=i;k<i+8;k++){
			temp0 = A[j+0][k];
            temp1 = A[j+1][k];
            temp2 = A[j+2][k];
            temp3 = A[j+3][k];
            temp4 = A[j+4][k];
            temp5 = A[j+5][k];
            temp6 = A[j+6][k];
            temp7 = A[j+7][k];
            B[k][j+0] = temp0;
            B[k][j+1] = temp1;
            B[k][j+2] = temp2;
            B[k][j+3] = temp3;
            B[k][j+4] = temp4;
            B[k][j+5] = temp5;
            B[k][j+6] = temp6;
            B[k][j+7] = temp7;
		}
}
```

#### 优化效果

miss数从1183下降到287：

![image-20221129105802271](https://lbw-img-lbw.oss-cn-beijing.aliyuncs.com/img/image-20221129105802271.png)

#### 原因分析

我第一次尝试得到的代码很容易写出来，因为只要采取了分块的思想，就能写出这样的代码；但是效果不够达到满分，因为矩阵A和矩阵B同一位置的元素是映射到同一个Line上的，也就是说如果直接写循环会造成很多冲突不命中。所以我用8个局部变量一次读8个A中元素，再一口气写到B中，就又能提升命中数

### 2. 针对$64 \times 64 (M=64, N=64)$的矩阵

#### 优化策略

这个矩阵大小是第一个矩阵大小的4倍，我一开始觉得它的优化思路与前一题一样，但是我在对这个矩阵尝试以8为长度分块时，并没有得到很好的优化效果，miss数只比按行转置少一丢丢

那这个时候就要转换优化策略了，但是除了分块之外我个人想不出什么比较好的优化策略。思考一段时间不得之后我就去网上搜索解决的方案，发现一个可行的方案是：**在八分块中再四分块**

那么就遵循这个思路进行优化，先写一个八分块的循环；然后再从八分块中进行一次8分块和两次4分块处理：

```c
		int i, j, x, y;
		int temp0,temp1,temp2,temp3,temp4,temp5,temp6,temp7;
		for (i = 0; i < N; i += 8){
			for (j = 0; j < M; j += 8){
				for (x = i; x < i + 4; ++x){
					temp0 = A[x][j]; 
                    temp1 = A[x][j+1]; 
                    temp2 = A[x][j+2]; 
                    temp3 = A[x][j+3];
					temp4 = A[x][j+4]; 
                    temp5 = A[x][j+5]; 
                    temp6 = A[x][j+6]; 
                    temp7 = A[x][j+7];
					
					B[j][x] = temp0; 
                    B[j+1][x] = temp1; 
                    B[j+2][x] = temp2; 
                    B[j+3][x] = temp3;
					B[j][x+4] = temp4; 
                    B[j+1][x+4] = temp5; 
                    B[j+2][x+4] = temp6; 
                    B[j+3][x+4] = temp7;
				}
				for (y = j; y < j + 4; ++y){
					temp0 = A[i+4][y]; 
                    temp1 = A[i+5][y]; 
                    temp2 = A[i+6][y]; 
                    temp3 = A[i+7][y];
					temp4 = B[y][i+4]; 
                    temp5 = B[y][i+5]; 
                    temp6 = B[y][i+6]; 
                    temp7 = B[y][i+7];
					
					B[y][i+4] = temp0; 
                    B[y][i+5] = temp1; 
                    B[y][i+6] = temp2; 
                    B[y][i+7] = temp3;
					B[y+4][i] = temp4; 
                    B[y+4][i+1] = temp5; 
                    B[y+4][i+2] = temp6; 
                    B[y+4][i+3] = temp7;
				}
				for (x = i + 4; x < i + 8; ++x){
					temp0 = A[x][j+4]; 
                    temp1 = A[x][j+5]; 
                    temp2 = A[x][j+6]; 
                    temp3 = A[x][j+7];
					B[j+4][x] = temp0; 
                    B[j+5][x] = temp1; 
                    B[j+6][x] = temp2; 
                    B[j+7][x] = temp3;
				}
			}
        }
```

#### 优化效果

miss数从4723下降到1179：

![image-20221129105422113](https://lbw-img-lbw.oss-cn-beijing.aliyuncs.com/img/image-20221129105422113.png)

### 3. 针对$61 \times 67 (M=61, N=67)$的矩阵

#### 优化策略

仍然跟前面一样，先尝试以8为长度分块

但是与前面不一样的是，之前以8为长度分块可以正好分完，但是现在不行；所以需要在8分块之后继续进行转置：

```c
int i,j,temp0,temp1,temp2,temp3,temp4,temp5,temp6,temp7;
        // 8分块
		for (j = 0; j < 56; j += 8){
			for (i = 0; i < 64; ++i){
				temp0 = A[i][j];
				temp1 = A[i][j+1];
				temp2 = A[i][j+2];
				temp3 = A[i][j+3];
				temp4 = A[i][j+4];
				temp5 = A[i][j+5];
				temp6 = A[i][j+6];
				temp7 = A[i][j+7];
				
				B[j][i] = temp0;
				B[j+1][i] = temp1;
				B[j+2][i] = temp2;
				B[j+3][i] = temp3;
				B[j+4][i] = temp4;
				B[j+5][i] = temp5;
				B[j+6][i] = temp6;
				B[j+7][i] = temp7;
			}
        }

        // 直接转置 
		for (i = 0; i < N; ++i){
            for (j = 56; j < M; ++j){
				temp0 = A[i][j];
				B[j][i] = temp0;
			}
        }

		for (i = 64; i < N; ++i){
            for (j = 0; j < M; ++j){
				temp0 = A[i][j];
				B[j][i] = temp0;
			}
        }

        for (i = 64; i < N; ++i){
            for (j = 56; j < M; ++j){
				temp0 = A[i][j];
				B[j][i] = temp0;
			}
        }
```

#### 优化效果

miss数从4432降低到1904：

![image-20221129101159125](https://lbw-img-lbw.oss-cn-beijing.aliyuncs.com/img/image-20221129101159125.png)

#### 原因分析

这个矩阵得到优化的矩阵和第一个矩阵一样，都是因为分块。该矩阵其中$56\times64$的部分使用8分块，其他部分直接转置；直接转置造成的miss数会相对多一些，但好在8分块对转置的优化已经足以让这个实验拿到满分了，不需要再进行什么优化。































