int main(){
	int a[5][5];
	int n;
	for(int i=0;i<5;i++){
        for(int j=0;j<5;j++)
        {
            a[i][j]=i;
        }
	}
	Mars_PrintStr("This number's fibonacci value is :\n");
    for(int i=0;i<5;i++){
        for(int j=0;j<5;j++)
        {
            n=a[i][j];
            Mars_PrintInt(n);
        }
	}

    return 0;
}
