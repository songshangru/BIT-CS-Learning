# 在Linux系统(Ubuntu 20.04.1)上编译新内核并从新内核启动

## 1.环境

- 操作系统：ubuntu 20.04.1 LTS
- gcc版本：9.4.0
- gnumake版本：4.2.1
- Linux内核版本：5.15.67

分别使用`gcc -v`和`make -v`命令获取gcc和make的版本信息，如果没有版本信息则需要安装gcc与gnumake，安装方法网络上有很多在此就不再赘述。

使用`uname -a`命令获得Linux内核版本信息；新的要被编译的内核可以去[kernel.org](kernel.org)上下载。

## 2.配置内核编译选项

将/boot/目录下的config-5.15.0-46-generic复制到了linux内核目录下，并重命名为".config"，准备作为oldconfig文件进行编译，具体命令：

```shell
cp /boot/config-5.15.0-46-generic .config
```

之后进行编译：

```shell
make oldconfig
```

之后会有一些选项供你选择，y为编译到内核中（速度更快但是会使内核更大）；n为不编译；m为将该功能编译到模块里。如果是需要经常使用的功能，我们应当把他编译到内核中；对于不常使用的功能，最好把它编译到模块中。如果只是实验的话，可以长按回车全选择默认。



## 3.编译内核和模块

分别用`make bzImage`命令和`make modules`命令编译内核与模块

tips：编译内核与模块耗时比较久，可以根据自己cpu的情况给make命令添加-j参数，比如添加-j12，可以大大提升编译的速度

其中遇到一些报错，但基本都是一些模块的缺失，复制错误信息到互联网上搜索后安装对应包一般就能解决。遇到错误编译中断不要清除已经编译好的文件.

编译结束后生成bzImage文件，我的保存目录是在/arch/x86/boot/目录下。bzImage是使用gzip压缩的内核文件，文件的开头部分内嵌有gzip解压缩代码，当内核启动时会自动解压缩

之后使用`make modules_install`命令安装模块



## 4.准备启动文件

我的boot目录如图所示： ![img](file:///C:/Users/rainbow/AppData/Local/Temp/msohtmlclip1/01/clip_image002.jpg) 

 将编译好的内核文件复制到/boot/目录下，复制为vmlinuz-5.15.67

```shell
cp arch/x86/boot/bzImage /boot/vmlinuz-5.15.67
```

把内核符号表System.map复制到启动目录/boot下，复制为System.map-5.15.67

```shell
cp System.map /boot/System.map-5.15.67
```

生成初始化内存盘文件：

```shell
mkinitramfs -o initrd-5.15.67.img -v 5.15.67
```

操作完成后命令行会提示.img文件的存放地址：![img](file:///C:/Users/rainbow/AppData/Local/Temp/msohtmlclip1/01/clip_image008.jpg)



## 5.修改GRUB配置文件

与Fedora不同，ubuntu的开机引导文件是由`update-grub2`命令自动生成，一般不允许用户直接更改，所以在这里我是直接使用该命令。



## 6.重新启动进入新内核

重新启动后选择高级选项出现新的linux内核选项：

![img](file:///C:/Users/rainbow/AppData/Local/Temp/msohtmlclip1/01/clip_image010.jpg) 

|      |                                                              |
| ---- | ------------------------------------------------------------ |
|      | ![img](file:///C:/Users/rainbow/AppData/Local/Temp/msohtmlclip1/01/clip_image012.jpg) |




选择5.15.67版本内核，进入系统后使用`uname -r`命令查看内核版本号：

![img](file:///C:/Users/rainbow/AppData/Local/Temp/msohtmlclip1/01/clip_image014.jpg)

发现kernel版本已更新为5.15.67





 

 