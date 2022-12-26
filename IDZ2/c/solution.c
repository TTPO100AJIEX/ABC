#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#define uint64_t unsigned long long int
#define MAX_INPUT_LENGTH 1073741824

const uint64_t input(unsigned char* buffer, unsigned int mode)
{
    if (mode == 1)
    {
        //random generation
        uint64_t length; scanf("%llu", &length);
        if (length > MAX_INPUT_LENGTH) { printf("The input is too long!"); return (MAX_INPUT_LENGTH + 1); }
        srand(time(NULL));
        for (uint64_t i = 0; i < length; i++) buffer[i] = rand() & 127; // rand() % 128
        return length;
    }

    const uint64_t length = fread(buffer, 1, MAX_INPUT_LENGTH + 1, stdin); // reads up to MAX_INPUT_LENGTH+1 symbols and returns the amount read
    if (length == MAX_INPUT_LENGTH + 1) { printf("The input is too long!"); return (MAX_INPUT_LENGTH + 1); }
    for (uint64_t i = 0; i < length; i++)
    {
        if (buffer[i] > 127) { printf("Non-ASCII characters encountered!"); return (MAX_INPUT_LENGTH + 1); }
    }
    return length;
}

struct Result
{
    uint64_t numbers;
    uint64_t letters;
};
const struct Result solve(const unsigned char* buffer, const uint64_t length)
{
    struct Result res = { 0, 0 };
    for (uint64_t i = 0; i < length; i++)
    {
        if (buffer[i] >= '0' && buffer[i] <= '9') { res.numbers++; continue; }
        if ((buffer[i] >= 'a' && buffer[i] <= 'z') || (buffer[i] >= 'A' && buffer[i] <= 'Z')) res.letters++;
    }
    return res;
}

void output(const struct Result answer)
{
    printf("Numbers: %llu, Letters: %llu", answer.numbers, answer.letters);
}

int main(int argc, char** argv)
{
    if (argc < 2) { printf("Incorrect command line arguments provided!\n"); return 0; }
    unsigned int output_flag_argv_index = 2, read_mode = 0;
    if (argv[1][0] == '1')
    {
        if (argc < 3) { printf("Incorrect command line arguments provided!\n"); return 0; }
        if (!freopen(argv[output_flag_argv_index++], "r", stdin)) { printf("Failed to open an input file!\n"); return 0; }
    }
    if (argv[1][0] == '2') read_mode = 1;
    if (argc < output_flag_argv_index + 1) { printf("Incorrect command line arguments provided!\n"); return 0; }
    if (argv[output_flag_argv_index][0] == '1')
    {
        if (argc < output_flag_argv_index + 2) { printf("Incorrect command line arguments provided!\n"); return 0; }
        if (!freopen(argv[output_flag_argv_index + 1], "w", stdout)) { printf("Failed to open an output file!\n"); return 0; }
    }

    static unsigned char string[MAX_INPUT_LENGTH + 1];

    const uint64_t length = input(string, read_mode);
    if (length > MAX_INPUT_LENGTH) return 0;

    clock_t start = clock();
    struct Result answer = solve(string, length);
    clock_t end = clock();
    uint64_t cpu_time_used = (1000000000 * (uint64_t)(end - start)) / CLOCKS_PER_SEC; // in nanoseconds

    output(answer);
    printf("\nCPU time used: %lluns", cpu_time_used);

    return 0;
}