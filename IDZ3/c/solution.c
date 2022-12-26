#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>
#define uint64_t unsigned long long int

double input(bool is_random)
{
    double result = 0;
    if (is_random) { srand(time(NULL)); result = 2.0 * rand() / RAND_MAX - 1; }
    else { scanf("%lf", &result); }
    return result;
}

double solve(double x)
{
    if ((1 - x * x) < 1e-7) return ((x < 0) ? -1.5707963 : 1.5707963); // x = 1 and x = -1
    double answer = 0, g = x;
    unsigned int k = 0;
    while (fabs(g / (1 - x * x)) >= 0.0005)
    {
        answer += g; k++;
        g *= (x*x) * ((2*k-1) * (2*k-1)) / ((2*k) * (2*k+1));
    }
    return answer;
}

void output(double x)
{
    printf("%.7lf\n", x);
}

int main(int argc, char** argv)
{
    if (argc < 4) { printf("Incorrect command line arguments provided!\n"); return 0; }
    bool loop = (argv[1][0] == '1');
    bool random_input = false, do_write = true;
    unsigned int output_flag_argv_index = 3;

    if (argv[2][0] == '1')
    {
        if (argc < 5) { printf("Incorrect command line arguments provided!\n"); return 0; }
        if (!freopen(argv[output_flag_argv_index++], "r", stdin)) { printf("Failed to open an input file!\n"); return 0; }
    }
    if (argv[2][0] == '2') random_input = true;

    if (argc < output_flag_argv_index + 1) { printf("Incorrect command line arguments provided!\n"); return 0; }
    if (argv[output_flag_argv_index][0] == '1')
    {
        if (argc < output_flag_argv_index + 2) { printf("Incorrect command line arguments provided!\n"); return 0; }
        if (!freopen(argv[output_flag_argv_index + 1], "w", stdout)) { printf("Failed to open an output file!\n"); return 0; }
    }
    if (argv[output_flag_argv_index][0] == '2') do_write = false;


    double x = input(random_input);
    if (fabs(x) > 1) { printf("Incorrect input provided!\n"); return 0; }

    double answer = 0;
    clock_t start = clock();
    for (uint64_t i = 0; i < (loop ? 1e8 : 1); i++) answer = solve(x);
    clock_t end = clock();
    uint64_t cpu_time_used = (1000000000 * (uint64_t)(end - start)) / CLOCKS_PER_SEC; // in nanoseconds
    
    if (do_write) output(answer);
    printf("CPU time used: %lluns", cpu_time_used);
    return 0;
}