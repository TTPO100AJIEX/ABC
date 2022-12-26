as 7/split/solutionSplit-main.s -o 7/split/solutionSplit-main.o
as 7/split/solutionSplit-input.s -o 7/split/solutionSplit-input.o
as 7/split/solutionSplit-solve.s -o 7/split/solutionSplit-solve.o
as 7/split/solutionSplit-output.s -o 7/split/solutionSplit-output.o
gcc 7/split/solutionSplit-main.o 7/split/solutionSplit-input.o 7/split/solutionSplit-solve.o 7/split/solutionSplit-output.o -o 7/solutionSplit-asm.exe

gcc 7/solution.c -o 7/solution-c.exe

as 7/asm/solution-main.s -o 7/asm/solution-main.o
as 7/asm/solution-input.s -o 7/asm/solution-input.o
as 7/asm/solution-solve.s -o 7/asm/solution-solve.o
as 7/asm/solution-output.s -o 7/asm/solution-output.o
gcc 7/asm/solution-main.o 7/asm/solution-input.o 7/asm/solution-solve.o 7/asm/solution-output.o -o 7/solution-asm.exe