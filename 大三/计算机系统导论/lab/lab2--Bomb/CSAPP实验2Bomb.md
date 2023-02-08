# CSAPP实验2:Bomb

## phase 1

phase_1函数汇编代码:

<img src="https://lbw-img-lbw.oss-cn-beijing.aliyuncs.com/img/image-20221010195213146.png" alt="image-20221010195213146" style="zoom:50%;" />

这段汇编代码非常之短，而且其中的函数"strings_not_equal"的作用在名字里就写的非常明白了；尝试一下400e71行的地址: 0x4023d0，结果直接输出了字符串"Slave, thou hast slain me. Villain, take my purse." 那么这应该就是答案，直接输入即可



## phase 2

phase_2函数汇编代码:

<img src="https://lbw-img-lbw.oss-cn-beijing.aliyuncs.com/img/image-20221010161933583.png" alt="image-20221010161933583" style="zoom:50%;" />

简单观察这段代码，注意到"phase_2"函数还引用了一个名为"read_six_numbers"的函数，猜测与读取我们的输入有关，于是查看该函数的汇编代码:

<img src="https://lbw-img-lbw.oss-cn-beijing.aliyuncs.com/img/image-20221010162204339.png" alt="image-20221010162204339" style="zoom:50%;" />

果然这段代码有对输入的判断，甚至还会调用"explode_bomb"引爆炸弹。并且在401486行看到一个比较明显的地址0x4025c3，读出其内容为：<img src="https://lbw-img-lbw.oss-cn-beijing.aliyuncs.com/img/image-20221010165816292.png" alt="image-20221010165816292" style="zoom:50%;" />

看到这就知道函数"read_six_numbers"的任务是读取6个整数，那么我们的输入也应该是6个整数，重新调试程序，尝试输入：7 8 9 10 11 12，继续调试

进入scanf前的所有寄存器值：<img src="https://lbw-img-lbw.oss-cn-beijing.aliyuncs.com/img/image-20221010172241480.png" alt="image-20221010172241480" style="zoom: 33%;" />

完成scanf后：<img src="https://lbw-img-lbw.oss-cn-beijing.aliyuncs.com/img/image-20221010185135182.png" alt="image-20221010185135182" style="zoom: 33%;" />

scanf完成后，一些寄存器的值产生了变动，读取从，发现他们被存储在从0x7fffffffe790(%rsp)到0x7fffffffe7a4(%rdx)的区间：

