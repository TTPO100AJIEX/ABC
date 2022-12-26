    .intel_syntax noprefix
	
.too_long_array_error:
	.quad 16 # length
	.string	"Input too large!"

	
    .text
    .globl	input
input:
	push r12 # save r12 on the stack
	push r13 # save r13 on the stack
	push r14 # save r14 on the stack
	push rbx # save rbx on the stack and let it be uint64_t length
	push rbp # save frame pointer
	mov	rbp, rsp # save stack pointer
	sub rsp, 8


	mov r12, rdi # put rdi - first function argument (int64_t* memory) - into a callee-saved register r12
	mov r13, rsi # put rsi (const uint64_t max_input_length) - second function argument - into a callee-saved register r13
	mov r14, rdx # put rdx - third function argument (unsigned int mode) - into a callee-saved register r14

	call scanf # read length

	mov rbx, rax # rbx <-- length
	cmp r13, rbx # max_input_length v length
	jnb	.input_length_fine # if (max_input_length >= length) => goto L2
	mov rax, 1 # sys_write
	mov rdi, QWORD PTR .outstream[rip] # outstream
	lea rsi, .too_long_array_error[rip + 8] # rdi <-- address of "Incorrect command line arguments provided!"
	mov rdx, QWORD PTR .too_long_array_error[rip] # 16 - length of string
	syscall
	mov rax, 0
	jmp .return
.input_length_fine:
	mov r13, 0 # let uint64_t i be stored in r13 (we de not need max_input_length anymore, so we can override it)
	jmp	.L4
.L5:
	cmp r14, 1 # mode v 1
	je .get_value_from_random
	.get_value_from_scanf:
		call scanf
		mov QWORD PTR [r12 + 8 * r13], rax
		jmp	.L4
	.get_value_from_random:
		mov rax, 318 # sys_getrandom
		mov rdi, rsp
		mov rsi, 8
		mov rdx, 0
		syscall
		mov rax, QWORD PTR [rsp]
		mov	QWORD PTR [r12 + 8 * r13], rax # memory[i] = rand();
.L4:
	inc r13 # i++
	cmp	r13, rbx # i v length
	jbe	.L5 # if (i <= length) => continue the loop

	movabs	rcx, 9223372036854775807 # rcx <-- LLONG_MAX
	mov	QWORD PTR [r12], rcx # memory[0] = LLONG_MAX
	movabs	rcx, -9223372036854775808 # rcx <-- LLONG_MAX
	mov	QWORD PTR [r12 + 8 * rbx + 8], rcx # memory[length + 1] = LLONG_MIN

	mov	rax, rbx # length - return value
.return:
	leave # restore stack and frame pointers
	pop rbx # restore the value of rbx
	pop r14 # restore the value of r14
	pop r13 # restore the value of r13
	pop r12 # restore the value of r12
	ret # return
