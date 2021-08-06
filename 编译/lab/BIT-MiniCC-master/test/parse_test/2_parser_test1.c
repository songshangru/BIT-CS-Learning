int fibonacci ( int n ) {
	if ( n < 2 )
		return n;
	int f = 0 , g = 1 ;
	int result = 0 ;
	for ( int i = 0 ; i < n ; i ++ ) {
		result = f + g ;
		f = g ;
		g = result ;
	}
	return result ;
}
int main ( ) {
  int a = 10;
  int res = fibonacci ( a ) ;
  _OUTPUT ( res ) ;
  return 0 ;
}
