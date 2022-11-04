int main()
{
	//integer-constant
	+1 ;
	-10 ;
	1000 ;
	1l ;
	1U ;
	10ul ;
	10LU ;
	1000ull ;
	1000LLU ;

	+0 ;
	-00 ;
	007 ;
	00ul ;
	00LLU ;

	+0x0 ;
	-0x00 ;
	0XABCDEF ;
	0xful ;
	0XFLLU ;

//floating-constant
	0.0 ;
	+1.1e+1 ;
	-1.1E-1 ;
	1.1e1f ;
	1.1E1L ;

	0x0p0;
	0x0.0p0 ;
	+0xa.ap+1 ;
	-0xa.aP-1 ;
	0xa.ap1f ;
	0xa.aP1L ;

//character-constant
	'a' ;
	L'a' ;
	U'a' ;
	u'a' ;
	'\n' ;
	'\?' ;
	'\24' ;

//string-literal
	"abcdefg123456\\" ;
	u8"a" ;
	u"a" ;
	U"a" ;
	L"a" ;

//identifier
	int __a ;
	int __1 ;
	int a1 ;
	int a ;
	int a_1 ;
	int a_ ;

//keyword
	int i=1 ;
	float f ;
	double d ;
	char c ;
	long l ;
	short s ;
	signed si ;
	unsigned short us ;
	typedef struct 
	{
		int num1;
	}test;
	test test1 ;
	test *test2 ;
	static int sti ;
	const int ci ;
	sizeof( int ) ;
	if( 1 )
	{

	}
	else
	{

	}
	for( ; ; )
	{
		continue ;
	}
	while( 1 )
	{

	}
	switch(i){ 
	    case 1:  break;
	    default:  break;
	}
	do
	{

	}while( 0 ) ;
	goto gotoFlag ;
	//operators
	int array[10] = {0} ;
	test1.num1 = 0 ;
	test2->num1 = 0 ;
	i++ ;
	i-- ;
	i = 1 + 1 ;
	i = 1 - 1 ;
	i = 1 * 1 ;
	i = 1 / 1 ;
	i = 1 % 1 ;
	i = !i ;
	i = i & 1 ;
	i = i | 1 ;
	i = i && 1 ;
	i = i || 1 ;
	i = i ^ 1 ;
	i = i >> 1 ;
	i = i << 1 ;
	i = i > 1 ? 1 : 2 ;
	i += 1 ;
	i -= 1 ;
	i *= 1 ;
	i /= 1 ;
	i %= 1 ;
	i &= 1 ;
	i |= 1 ;
	i ^= 1 ;
	i >>= 1 ;
	i <<= 1 ;
	if( i==1 ){}
	if( i!=1 ){}
	if( i>1 ){}
	if( i<1 ){}
	if( i>=1 ){}
	if( i<=1 ){}
gotoFlag:	
	return 0 ;
}
void function( int arg1 , int arg2 )
{
}