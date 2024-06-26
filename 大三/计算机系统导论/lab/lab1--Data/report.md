## 一、实验目的

本实验目的是加强学生对位级运算的理解及熟练使用的能力。

## 二、报告要求

本报告要求学生把实验中实现的所有函数逐一进行分析说明，写出实现的依据，也就是推理过程，可以是一个简单的数学证明，也可以是代码分析，根据实现中你的想法不同而异。

## 三、函数分析

1. bitXor函数

**函数要求：**

函数名 | bitXor
-|-
参数 | int , int
功能实现 | x^y
要求 | 只能使用 ~ 和 & 

**实现分析：**

a^b = \~(\~(a&\~b)&(\~(~a&b)))

**函数实现：**

```C
int bitXor(int x, int y) {
  return ~(~(x&~y)&(~(~x&y)));
}
```



2. getByte函数

**函数要求：**

| 函数名   | getByte                    |
| -------- | -------------------------- |
| 参数     | int , int                  |
| 功能实现 | 在word x中提取第n个字节    |
| 要求     | 只能使用! ~ & ^ \| + << >> |

**实现分析：**

getByte(x,n) = (x>>(n<<3))&0xff

正数在左移时会在右侧补0而负数在右移时会在左侧补1

n<<3得到的是x要右移的位数，x右移结束之后最低位字节即是我们要取的字节，这是再与0xff求交即可把这个字节提取出来

**函数实现：**

```C
int getByte(int x, int n) {
  return (x>>(n<<3))&0xff;
}
```



3. logicalShift函数

**函数要求：**

| 函数名   | logicalShift               |
| -------- | -------------------------- |
| 参数     | int , int                  |
| 功能实现 | 将x向右移n位               |
| 要求     | 只能使用! ~ & ^ \| + << >> |

**实现分析：**

在函数中新定义了两个变量y和z，其中：

变量y实际上是x与0x80000000的按位与，第31位与x相同，其他所有位都是0，也就是说y标记了x的符号位；

变量z用于后面消除负数x右移时补上的1，z是变量y向右移n位再左移1位最后取反，如果x是正数那么z是0xffffffff，如果x是负数则z高n位都是0剩下的是1

最后return时，若x为正数，那么返回的就是x向右移的结果；如果x为负数，那么x右移n位之后，还要想办法把左边补的1消除，那就把它与z按位与

**函数实现：**

```C
int logicalShift(int x, int n) {
    int y = (x & (0xff<<31));
    int z = ~((y>>n)<<0x1);
    return (x>>n) & z;
}
```



4. bitCount函数

**函数要求：**

| 函数名   | bitCount                   |
| -------- | -------------------------- |
| 参数     | int                        |
| 功能实现 | 计算输入字节中为1的bit数   |
| 要求     | 只能使用! ~ & ^ \| + << >> |

**实现分析：**

- 宏观理解：

1. 分组：将输入的32位bit以4bit为一组分为8组
2. 4bit：假设现有一个4位的组abcd，先将他与0001做按位与，那么得到的结果即为d是否为1；同理，将abcd右移，不断地与0001作按位与并将结果与之前的相加，这样最终得到的结果即为这4位中所含有比特1的数量
3. 32bit：将高16位右移16位之后与低16位相加，相当于把8组4bit变为4组4bit，然后把，mask更新为0x0F0F，这样计算出第0组与第2组的1数量；右移4位再计算一遍，这样所有的1的数量都在第0组和第2组4bit中了。之后再把这两组的数量计算出来即可

- 具体实现：

1. 获取mask=0x11111111
2. 计算所有4bit组的结果
3. 将结果移位到低16位
4. 获取mask=0xF0F，并进行移位计算，结果存储在0-3位与8-11位
5. 计算得到最终结果

**函数实现：**

```C
int bitCount(int x) {
    //mask = 0x11111111
    int m1 = 0x11 | (0x11 << 8);
    int mask = m1 | (m1 << 16);

    int s = x & mask;
    s += x>>1 & mask;
    s += x>>2 & mask;
    s += x>>3 & mask;

    s = s + (s >> 16);

    //mask=0xF0F
    mask = 0xF | (0xF << 8);
    s = (s & mask) + ((s >> 4) & mask);
    return (s + (s>>8)) & 0x3F;
}
```



5. conditional函数

**函数要求：**

| 函数名   | conditional                |
| -------- | -------------------------- |
| 参数     | int , int , int            |
| 功能实现 | 实现x ? y : z              |
| 要求     | 只能使用! ~ & ^ \| + << >> |

**实现分析：**

flag变量先将x取逻辑非将其变为0或者1，然后左移31位再右移31位将其格式化，具体是若x为true则flag为0，若x为false则flag为0xffffffff

变量a和b是变量y和z在flag取不同时值时的对应取值，对于变量a，当x为true也就是flag为0时取y，x为false也就是flag为0xffffffff时取y；变量b取法与a相反。

最终变量a与b一定有一个是对应原值，一个是0，将其相加返回即为所需输出

