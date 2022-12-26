#include <stdio.h>
#include <stdbool.h>
#include <limits.h>


static const char ulli_input_template[] = "%llu";
static const char lli_input_template[] = "%lld";
static const char lli_output_template[] = "%lld ";

#define MAX_INPUT_LENGTH 16777214 // Limit the input to 8 Gb of memory
static long long int A[MAX_INPUT_LENGTH + 2], B[MAX_INPUT_LENGTH + 2];
static unsigned long long int A_length = 0, B_length = 0;

static const char too_long_array_error[] = "Input too large!";


bool input()
{
    scanf(ulli_input_template, &A_length);
    if (A_length > MAX_INPUT_LENGTH) return false;
    for (size_t i = 1; i <= A_length; i++) scanf(lli_input_template, &A[i]);
    A[0] = LLONG_MAX; A[A_length + 1] = LLONG_MIN; // index A from 1 to n for the algorithm
    return true;
}
void solve()
{
    for (size_t A_index = 1; A_index <= A_length; A_index++)
    {
        if (A[A_index] >= A[A_index - 1] || A[A_index] <= A[A_index + 1]) B[B_length++] = A[A_index];
    }
}
void output()
{
    for (size_t i = 0; i < B_length; i++) printf(lli_output_template, B[i]);
}

int main(void)
{
    if (!input())
    {
        printf(too_long_array_error);
        return 0;
    }
    solve();
    output();
    return 0;
}