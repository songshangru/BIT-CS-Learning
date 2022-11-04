int main()
{
	int a[5][3];
	int res = a[5][0];
	
	// The following example will not remind us
	res = a[5+5][0];
	return 0;
}