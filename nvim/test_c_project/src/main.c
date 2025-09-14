#include <stdio.h>
#include <stdlib.h>
#include "../include/utils.h"

int main(int argc, char *argv[]) {
	(void)argc;
	(void)argv;
	printf("Hello from C project!\n");

	// Test LSP features here:
	int numbers[] = {1, 2, 3, 4, 5};
	int size = sizeof(numbers) / sizeof(numbers[0]);

	int sum = calculate_sum(numbers, size);
	printf("Sum of array: %d\n", sum);

	// Test function with potential issues
	char *message = create_message("Testing LSP");
	printf("Message: %s\n", message);

	// Memory management
	free(message);

	return 0;
}
