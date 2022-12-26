as 10/solution-main.s -o 10/solution-main.o
as 10/solution-input.s -o 10/solution-input.o
as 10/solution-solve.s -o 10/solution-solve.o
as 10/solution-output.s -o 10/solution-output.o
as 10/solution-libc-numbers.s -o 10/solution-libc-numbers.o
ld 10/solution-main.o 10/solution-input.o 10/solution-solve.o 10/solution-output.o 10/solution-libc-numbers.o -o 10/solution-asm.exe