//打印杨辉三角
void YangHuiTriangle()
{
	int i,j,triangle[8][8];

	for(i = 0; i < 8; i++)
		for(j = 0; j < 8; j++)
			triangle[i][j] = 1;

	for(i = 2; i < 8; i++)
	{
		for(j = 1; j < i; j++)
		{
			triangle[i][j] = triangle[i-1][j]+triangle[i-1][j-1];
		}
	}
	for(i = 0; i < 8; i++)
	{
		for(j = 0; j <= i; j++)
			Mars_PrintInt(triangle[i][j]);
		Mars_PrintStr("\n");
	}

	return ;
}
int main(){
	YangHuiTriangle();
    return 0;
}
