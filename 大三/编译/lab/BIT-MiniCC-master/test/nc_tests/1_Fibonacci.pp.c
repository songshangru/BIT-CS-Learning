int fibonacci(int num){
	//Mars_PrintInt(num);
	int res;
	if(num < 1){
		res = 0;
	}else if(num <= 2){
		res = 1;
	}else{
		res = fibonacci(num-1)+fibonacci(num-2);
	}
	return res;
}
int main(){
	Mars_PrintStr("Please input a number:\n");
	int n = Mars_GetInt();
	int res = fibonacci(n);
	Mars_PrintStr("This number's fibonacci value is :\n");
	Mars_PrintInt(res);
    return 0;
}
