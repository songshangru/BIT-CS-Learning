#include	<stdio.h>
#include        <dlfcn.h>
#define SO_FILE "./libmy.so"

main()
{
	void *sfp; 	char *err;
	int	tmpi=16;
	int (*f1)(int ),(*f2)(char *);	            //定义函数指针
	sfp=dlopen(SO_FILE,RTLD_LAZY);	//打开共享库
	if(sfp==NULL){
		fprintf(stderr,dlerror()); exit(1);
	}
	f1=dlsym(sfp,"f1");	//获取函数f1入口地址（指针）
	err=dlerror();		//检查是否成功
	if(err){
		fprintf(stderr,err); exit(2);
	}
	f2=dlsym(sfp,"f2");     //获取函数f2入口地址（指针）
	err=dlerror();	    //检查是否成功
	if(err){
		fprintf(stderr,err); exit(3);
	}
	fprintf(stderr, "Begin:\n");
	printf("%d\n",f1(15));
	printf("%c\n",f2('c'));
	fprintf(stderr,":End\n");
	dlclose(sfp); 
	exit(0);
} 

