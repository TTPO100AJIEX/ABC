#include <stdio.h>
#include <limits.h>
#define int64_t long long int
#define uint64_t unsigned long long int

const uint64_t input(int64_t* memory, const uint64_t max_input_length) // reads an array and returns its length
{
    uint64_t length; scanf("%llu", &length);
    if (length > max_input_length) { printf("Input too large!"); return 0; }
    for (uint64_t i = 1; i <= length; i++) scanf("%lld", &memory[i]);
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

#define MAX_INPUT_LENGTH 16777214 // Limit the input to 8 Gb of memory
static int64_t A[MAX_INPUT_LENGTH + 2], B[MAX_INPUT_LENGTH + 2];
int main(int argc, char** argv)
{
    if (argv[1][0] == '0' && argv[2][0] == '1') freopen(argv[3], "w", stdout);
    if (argv[1][0] == '1' && argv[3][0] == '0') freopen(argv[2], "r", stdin);
    if (argv[1][0] == '1' && argv[3][0] == '1') { freopen(argv[2], "r", stdin); freopen(argv[4], "w", stdout); }

    output(B, solve(A, input(A, MAX_INPUT_LENGTH), B));
    return 0;
}