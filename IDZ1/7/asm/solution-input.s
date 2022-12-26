	.intel_syntax noprefix
	

	.section .rodata
.LC0:  # бывшая переменная ulli_input_template
	.string	"%llu"
.LC1:  # бывшая переменная too_long_array_error
	.string	"Input too large!"
.LC2:  # бывшая переменная lli_input_template
	.string	"%lld"





    .text
    .globl	input
input:
	push rbp # save frame pointer
	mov	rbp, rsp # save stack pointer
	push r12 # save r12 on the stack
	push r13 # save r13 on the stack
	push rbx # save rbx on the stack and let it be uint64_t length
	mov r12, rdi # put rdi - first function argument (int64_t* memory) - into a callee-saved register r12
	mov r13, rsi # put rsi (const uint64_t max_input_length) - second function argument - into a callee-saved register r13
	sub rsp, 8 # scanf requires stack alignment by 16-bit

	lea	rdi, .LC0[rip] # rdi <-- address of "%llu" - first function argument
	mov	rsi, r12 # scanf() can only read into RAM, so let memory[0] get the length; rsi <-- &memory[0] - second function argument
	mov	eax, 0 # we do not expect scanf() to use coprocessors (x87, SSE, etc.)
	call __isoc99_scanf@PLT # scanf("%llu", &length);
	mov rbx, [r12] # rbx <-- length

	cmp r13, rbx # max_input_length v length
	jnb	.L2 # if (max_input_length >= length) => goto L2

	lea	rdi, .LC1[rip] # rdi <-- address of "Input too large!" - first function argument
	mov	eax, 0 # we do not expect printf() to use coprocessors (x87, SSE, etc.)
	call printf@PLT # printf("Input too large!");
	mov	eax, 0 # 0 - return value
	jmp	.L6 # goto return

.L2:
	mov r13, 1 # let uint64_t i be stored in r13 (we de not need max_input_length anymore, so we can override it)
	jmp	.L4
.L5:
	lea	rdi, .LC2[rip] # rdi <-- address of "%lld" - first function argument
	lea rsi, [r12 + 8 * r13] # rsi <-- &memory[i] - second function argument
	mov	eax, 0 # we do not expect scanf() to use coprocessors (x87, SSE, etc.)
	call __isoc99_scanf@PLT # scanf("%lld", &memory[i]);
	inc r13 # i++
.L4:
	cmp	r13, rbx # i v length
	jbe	.L5 # if (i <= length) => continue the loop

	movabs	rcx, 9223372036854775807 # rcx <-- LLONG_MAX
	mov	QWORD PTR [r12], rcx # memory[0] = LLONG_MAX
	movabs	rcx, -9223372036854775808 # rcx <-- LLONG_MAX
	mov	QWORD PTR [r12 + 8 * rbx + 8], rcx # memory[length + 1] = LLONG_MIN

	mov	rax, rbx # length - return value
.L6:
	add rsp, 8 # clear stack in reverse order
	pop rbx # restore the value of rbx
	pop r13 # restore the value of r13
	pop r12 # restore the value of r12
	pop rbp # restore frame pointer, stack pointer has not been changed
	ret # return
