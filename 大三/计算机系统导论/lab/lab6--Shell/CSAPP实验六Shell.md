# CSAPP实验六Shell

## 准备

正式做这个lab之前，至少要做以下准备：

1. 首先要看课本的8.4.6小节，里面给出了`eval`函数和`builtin_cmd`函数的基本代码
2. 如果有能力可以仔细阅读课本8.4.6之后的所有部分，也可以先大概了解，等到用到时再去查看
3. 仔细阅读回收进程小节中关于函数`waitpid`的介绍
4. 了解`&`, `bg`, `fg`, `jobs`等命令的作用
5. 了解tsh.c中全局变量和作者提供的函数的作用

个人认为做好这些准备即可以开始编写代码

## 编写代码时要注意的

1. 先对着课本上给出的`eval`函数和`builtin_cmd`函数的基本代码写出tsh.c中的`eval`函数和`builtin_cmd`函数
2. 不要想着一口气实现所有的函数，在你完成了第一步之后你会发现，你可以慢慢实现
3. 灵活运用示例程序tshref和其他作者给出的测试脚本，从trace01.txt开始一个一个实现
4. 注意在用到全局变量如`jobs`前加信号阻塞，并在使用完之后还原

## 每个函数的实现

### eval

```c
void eval(char *cmdline) {
    // 用于信号阻塞
    sigset_t mask_all,mask,prev;
    sigfillset(&mask_all);
    sigemptyset(&mask);
    sigemptyset(&prev);
    sigaddset(&mask, SIGCHLD);

    char buf[MAXLINE];
    strcpy(buf,cmdline);
    char *argv[MAXARGS];
    pid_t pid;
    int bg = parseline(buf,argv);
    if(argv[0]==NULL)   return;

    if(!builtin_cmd(argv)){
        // 执行fork时阻塞信号
    	sigprocmask(SIG_BLOCK, &mask, &prev);
        if((pid = fork())==0){
            sigprocmask(SIG_SETMASK, &prev, NULL);
            setpgid(0, 0);
            if(execve(argv[0],argv,environ)<0){
                printf("%s: Command not found\n",argv[0]);
                exit(0);
            }
        }else{
            // 添加job显然需要增加阻塞
            sigprocmask(SIG_BLOCK,&mask_all,NULL);
            addjob(jobs,pid,bg?BG:FG,cmdline);
            sigprocmask(SIG_SETMASK,&mask,NULL);

            if(!bg){       // fg job
                waitfg(pid);
            }else{         // bg job
                sigprocmask(SIG_BLOCK, &mask, &prev);
                printf("[%d] (%d) %s", pid2jid(pid), pid, cmdline);
                sigprocmask(SIG_SETMASK, &prev, NULL);
            }
        }
    }
    return;
}
```

### builtin_cmd

```c
int builtin_cmd(char **argv) {
    if(!strcmp(argv[0],"quit")){    
        // 处理quit命令
        exit(0);
    }
    if(!strcmp(argv[0],"&")){       
        // 忽略单个&
        return 1;
    }
    if(!strcmp(argv[0],"jobs")){    
        // 处理jobs命令
        listjobs(jobs);
        return 1;
    }
    if(!strcmp(argv[0],"fg")||!strcmp(argv[0],"bg")){
        // 处理fg/bg命令
        do_bgfg(argv);
        return 1;
    }
    return 0;
}
```

### do_bgfg