**函数实现：**

```C
int conditional(int x, int y, int z) {
    int flag = !x<<31>>31;
    int a = y & ~flag;
    int b = z & flag;
    return a+b;
}
```



6. tmin函数

**函数要求：**

| 函数名   | tmin                       |
| -------- | -------------------------- |
| 参数     | void                       |
| 功能实现 | 返回最小补码               |
| 要求     | 只能使用! ~ & ^ \| + << >> |

**实现分析：**

最小的补码就是0x10000000嘛，直接返回

**函数实现：**

```C
int tmin(void) {
  return 0x1<<31;
}
```



7. fitsBits函数

**函数要求：**

| 函数名   | fitsBits                            |
| -------- | ----------------------------------- |
| 参数     | int , int                           |
| 功能实现 | 若x能用n个bit表示则返回1，否则返回0 |
| 要求     | 只能使用! ~ & ^ \| + << >>          |

**实现分析：**

整体思路：

若输入x为正数那么其除了n-1位都是0时符合条件；若输入x为负数那么其除了n-1位都是1时符合条件

**函数实现：**

```C
int fitsBits(int x, int n) {
    //mask = 0xFFFFFFFF
    int mask = 0xff+(0xff<<8);
    mask = mask+(mask<<16);

    x = x>>(n+~0);

    return !x | !(x^mask);
}
```



8. dividePower2函数

**函数要求：**

| 函数名   | dividePower2               |
| -------- | -------------------------- |
| 参数     | int , int                  |
| 功能实现 | 计算x/(2^n)，其中0<=n<=30  |
| 要求     | 只能使用! ~ & ^ \| + << >> |

**实现分析：**



**函数实现：**

```C
int dividePower2(int x, int n) {
    //正为1负为0
    int flag = !(x & (1 << 31));
    x = x + (1 << (n & (flag + ~0))) + ~0;
    return x>>n;
}
```



9. negate函数

**函数要求：**

| 函数名   | negate                     |
| -------- | -------------------------- |
| 参数     | int                        |
| 功能实现 | 取相反数                   |
| 要求     | 只能使用! ~ & ^ \| + << >> |

**实现分析：**

直接按位取反加1即可

**函数实现：**

```C
int negate(int x) {
    return ~x+1;
}
```



10. howManyBits函数

**函数要求：**

| 函数名   | howManyBits                |
| -------- | -------------------------- |
| 参数     | int                        |
| 功能实现 | 返回表示x所要用的最小bit数 |
| 要求     | 只能使用! ~ & ^ \| + << >> |

**实现分析：**

先对x异或相邻的数，然后直接求出最高位1即可（因为位数是从0开始，所以最后要加1）

最高位1的求法详解在12.IntLog2

**函数实现：**

```C
int howManyBits(int x) {
    int mask = ~0;
    x ^= (x<<1);
    //求x最高位1的位数
    int n = ((!!(x & (mask << 16))) << 4);
    n += ((!!(x & (mask << (n+8)))) << 3);
    n += ((!!(x & (mask << (n+4)))) << 2);
    n += ((!!(x & (mask << (n+2)))) << 1);
    n += (!!(x & (mask << (n+1))));
    return n+1;
}
```



11. isLessOrEqual函数

**函数要求：**

| 函数名   | isLessOrEqual              |
| -------- | -------------------------- |
| 参数     | int , int                  |
| 功能实现 | 若x<=y则返回1，否则返回0   |
| 要求     | 只能使用! ~ & ^ \| + << >> |

**实现分析：**

这道题看完第一眼觉得应该直接减法得到结果后判断正负，但肯定没有这么简单，还需要考虑溢出的情况：当x和y同号时，二者相减不会发生溢出；当x和y异号时，二者相减可能会发生溢出，但是既然他俩都异号了，可以直接用正负性判断得出结果

**函数实现：**

```C
int isLessOrEqual(int x, int y) {
    int mask = 0x1<<31;
    //在不溢出的情况下是正常的, 但只要溢出了就是0
    int a = x + ~y + 1;
    int flag = !(a & mask);

    //flag1为x正负性，flag2为y正负性，正为1负为0
    int flag1 = !(x & mask);
    int flag2 = !(y & mask);
    
    //若flag1为0是同号，不为0是异号
    int flag3 = flag1 +1 + ~flag2;
    
    flag1 = !flag3&((!a)|(!flag));
    flag2 = flag3&!!(flag3^0x1);

    return flag1|flag2;
}
```



12. intLog2函数

**函数要求：**

| 函数名   | intLog2                    |
| -------- | -------------------------- |
| 参数     | int                        |
| 功能实现 | 计算log2(x)并向下取整      |
| 要求     | 只能使用! ~ & ^ \| + << >> |

**实现分析：**

这个问题的实质是**找最高位的1在哪一位**

求最高位1的步骤：

