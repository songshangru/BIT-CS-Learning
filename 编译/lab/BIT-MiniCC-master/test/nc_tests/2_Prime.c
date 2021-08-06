int prime(int n){
	int sum = 0;
	int i,j,flag = 1;
	for(i = 2; i<=n; i++){
		flag = 1;
		for(j = 2; j*j <= i; j++){
			if(i%j == 0){
				flag = 0;
				break;
			}
		}
		if(flag == 1){
			sum ++;
			Mars_PrintInt(i);
		}
	}
	return sum;
}
int main(){
	Mars_PrintStr("Please input a number:\n");
	int n = Mars_GetInt();
	int res = prime(n);
	Mars_PrintStr("The number of prime numbers within n is:\n");
	Mars_PrintInt(res);
    return 0;
}