	.intel_syntax noprefix
	

	.section .rodata
.LC0:  # бывшая переменная ulli_input_template
	.string	"%llu"
.LC1:  # бывшая переменная too_long_array_error
	.string	"Input too large!"
.LC2:  # бывшая переменная lli_input_template
	.string	"%lld"





	.text
input:
	push rbp # save frame pointer
	mov	rbp, rsp # save stack pointer
	push r12 # save r12 on the stack
	push r13 # save r13 on the stack
	push rbx # save rbx on the stack and let it be uint64_t length
	mov r12, rdi # put rdi - first function argument (int64_t* memory) - into a callee-saved register r12
	mov r13, rsi # put rsi (const uint64_t max_input_length) - second function argument - into a callee-saved register r13
	sub rsp, 8 # scanf requires stack alignment by 32-bit

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





solve:
	push rbp # save frame pointer
	mov	rbp, rsp # save stack pointer
	# rdi - first function argument (const int64_t* src)
	# rsi - second function argument (const uint64_t src_length)
	# rdx - third function argument (int64_t* dest)
	# rax - uint64_t length
	# rcx - uint64_t i
	mov rax, 0 # uint64_t length = 0;
	mov rcx, 1 # uint64_t i = 1;
	jmp	.L8
.L11:
	mov r8, [rdi + 8 * rcx] # r8 <-- src[i]
	mov r9, [rdi + 8 * rcx - 8] # r9 <-- src[i - 1]
	cmp	r8, r9 # src[i] v src[i - 1]
	jge	.L9 # src[i] >= src[i - 1] => condition is true ("short-circuit" evaluation)

	mov r10, [rdi + 8 * rcx + 8] # r10 <-- src[i + 1]
	cmp	r8, r10 # src[i] v src[i + 1]
	jg .L10 # src[i] > src[i + 1] => condition is false

.L9:
	inc rax # ++length
	mov	QWORD PTR [rdx + 8 * rax], r8 # dest[++length] = src[i]

.L10:
	inc rcx # i = i + 1 <==> i++
.L8:
	cmp	rcx, rsi # i v src_length
	jbe	.L11 # if (i <= src_length) - continue the loop

	# return value (length) is already in rax
	pop	rbp # restore frame pointer, stack pointer has not been changed
	ret # return






	.section	.rodata
.LC3:
	.string	"%lld "  # бывшая переменная lli_output_template

output:
	push rbp # save frame pointer
	mov	rbp, rsp # save stack pointer
	push r12 # save r12 on the stack
	push r13 # save r13 on the stack
	push rbx # save rbx on the stack and let it be uint64_t i

	mov r12, rdi # put rdi - first function argument (const int64_t* memory) - into a callee-saved register r12
	mov r13, rsi # put rsi - second function argument (const uint64_t length) - into a callee-saved register r13
	mov rbx, 1 # uint64_t i = 1
	jmp	.L14
.L15:
	lea	rdi, .LC3[rip] # rdi <-- address of "%lld " - first function argument
	mov rsi, [r12 + 8 * rbx] # rsi <-- memory[i] - second function argument
	mov	eax, 0 # we do not expect printf() to use coprocessors (x87, SSE, etc.)
	call printf@PLT # printf("%lld ", memory[i]);

	inc rbx # i++
.L14:
	cmp	rbx, r13 # i v length
	jbe	.L15 # if (i <= length) - continue the loop
    
	pop rbx # restore the value of rbx
	pop r13 # restore the value of r13
	pop r12 # restore the value of r12
	pop	rbp # restore frame pointer, stack pointer has not been changed
	ret # return






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