1. 做掩码mask=0xFFFFFFFF，计数器n初值为0
2. 首先把mask右移16位得到0xFFFF0000，将其与x做按位与运算即可知道其前16位是否有1：若有1，n变为16；若没有1，n还是0
3. 之后把mask右移n+8位，这时得到的有可能是0xFF000000也有可能是0xFFFFFF00，分别搜索的是24-31位与8-15位（因为16-31位已经搜索完是没有1的）。若搜索出来结果有1那么n要加8，否则n大小不变
4. 依次类推

**函数实现：**

```C
int intLog2(int x) {
    //mask = 0xFFFFFFF
    int mask = ~0;
    //若16-31位有1则n+=0x10000, 否则n仍为0
    int n = ((!!(x & (mask << 16))) << 4);
    //根据上一步的结果搜索24-31位或8-15位
    n += ((!!(x & (mask << (n + 8)))) << 3);
    //以此类推...
    n += ((!!(x & (mask << (n + 4)))) << 2);
    n += ((!!(x & (mask << (n + 2)))) << 1);
    n += (!!(x & (mask << (n + 1))));
    return n;
}
```



13. floatAbsVal函数

**函数要求：**

| 函数名   | floatAbsVal                         |
| -------- | ----------------------------------- |
| 参数     | unsigned                            |
| 功能实现 | 返回浮点数f的绝对值                 |
| 要求     | 可以使用运算符, \|\|, &&, if, while |

**实现分析：**

1. 对于一般的浮点数，直接将其与0x7FFFFFF按位与，把符号位变为0即可
2. 对于NaN，若其低23位都是0并且高9位全是1，那么即可证明他是NaN，直接返回即可

**函数实现：**

```C
unsigned floatAbsVal(unsigned uf) {
    if((uf&0x7f800000)>>23 == 255 && uf<<9) return uf;
    return uf & 0x7fffffff;
}
```



14. floatScale1d2函数

**函数要求：**

| 函数名   | floatScale1d2                       |
| -------- | ----------------------------------- |
| 参数     | unsigned                            |
| 功能实现 | 返回0.5*f                           |
| 要求     | 可以使用运算符, \|\|, &&, if, while |

**实现分析：**

1. 若输入为INF和NaN，那么直接返回
2. 若exp>1，保留小数位然后直接把exp-1，阶码也就减少1，达到了*0.5的目的
3. exp<=1，此时若直接把exp-1，那么exp将会小于等于0，实现不了f\*0.5；所以将uf右移1位实现"exp-1"(若exp=1那么将会得exp=0，若exp=0那么exp的值不变)和小数部分的f\*0.5。但是在这里要注意小数的舍入问题，若f的第0位和第1位都是1，那么需要给他加2。

**函数实现：**

```C
unsigned floatScale1d2(unsigned uf) {
    int exp = (uf & 0x7fffffff)>>23;
    int sign = uf & 0x80000000;
    //INF与NaN
    if((uf&0x7fffffff) >= 0x7f800000) return uf;
    //exp > 1
    if(exp > 1)    return (uf&0x807fffff)|(--exp)<<23;
    //exp为0或1
    if((uf&0x3) == 0x3)    uf = uf + 0x2;
    return ((uf>>1)&0xbfffffff)|sign;
}
```



15. floatFloat2Int函数

**函数要求：**

| 函数名   | floatFloat2Int                      |
| -------- | ----------------------------------- |
| 参数     | unsigned                            |
| 功能实现 | 将f转换为int形式                    |
| 要求     | 可以使用运算符, \|\|, &&, if, while |

**实现分析：**

1. 先对输入进行处理得到sign、exp和frac
2. 若exp>32，那么超出范围，返回0x80000000
3. 若exp<0或者uf除了符号位都是0，返回0
4. 根据exp大小将frac左移或右移|exp-23|位，把小数部分转化为整数
5. 判断是否溢出，若溢出则返回0x80000000
6. 如果和原符号相同则直接返回，否则返回补码

**函数实现：**

```C
int floatFloat2Int(unsigned uf) {
    int sign = uf>>31;
    int exp = ((uf&0x7f800000)>>23)-127;
    int frac = (uf&0x007fffff)|0x00800000;
	
    //out of range
    if(exp > 31) return 0x80000000;
    
    if(exp < 0 | !(uf&0x7fffffff)) return 0;

    if(exp > 23) frac <<= (exp-23);
    else frac >>= (23-exp);

    if(!((frac>>31)^sign)) return frac;
    else if(frac>>31) return 0x80000000;
    else return ~frac+1;
}
```



## 四、实验总结

### 困难及解决方法

bitCount那个函数不会写，最终参考了课程PPT中的代码，并最后把这道题弄懂了，具体的思路写在了该函数处

howManyBits与intLog2这两个函数中需要求“一个数为1的最高比特位n”，我想了很长时间都没有想出来该怎样在实验限制的条件内完成，最终去网上借鉴了别人的方法。具体怎么求我写在了intLog2函数处

### 实验建议

实验好难，如果有提示就更好了

还有就是实验环境虚拟机有点卡

