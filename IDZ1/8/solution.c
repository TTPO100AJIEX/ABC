#include <stdio.h>
#include <limits.h>
#include <stdlib.h>
#include <time.h>
#define int64_t long long int
#define uint64_t unsigned long long int

const uint64_t input(int64_t* memory, const uint64_t max_input_length, unsigned int mode) // reads an array and returns its length
{
    uint64_t length; scanf("%llu", &length);
    if (length > max_input_length) { printf("Input too large!"); return 0; }
    
    if (mode == 1)
    {
        srand(time(NULL));
        for (uint64_t i = 1; i <= length; i++) memory[i] = rand();
    }
    else
    {
        for (uint64_t i = 1; i <= length; i++) scanf("%lld", &memory[i]);
    }

    memory[0] = LLONG_MAX; memory[length + 1] = LLONG_MIN;
    return length;
}
const uint64_t solve(const int64_t* src, const uint64_t src_length, int64_t* dest) // solves the issue and returns the length of the answer
{
    uint64_t length = 0;
    for (uint64_t i = 1; i <= src_length; i++)
    {
        if (src[i] >= src[i - 1] || src[i] <= src[i + 1]) dest[++length] = src[i];
    }
    return(length);
}
void output(const int64_t* memory, const uint64_t length) // prints the array
{
    for (uint64_t i = 1; i <= length; i++) printf("%lld ", memory[i]);
}

#define MAX_INPUT_LENGTH 16777214
static int64_t A[MAX_INPUT_LENGTH + 2], B[MAX_INPUT_LENGTH + 2];
int main(int argc, char** argv)
{
    unsigned int output_flag_argv_index = 2, array_read_mode = 0;
    if (argv[1][0] == '1') freopen(argv[output_flag_argv_index++], "r", stdin);
    if (argv[1][0] == '2') array_read_mode = 1;
    if (argv[output_flag_argv_index][0] == '1') freopen(argv[output_flag_argv_index + 1], "w", stdout);

    const uint64_t A_length = input(A, MAX_INPUT_LENGTH, array_read_mode);

    uint64_t B_length;  
    clock_t start = clock();
    for (int i = 0; i < 10; i++) B_length = solve(A, A_length, B);
    clock_t end = clock();
    unsigned long long int cpu_time_used = (1000000000 * (end - start)) / CLOCKS_PER_SEC; // in nanoseconds

    output(B, B_length);
    printf("\n\nCPU time used: %lluns\n", cpu_time_used);
    return 0;
}