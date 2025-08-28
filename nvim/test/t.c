#include "t.h"

int main(int argc, char **argv)
{
	if (argc != 3)
	{
		printf("Error: usage ./t <name:str> <age:int>\n");
		return (1);
	}
	t_person p1;

	strlcpy(p1.name, argv[1], sizeof(p1.name));
	p1.age = atoi(argv[2]);
	printf("Name: %s\nAge: %d\n", p1.name, p1.age);
	return (0);
}