![image-20221010184906981](https://lbw-img-lbw.oss-cn-beijing.aliyuncs.com/img/image-20221010184906981.png)

那么到这里我们已经弄懂了rsp这个寄存器所存储的到底是什么值——我们的输入

那么回到函数"phase_2"，程序会对输入的第一个值进行判断，若其小于0，则炸弹直接爆炸；之后从400eae行开始进入循环，寄存器ebx存储的值即是循环的计数器，取值从1到6并在取值达到6时退出循环；这个题解题的关键在于400ec6-400ecc三行汇编。因为ebx是循环的计数器，**在下面以i代指他的值**

```assembly
  # 将ebx的值赋给eax, 也就是说eax这里的值即为i
  400ec6:	89 d8                	mov    %ebx,%eax
  # eax的大小是i这都没问题, 而-0x4(%rsp,%rbx,4)即是M[R(rsp)+4*(i-1)], 也就是我们输入的第i个值
  # 那么，这一行代码的意思就是eax += 输入的第i个值
  400ec8:	03 44 9c fc          	add    -0x4(%rsp,%rbx,4),%eax
  # 判断eax是否与输入的第i+1个值相等 
  400ecc:	39 04 9c             	cmp    %eax,(%rsp,%rbx,4)
  # 总结, 最后判断的是: 输入的第i+1个值  是否与  i+输入的第i个值  相等
```

所以，只要我们的输入第一个值大于0且有"2 3 5 8 12 17"或"5 6 8 11 15 20"这样规律的即可



## phase 3

总览函数"phase_3"的代码，基本看不到什么其他函数的引用(除了scanf)，而且很明显的在400f27处有一个跳转表：那么在这个跳转表之前应该是对我们输入数据的某些处理；跳转表之后可能会是一些判断是否爆炸

```assembly
400f27:	ff 24 c5 40 24 40 00 	jmpq   *0x402440(,%rax,8)
```

前半段汇编代码：

<img src="https://lbw-img-lbw.oss-cn-beijing.aliyuncs.com/img/image-20221010213521893.png" alt="image-20221010213521893" style="zoom:50%;" />

调试到400f0f时，发现有一个比较明显的地址0x4025cf，将其内容读出: <img src="https://lbw-img-lbw.oss-cn-beijing.aliyuncs.com/img/image-20221010202736460.png" alt="image-20221010202736460" style="zoom:50%;" />

说明这道题我们要输入两个整数，重新调试，尝试输入: "1 2"

分别在scanf之前和scanf之后使用`info registers`读取寄存器中的值

scanf前：<img src="https://lbw-img-lbw.oss-cn-beijing.aliyuncs.com/img/image-20221010213614099.png" alt="image-20221010213614099" style="zoom: 50%;" />

scanf后：<img src="https://lbw-img-lbw.oss-cn-beijing.aliyuncs.com/img/image-20221010213632520.png" alt="image-20221010213632520" style="zoom: 50%;" />

根据其中一些值的变与不变，尝试读rsp寄存器所存储地址对应的数据: ![image-20221010213853637](https://lbw-img-lbw.oss-cn-beijing.aliyuncs.com/img/image-20221010213853637.png)

这样我们就知道我们输入的1和2分别被存储在了哪里，接下来想要对汇编代码进行分析就轻松多了



后半段汇编代码：

<img src="https://lbw-img-lbw.oss-cn-beijing.aliyuncs.com/img/image-20221010214125803.png" alt="image-20221010214125803" style="zoom:50%;" />

使用命令`x /32xh 0x402400`访问跳转表，得到：![image-20221010214251505](https://lbw-img-lbw.oss-cn-beijing.aliyuncs.com/img/image-20221010214251505.png)

在上面的图中我们可以比较清楚的看到有8个地址，分别对应0-7共8个数；而我们的第一个输入也被限制在0-7。所以，根据我们的第一个输入可以知道，要跳转的地址，跳转之后会有一个值赋给寄存器eax，这个值必须要与我们输入的第二个值一样才能使得炸弹不爆炸

所以，这道题根据8种不同的第一个输入，有8种不同的第二种输入，也就是说一共有8个答案。具体的答案写在上图汇编代码的注释中了



## phase 4

函数"phase_4"汇编代码:

<img src="https://lbw-img-lbw.oss-cn-beijing.aliyuncs.com/img/image-20221011134743425.png" alt="image-20221011134743425" style="zoom:50%;" />

快速浏览一边发现该函数调用了函数"scanf"和函数"func4"，那么根据经验，0x400ff7中的地址0x4025cf应该就是scanf想要的输入格式。直接在gdb中输入`p (char*)0x4025cf`，得:<img src="https://lbw-img-lbw.oss-cn-beijing.aliyuncs.com/img/image-20221011135342803.png" alt="image-20221011135342803" style="zoom:67%;" />

得知该阶段期望输入两个整数，那么尝试输入"1 5"，而且与之前一样，我们的输入被存储在rsp寄存器中存储的地址所指向的内存, `x /8xh rsp寄存器存储的地址`即可查看我们的输入

在0x401006程序会检查第一个输入，若第一个输入大于14则直接爆炸；所以我们的第一个输入应当小于等于14

从0x401011到0x40101e都应当属于程序为函数"func4"做准备的时间，给edx赋值0xe，给esi赋值0，将我们的第一个输入赋给edi，这些都是首次进入函数"func4"时寄存器的初值。但我们现在不要急着去看func4，我们先看看func4要给我们怎么样的输出才能拆弹：观察0x401023，发现若eax不等于3，则炸弹直接爆炸；观察0x401028，发现若M[4+%rsp]也就是我们输入的第二个值不等于3则炸弹爆炸。至此，我们知道了我们输入的两个数的目标：输入的第一个数小于15并且要让**func4输出eax=3**；输入的第二个数只能是3

那么怎么能让函数"func4"输出eax=3呢？先来看汇编代码: 

<img src="https://lbw-img-lbw.oss-cn-beijing.aliyuncs.com/img/image-20221011173355876.png" alt="image-20221011173355876" style="zoom:50%;" />

不管三七二十一，先看func4中会对eax的值造成影响的地方，发现他们分别发生在: 0x400fa0, 0x400fa2, 0x400fb3, 0x400fc9, 0x400fd5。

eax的值在很多地方都发生了变化，一个一个去看的话略显难以分析。但是，我们知道eax最后输出时是3，那看最后一轮怎么输出才能是3呢？**从retq指令往前看**，因为0x400fbc是一个跳转点，我们要先关注0x400fc9和0x400fd5。对于0x400fc9，相当于将eax\*2，不可能使得eax等于3，所以func4最后不可能在这里退出；再看0x400fd5，这里相当于eax = 2\*eax+1，若eax=1，则eax会输出为3，有可能；再分析其他可能如0x400fb3显然不符合要求。

那么接下来我们的目标就是使得程序第二次进入func4时的最终结果有eax=1。同样的分析方法，仍然去看0x400fc9和0x400fd5，发现对于0x400fd5，若eax输入时为0则有eax输出时为1。那么我们的目标再次变成程序第三次进入func4时最终结果有eax=0。同样的分析方法......

最终结果是第一次和第二次进入func4时，需要在0x400fba跳转到0x400fcd，第三次func4该怎么分析请读者自己动脑思考，分析的方法在上面都有说

最后会得到两个答案，就不写在这里了



## phase 5

函数"phase_5"汇编代码:

<img src="https://lbw-img-lbw.oss-cn-beijing.aliyuncs.com/img/image-20221011175250070.png" alt="image-20221011175250070" style="zoom:50%;" />

没有新意的scanf，直接读0x4025cf的内容，得:![image-20221011182802609](https://lbw-img-lbw.oss-cn-beijing.aliyuncs.com/img/image-20221011182802609.png)

那么知道了该phase要求我们的输入为两个整数，尝试输入"1 5"

我们输入的值仍然被存储在M[R(%rsp)]和M[R(%rsp)+4]，可以直接查看，这里不再专门查看

输入完成之后，0x401074检查输入数量，小于2则爆炸

0x401079-0x40107f，将我们输入的第一个值mod16并将其存到eax寄存器

0x401082检查第一个输入mod16后的结果是否是15，若是15则直接爆炸

0x40108c-0x4010a2是一个循环函数，当eax=0xf时退出循环；edx是循环的计数器，循环几次edx就等于几；ecx是eax的一个累加器，刚进入循环时初值为0，eax每次循环的值都会加到ecx上。这道题关键的关键在于0x402480这个地址，读取它你会发现这是一个数组：

![img](https://lbw-img-lbw.oss-cn-beijing.aliyuncs.com/img/clip_image002.png)

这个数组为:

|a[0]| a[1] |a[2]| a[3] |a[4]| a[5] |a[6]| a[7] |a[8]| a[9] |a[10]| a[11] |a[12]| a[13] |a[14]| a[15] |
| ----------- | ----------- | ----------- | ----------- |----------- | ----------- |----------- | ----------- |----------- | ----------- |----------- | ----------- |----------- | ----------- |----------- | ----------- |
| a      | 2       | e      | 7       | 8     | c    | f      | b       | 0      | f       | 1      | d       | 3      | 9       | 6      | 5       |

但是如果只看到这，我们仍不知道输入什么样的值才能通过这一阶段，所以要接着往下看

0x4010ab判断edx是否等于3，若不等于3则直接爆炸，说明上面的循环要进行三次就退出。ok，看到这里我们就知道第三次循环时eax的值最终要为f，那么第二次循环时eax的值最终为6，第一次循环时eax的值最终为e。那么因为a[2]==0xe，所以我们的第一个输入为2；并且我们也可得知ecx的值为0xe+0x6+0xf=0x23=35

0x4010b0判断ecx是否与第二个输入相等，不相等则爆炸。所以第二个输入的值也得到，为35e



## phase 6

这题代码太长，让我仔细地分析或许可以但是不如启发式地分析

开始看到0x4010fb处调用的函数"read_six_numbers"就知道这个题要求的输入是6个整数，尝试输入"1 2 3 4 5 6"。我们的输入仍存在M[R(%rsp)]开始的24字节

读取完输入跳转到0x401133之后程序会进入一个**两重循环**，至于这两重循环的作用请读者自行用gdb研究吧

在结束上面的二重循环后程序会跳转到0x401151，这里又是一重循环，会遍历所有输入变量并对其做出某种处理

之后程序来到0x40118f，程序再次进入循环，这段循环中会出现一个地址0x6032d0，这个地址存储的是一个链表，其中存储一个值和一个指针，初始情况下指针指向下一个node

0x4011a3-0x4011e2这段程序会破坏链表原有的顺序，按照某种顺序(与输入有关)重新排列。排列之后程序会跳转到0x4011ed，它将以重新排列后的顺序对链表节点中的值按照某种规则进行检查，检查通过之后炸弹拆除



## phase secret

或用ctrl+F发现函数"secret_phase"的唯一入口在函数"phase_defused"，那么就先观察这个函数的汇编代码：

<img src="https://lbw-img-lbw.oss-cn-beijing.aliyuncs.com/img/image-20221012173926267.png" alt="image-20221012173926267" style="zoom:50%;" />

快速看一眼上面的代码，在0x4015ea处是对程序运行阶段的检查，若没有完成phase6，那么就算你在phase 4输入密语也无法进入secret phase。跳转之后来到0x401608，先不管那几次lea操作具体是干什么的(猜测与phase 4的输入有关)，直接看0x401617, 0x40161c和0x401637共三处含有的地址所存储的数据，如图：<img src="https://lbw-img-lbw.oss-cn-beijing.aliyuncs.com/img/image-20221012174713353.png" alt="image-20221012174713353" style="zoom:67%;" />

看到上图应该就非常明确了，我们进入secret phase的密语是"urxvt"



之后查看函数"secret_phase"的汇编代码：

<img src="https://lbw-img-lbw.oss-cn-beijing.aliyuncs.com/img/image-20221012174908729.png" alt="image-20221012174908729" style="zoom:50%;" />

看到了"read_line", "strtoI"和"fun7"几个函数，"read_line"和"strtoI"的功能比较好猜，分别是读取输入和将输入的字符串转换成int类型的整数。在这里我尝试输入字符串"15"，并在0x40128b处也就是调用函数"fun7"之前查看所有的寄存器值：<img src="https://lbw-img-lbw.oss-cn-beijing.aliyuncs.com/img/image-20221012182448233.png" alt="image-20221012182448233" style="zoom: 33%;" />

我们能观察到输入被存储在寄存器rbx和rsi，输入-1被存储在寄存器rax。并且寄存器edi会存储一个地址0x6030f0，等下再详细研究edi存储的地址到底指向的是什么，我们先看函数"fun7"之后的部分。

从函数"fun7"返回后，程序立即对寄存器eax保存的值进行判断，若其不为4则直接爆炸；若eax为4那么会跳到0x40129a，其中的地址0x402488在使用gdb读取后发现其中的存储的是一个字符串："Wow! You've defused the secret stage!"。那么也就是说，**我们只需要经过函数"fun7"使得eax的值变为4即可**，那么接下来看函数"fun7"的汇编代码：

<img src="https://lbw-img-lbw.oss-cn-beijing.aliyuncs.com/img/image-20221012183727482.png" alt="image-20221012183727482" style="zoom:50%;" />

啊，看到函数内两个对自己的调用指令想4的心都有了，该死的递归。但是没办法，还是得接着看。

还记得在进入函数"fun7"之前，程序向寄存器edi塞了一个地址0x6030f0么？现在来看看它到底是个什么东西:

<img src="https://lbw-img-lbw.oss-cn-beijing.aliyuncs.com/img/image-20221012190639206.png" alt="image-20221012190639206" style="zoom: 67%;" />

<img src="https://lbw-img-lbw.oss-cn-beijing.aliyuncs.com/img/image-20221012190649289.png" alt="image-20221012190649289" style="zoom:67%;" />

乍看上去真想不明白这玩意到底是干啥的，但是先看命名：n1, n21, n22, n32, n33, n31, n34, n45, n41, n47, n44, n42, n43, n46, n48。其中1开头的有1个，2开头的有两个，3开头的有4个，4开头的有8个。分析到这我就感觉他和二叉树的结构非常相似，那就仔细看一下各节点中保存的内容吧：

1. 节点n1

   存储一个值0x24，两个地址：0x603110(n21)和0x603130(n22)

2. 节点n21

   存储一个值0x8，两个地址：0x603190(n31)和0x603150(n32)

3. 节点n22

   存储一个值0x32，两个地址：0x603170(n33)和0x6031b0(n34)

4. .......

很显然这就是一个二叉树了，用一张图表示这个数据结构吧：

<img src="https://lbw-img-lbw.oss-cn-beijing.aliyuncs.com/img/tree.jpg" alt="tree" style="zoom: 33%;" />

其实分析完这个数结构，这个函数就迎刃而解了，记得大二数据结构课上写过无数这种树结构的递归遍历，剩下的自己分析吧，加油！









