#include <stdio.h>
#include <stdlib.h>


int add( int a, int b ) {
	return ( a + b );
}

int substraction( int a, int b ) {
	return ( a - b );
}

int multiplication( int a, int b ) {
	return ( a * b );
}

int division( int a, int b ) {
	if ( b == 0 ) {
		return ( 0 );
	}
	return ( a / b );
}

int main( void ) {
	int a = 10;
	int b = 5;

	printf( "%d + %d = %d\n", a, b, add( a, b ) );
	printf( "%d - %d = %d\n", a, b, substraction( a, b ) );
	printf( "%d * %d = %d\n", a, b, multiplication( a, b ) );
	printf( "%d / %d = %d\n", a, b, division( a, b ) );
	return ( EXIT_SUCCESS );
}
