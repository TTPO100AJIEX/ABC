gcc -masm=intel -O0 -Wall -fno-asynchronous-unwind-tables -S 9/solution.c -o 9/solution-c-O0.s
gcc -O0 9/solution.c -o 9/solution-c-O0.exe

gcc -masm=intel -O1 -Wall -fno-asynchronous-unwind-tables -S 9/solution.c -o 9/solution-c-O1.s
gcc -O1 9/solution.c -o 9/solution-c-O1.exe

gcc -masm=intel -O2 -Wall -fno-asynchronous-unwind-tables -S 9/solution.c -o 9/solution-c-O2.s
gcc -O2 9/solution.c -o 9/solution-c-O2.exe

gcc -masm=intel -O3 -Wall -fno-asynchronous-unwind-tables -S 9/solution.c -o 9/solution-c-O3.s
gcc -O3 9/solution.c -o 9/solution-c-O3.exe

gcc -masm=intel -Os -Wall -fno-asynchronous-unwind-tables -S 9/solution.c -o 9/solution-c-Os.s
gcc -Os 9/solution.c -o 9/solution-c-Os.exe

gcc -masm=intel -Ofast -Wall -fno-asynchronous-unwind-tables -S 9/solution.c -o 9/solution-c-Ofast.s
gcc -Ofast 9/solution.c -o 9/solution-c-Ofast.exe

as 9/asm/solution-main.s -o 9/asm/solution-main.o
as 9/asm/solution-input.s -o 9/asm/solution-input.o
as 9/asm/solution-solve.s -o 9/asm/solution-solve.o
as 9/asm/solution-output.s -o 9/asm/solution-output.o
gcc 9/asm/solution-main.o 9/asm/solution-input.o 9/asm/solution-solve.o 9/asm/solution-output.o -o 9/solution-asm.exe