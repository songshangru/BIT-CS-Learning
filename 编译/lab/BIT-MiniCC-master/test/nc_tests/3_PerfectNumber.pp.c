void perfectNumber(int n){
	int p[80];  
	int i,num,count,s,c = 0;
	for(num = 2; num < n; num++)
	{
		count = 0;
		s = num;
		for(i = 1; i < num/2+1; i++)      
		{
			if(num % i == 0)          
			{
				p[count++]  = i;      
				s -= i;               
			}
		}
		if( 0 == s)
		{
			Mars_PrintInt(num);
			c++;
		}
	}
	Mars_PrintStr("The sum is :\n");
	Mars_PrintInt(c);
	return ;
}
int main(){
	Mars_PrintStr("All perfect numbers within 100:\n");	// A perfect number is a number equal to the sum of its factors
	perfectNumber(100);
    return 0;
}
