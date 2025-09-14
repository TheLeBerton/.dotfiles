#ifndef UTILS_H
#define UTILS_H

/**
 * Calculate the sum of an array of integers
 * @param array: pointer to the array
 * @param size: number of elements in the array
 * @return: sum of all elements
 */
int calculate_sum(int *array, int size);

/**
 * Create a formatted message string
 * @param prefix: prefix to add to the message
 * @return: dynamically allocated string (caller must free)
 */
char *create_message(const char *prefix);

/**
 * Find maximum value in array
 * @param array: pointer to the array
 * @param size: number of elements
 * @return: maximum value found
 */
int find_max(int *array, int size);

#endif // UTILS_H
