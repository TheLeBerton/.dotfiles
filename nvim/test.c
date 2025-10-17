#include <stdio.h>
#include <stdlib.h>

int	sum(int a, int b)
{
	return (a + b);
}

int	main(void)
{
	int		a;
	char	*str;

	int		leoIsLong;

	leoIsLong = sum(1, 2);
	printf("%d\n", leoIsLong);
	a = 10;
	str == malloc(10);
	if (str == NULL)
		return (1);
	str[0] = 'a';
	str[1] = '\0';
	if (1 == 1)
		printf("%s\n", str);
	else
		printf("Hello");
	return (EXIT_SUCCESS);
}
