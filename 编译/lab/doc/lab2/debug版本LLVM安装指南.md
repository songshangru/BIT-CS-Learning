# debug版本LLVM安装指南

在ubuntu虚拟机中，3核编译过程总计耗时为10小时，占用空间约40G，此外还需要预留swap空间，建议在构建虚拟机时预留60G以上的空余空间

- 安装cmake，注意版本必须是3.13.4及以上

  ```bash
  wget https://cmake.org/files/v3.13/cmake-3.13.4-Linux-x86_64.tar.gz
  tar -xzvf cmake-3.13.4-Linux-x86_64.tar.gz
  
  sudo mv cmake-3.13.0-Linux-x86_64 /opt/cmake-3.13.0
  
  sudo ln -sf /opt/cmake-3.13.0/bin/*  /usr/bin/
  ```

- 从[LLVM Download](https://releases.llvm.org/download.html#4.0.0)下载clang和llvm源码

  <img src="D:/资料/2021年春/编译原理与设计/lab/lab2/Lab2.assets/image-20210312122212866.png" alt="image-20210312122212866" style="zoom:67%;" />

  解压缩，分别将目录重命名为clang和llvm，将clang目录移动到llvm/tools/目录下

- 在llvm目录的父目录下创建build目录，用于存放构建的中间产物和最终的可执行文件

- 由于编译过程需要较大的内存，需要扩大swap分区（此处取约20G）以构建较大的虚拟内存结构，否则在编译过程中会报错并停止

  ```bash
  sudo mkdir swapfile
  cd /swapfile
  sudo dd if=/dev/zero of=swap bs=1024 count=20000000
  sudo mkswap -f  swap
  sudo swapon swap
  ```

- 进入build目录，执行

  `cmake ../llvm -DLLVM_TARGETS_TO_BUILD=X86 -DCMAKE_BUILD_TYPE=Debug`

- 执行`make`即可开始编译，对于x核CPU，可以执行`make -jx`，该步骤需要较长时间，可能会提示需要某些编译工具，可以使用`sudo apt install ...`安装

- 执行`sudo make install`进行安装