```c
void do_bgfg(char **argv) {
    sigset_t mask_all,prev;
    sigfillset(&mask_all);
    sigemptyset(&prev);

    int bg = strcmp(argv[0],"bg") ? 0 : 1;
    
    if(argv[1]==NULL){  // 检查有没有第二个参数
        printf("%cg command requires PID or %%jobid argument\n", bg ? 'b' : 'f');
        return;
    }

    char buf[MAXLINE];
    strcpy(buf,argv[1]);

    int jid = 0;
    int pid = 0;
    int length = strlen(buf);
    int jid_or_pid = buf[0]=='%' ? 1 : 0;   // 判断使用jid还是pid, 1为jid

    // 取得job
    struct job_t *job = NULL;
    if(jid_or_pid){ 
        // 使用jid的情况
        char *p = buf;
        int num;
        while(--length){
            ++p;
            num = *p - 48;
            if(num<0 || num>9){
                printf("%cg: argument must be a PID or %%jobid\n", bg ? 'b' : 'f');
                return;
            }
            for(int i=1;i<length;i++){
                num *= 10;
            }
            jid += num;
        }
        // 使用jobs前阻塞
        sigprocmask(SIG_BLOCK,&mask_all,NULL); 
        job = getjobjid(jobs,jid);
        sigprocmask(SIG_SETMASK,&prev,NULL);
        if(job == NULL){
            printf("%%%d: No such job\n",jid);
            return;
        }
    }else{
        // 使用pid的情况
        char *p = buf;
        int num = 0;
        while(length--){
            num = *p - 48;
            if(num<0 || num>9){
                printf("%cg: argument must be a PID or %%jobid\n", bg ? 'b' : 'f');
                return;
            }
            for(int i=0;i<length;i++){
                num *= 10;
            }
            pid += num;
            ++p;
        }
        // 使用jobs前阻塞
        sigprocmask(SIG_BLOCK,&mask_all,NULL); 
        job = getjobpid(jobs,pid);
        sigprocmask(SIG_SETMASK,&prev,NULL);
        if(job == NULL){
            printf("(%d): No such process\n",pid);
            return;
        }
    }
    
    if(!bg){    // fg
        kill(-job->pid,SIGCONT);
        job->state = FG;
        waitfg(job->pid);
    }else{      //bg
        kill(-job->pid,SIGCONT);
        job->state = BG;
        printf("[%d] (%d) %s", job->jid, job->pid, job->cmdline);   
    }
    return;
}
```

### waitfg

```c
void waitfg(pid_t pid){
    sigset_t mask;
    sigemptyset(&mask);
    // 等待 SIGCHLD
    while (fgpid(jobs) > 0)
    	sigsuspend(&mask);
    return;
}
```

### sigchld_handler

```c
void sigchld_handler(int sig) {
    int olderrno = errno,status;

    sigset_t mask_all,prev;
    sigfillset(&mask_all);
    sigemptyset(&prev);
    pid_t pid;

    while((pid = waitpid(-1,&status,WNOHANG | WUNTRACED)) > 0){
        //全屏蔽
        sigprocmask(SIG_BLOCK,&mask_all,&prev);
        struct job_t* job = getjobpid(jobs,pid);
        if(WIFEXITED(status)){
            // 正常退出
            deletejob(jobs,pid);
        }else if(WIFSIGNALED(status && WTERMSIG(status) == SIGINT)){
            // 因接收到SIGINT退出
            printf("Job [%d] (%d) terminated by signal 2\n",job->jid,job->pid); 
            deletejob(jobs,pid);
        }else if(WIFSTOPPED(status) && WSTOPSIG(status) == SIGTSTP){
            // 因接收到SIGTSTP而暂停
            printf("Job [%d] (%d) stopped by signal 20\n",job->jid,job->pid);
            job->state = ST; //处理为STOP 
        }
        sigprocmask(SIG_SETMASK,&prev,NULL);
    } 
    errno = olderrno;
}
```

### sigint_handler

这个应该是最简单的信号处理函数，直接退出就行

```c
void sigint_handler(int sig) {
    sigset_t mask_all,prev;
    sigfillset(&mask_all);
    sigemptyset(&prev);
    
    sigprocmask(SIG_BLOCK,&mask_all,&prev);
    pid_t pid = fgpid(jobs);
    sigprocmask(SIG_SETMASK,&prev,NULL);
    
    if(pid!=0){
        kill(-pid,SIGINT);
    }
}
```

### sigtstp_handler

```c
void sigtstp_handler(int sig) {
    sigset_t mask_all,prev;
    sigfillset(&mask_all);
    sigemptyset(&prev);

    sigprocmask(SIG_BLOCK,&mask_all,&prev);
    pid_t pid = fgpid(jobs);
    sigprocmask(SIG_SETMASK,&prev,NULL);

    if(pid!=0){
        kill(-pid,SIGTSTP);
    }
}
```

