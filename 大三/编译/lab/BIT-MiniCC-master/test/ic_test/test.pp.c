int a[10][20];
int b = 1;

int f1(int x,int y){
	int z = x + y;
	return z;
}
void f2(){
	//Mars_PrintStr("in f2\n");
	return;
}

int main(){
    a[2][3];
	int a1 = 1;
	int a2 = 2;
	int res;
	// unary oper
	res = !a1;
	res = ~a1;
	// binary oper
	res = a1+a2;
	res = a1%a2;
	res = a1 << a2;
	// selfchange
	res = a1++;
	res = ++a1;
	// short-circuit evaluation and "if" control-flow
	if(a1 && a2){
		res = f1(a1,a2);
	}else if(!a1){
		// b is global
		res = f1(b,a2);
	}else{
		f2();
	}
	// "for" control-flow
	for(int i = 0; i<a1; i++){
		break;
		continue;
		res += 1;
	}
	// label and goto
	k:
	goto k;
	// return
	return 0;
}
