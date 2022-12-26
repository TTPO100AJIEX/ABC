gcc 8/solution.c -o 8/solution-c.exe

as 8/asm/solution-main.s -o 8/asm/solution-main.o
as 8/asm/solution-input.s -o 8/asm/solution-input.o
as 8/asm/solution-solve.s -o 8/asm/solution-solve.o
as 8/asm/solution-output.s -o 8/asm/solution-output.o
gcc 8/asm/solution-main.o 8/asm/solution-input.o 8/asm/solution-solve.o 8/asm/solution-output.o -o 8/solution-asm.exe