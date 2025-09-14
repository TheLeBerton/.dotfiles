#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "../include/utils.h"

int calculate_sum(int *array, int size) {
	if (array == NULL || size <= 0) {
		return 0;
	}

	int sum = 0;
	for (int i = 0; i < size; i++) {
		sum += array[i];
	}
	return sum;
}

char *create_message(const char *prefix) {
	if (prefix == NULL) {
		return NULL;
	}

	size_t prefix_len = strlen(prefix);
	const char *suffix = " - LSP is working!";
	size_t suffix_len = strlen(suffix);
	size_t total_len = prefix_len + suffix_len + 1; // +1 for null terminator

	char *message = malloc(total_len);
	if (message == NULL) {
		return NULL; // Memory allocation failed
	}

	strcpy(message, prefix);
	strcat(message, suffix);

	return message;
}

int find_max(int *array, int size) {
	if (array == NULL || size <= 0) {
		return 0; // Or return some error value
	}

	int max = array[0];
	for (int i = 1; i < size; i++) {
		if (array[i] > max) {
			max = array[i];
		}
	}
	return max;
}
