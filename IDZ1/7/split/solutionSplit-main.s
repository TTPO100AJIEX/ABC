    .intel_syntax noprefix
	
    
    .text
    .globl	main
main:
	push rbp # save frame pointer
	mov	rbp, rsp # save stack pointer
	sub	rsp, 2097184 # allocate a lot of memory on the stack

	lea	rdi, -1048592[rbp] # rdi <-- address of array A - first function argument
	mov	esi, 131072 # esi ~ rsi <-- MAX_INPUT_LENGTH - second function argument
	call input # input(A, MAX_INPUT_LENGTH)

	lea	rdi, -1048592[rbp] # rdi <-- address of array A - first function argument
	mov	rsi, rax # rsi <-- return value of input(A, MAX_INPUT_LENGTH) - second function argument
	lea	rdx, -2097184[rbp] # rdx <-- address of array B - third function argument
	call solve # solve(A, input(A, MAX_INPUT_LENGTH), B)

	lea	rdi, -2097184[rbp] # rdi <-- address of array B - first function argument
	mov	rsi, rax # rsi <-- return value of solve(...) - second function argument
	call output # output(B, solve(A, input(A, MAX_INPUT_LENGTH), B));

	mov	eax, 0 # 0 - return value
	leave # restore stack and frame pointers
	ret # return
