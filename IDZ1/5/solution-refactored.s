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
	sub	rsp, 32 # allocate 32 bytes on the stack
	mov	QWORD PTR -24[rbp], rdi # put rdi - first function argument (int64_t* memory) - onto the stack
	mov	QWORD PTR -32[rbp], rsi # put rsi (const uint64_t max_input_length) - second function argument - onto the stack
	
    lea	rax, -16[rbp] # rax <-- address of local variable uint64_t length
	mov	rsi, rax # rsi <-- &length - second function argument
	lea	rdi, .LC0[rip] # rdi <-- address of "%llu" - first function argument
	mov	eax, 0 # we do not expect scanf() to use coprocessors (x87, SSE, etc.)
	call __isoc99_scanf@PLT # scanf("%llu", &length);

	mov	rax, QWORD PTR -16[rbp] # rax <-- length
	cmp	QWORD PTR -32[rbp], rax # max_input_length v length
	jnb	.L2 # if (max_input_length >= length) => goto L2
	lea	rdi, .LC1[rip] # rdi <-- address of "Input too large!" - first function argument
	mov	eax, 0 # we do not expect printf() to use coprocessors (x87, SSE, etc.)
	call printf@PLT # printf("Input too large!");
	mov	eax, 0 # 0 - return value
	jmp	.L6 # goto return


.L2:
	mov	QWORD PTR -8[rbp], 1 # uint64_t i = 1 - i is stored on the stack at offset -8
	jmp	.L4
.L5:
	mov	rax, QWORD PTR -8[rbp] # rax <-- i
	lea	rdx, 0[0+rax*8] # rdx <-- 8*i = i * sizeof(long long int)
	mov	rax, QWORD PTR -24[rbp] # rax <-- memory = &memory[0]
	add	rax, rdx # rax <-- rax + rdx = memory + 8*i

	mov	rsi, rax # rsi <-- &memory[i] - second function argument
	lea	rdi, .LC2[rip] # rdi <-- address of "%lld" - first function argument
	mov	eax, 0 # we do not expect scanf() to use coprocessors (x87, SSE, etc.)
	call __isoc99_scanf@PLT # scanf("%lld", &memory[i]);
	add	QWORD PTR -8[rbp], 1 # i++
.L4:
	mov	rax, QWORD PTR -16[rbp] # rax <-- length
	cmp	QWORD PTR -8[rbp], rax # i v length
	jbe	.L5 # if (i <= length) => continue the loop


	mov	rax, QWORD PTR -24[rbp] # rax <-- memory = &memory[0]
	movabs	rcx, 9223372036854775807 # rcx <-- LLONG_MAX
	mov	QWORD PTR [rax], rcx # memory[0] = LLONG_MAX

	mov	rax, QWORD PTR -16[rbp] # rax <-- length
	add	rax, 1 # rax <-- length + 1
	lea	rdx, 0[0+rax*8] # rax <-- (length + 1) * sizeof(long long int)
	mov	rax, QWORD PTR -24[rbp] # rax <-- memory = &memory[0]
	add	rax, rdx # rax <-- memory + (length + 1) * sizeof(long long int) = &memory[length + 1]
	movabs	rcx, -9223372036854775808 # rcx <-- LLONG_MIN
	mov	QWORD PTR [rax], rcx # memory[length + 1] = LLONG_MIN

	mov	rax, QWORD PTR -16[rbp] # length - return value
.L6:
	leave # restore stack and frame pointers
	ret # return





solve:
	push rbp # save frame pointer
	mov	rbp, rsp # save stack pointer
	mov	QWORD PTR -24[rbp], rdi # put rdi - first function argument (const int64_t* src) - onto the stack
	mov	QWORD PTR -32[rbp], rsi # put rsi - second function argument (const uint64_t src_length) - onto the stack
	mov	QWORD PTR -40[rbp], rdx # put rdx - third function argument (int64_t* dest) - onto the stack

	mov	QWORD PTR -8[rbp], 0 # uint64_t length = 0; - length is stored on the stack at offset -8

	mov	QWORD PTR -16[rbp], 1 # uint64_t i = 1; - i is stored on the stack at offset -16
	jmp	.L8
.L11:
	mov	rax, QWORD PTR -16[rbp] # rax <-- i
	lea	rdx, 0[0+rax*8] # rdx = 8 * rax = i * sizeof(long long int)
	mov	rax, QWORD PTR -24[rbp] # rax <-- src
	add	rax, rdx # rax <-- rax + rdx = src + i * sizeof(long long int) = &src[i]
	mov	rdx, QWORD PTR [rax] # rdx <-- src[i]
    
	mov	rax, QWORD PTR -16[rbp] # rax <-- i
	sal	rax, 3 # rax <-- (rax << 3) = rax * 8 = i * sizeof(long long int)
	lea	rcx, -8[rax] # rcx <-- rax - 8 = (i - 1) * sizeof(long long int)
	mov	rax, QWORD PTR -24[rbp] # rax <-- src
	add	rax, rcx # rax <-- rax + rcx = src + (i - 1) * sizeof(long long int) = &src[i - 1]
	mov	rax, QWORD PTR [rax] # rax <-- src[i - 1]

	cmp	rdx, rax # src[i] v src[i - 1]
	jge	.L9 # src[i] >= src[i - 1] => condition is true ("short-circuit" evaluation)

	mov	rax, QWORD PTR -16[rbp] # rax <-- i
	lea	rdx, 0[0+rax*8] # rdx = 8 * rax = i * sizeof(long long int)
	mov	rax, QWORD PTR -24[rbp] # rax <-- src
	add	rax, rdx # rax <-- rax + rdx = src + i * sizeof(long long int) = &src[i]
	mov	rdx, QWORD PTR [rax] # rdx <-- src[i]

	mov	rax, QWORD PTR -16[rbp] # rax <-- i
	add	rax, 1 # rax <-- i + 1
	lea	rcx, 0[0+rax*8] # rcx <-- rax - 8 = (i + 1) * sizeof(long long int)
	mov	rax, QWORD PTR -24[rbp] # rax <-- src
	add	rax, rcx # rax <-- rax + rcx = src + (i + 1) * sizeof(long long int) = &src[i + 1]
	mov	rax, QWORD PTR [rax] # rax <-- src[i + 1]
	cmp	rdx, rax # src[i] v src[i + 1]
	jg	.L10 # src[i] > src[i + 1] => condition is false

.L9:
	mov	rax, QWORD PTR -16[rbp] # rax <-- i
	lea	rdx, 0[0+rax*8] # rdx <-- i * sizeof(long long int)
	mov	rax, QWORD PTR -24[rbp] # rax <-- src
	add	rax, rdx # rax <-- rax + rdx = src + 8*i = &src[i]

	add	QWORD PTR -8[rbp], 1 # ++length
	mov	rdx, QWORD PTR -8[rbp] # rdx <-- length
	lea	rcx, 0[0+rdx*8] # rcx <-- length * sizeof(long long int)
	mov	rdx, QWORD PTR -40[rbp] # rdx <-- dest = &dest[0]
	add	rdx, rcx # rdx <-- rdx + rcx = dest + 8 * length = &dest[++length]

	mov	rax, QWORD PTR [rax] # rax <-- src[i]
	mov	QWORD PTR [rdx], rax # dest[++length] = src[i]

.L10:
	add	QWORD PTR -16[rbp], 1 # i = i + 1 <==> i++

.L8:
	mov	rax, QWORD PTR -16[rbp] # i
	cmp	rax, QWORD PTR -32[rbp] # i v src_length
	jbe	.L11 # if (i <= src_length) - continue the loop


	mov	rax, QWORD PTR -8[rbp] # length - return value
	pop	rbp # restore frame pointer, stack pointer has not been changed
	ret # return






	.section	.rodata
.LC3:
	.string	"%lld "  # бывшая переменная lli_output_template

output:
	push rbp # save frame pointer
	mov	rbp, rsp # save stack pointer
	sub	rsp, 32 # allocate 32 bytes on the stack

	mov	QWORD PTR -24[rbp], rdi # put rdi - first function argument (const int64_t* memory) - onto the stack
	mov	QWORD PTR -32[rbp], rsi # put rsi - second function argument (const uint64_t length) - onto the stack
	mov	QWORD PTR -8[rbp], 1 # uint64_t i = 1 - i is stored on the stack at offset -8
	jmp	.L14
.L15:
	mov	rax, QWORD PTR -8[rbp] # rax <-- i
	lea	rdx, 0[0+rax*8] # rdx <-- 8 * rax = 8 * i = i * sizeof(long long int)
	mov	rax, QWORD PTR -24[rbp] # rax <-- memory
	add	rax, rdx # rax <-- rax + rdx = memory + 8 * i = &memory[i]
	mov	rax, QWORD PTR [rax] # rax <-- memory[i]

	mov	rsi, rax # rsi <-- memory[i] - second function argument
	lea	rdi, .LC3[rip] # rdi <-- address of "%lld " - first function argument
	mov	eax, 0 # we do not expect printf() to use coprocessors (x87, SSE, etc.)
	call printf@PLT # printf("%lld ", memory[i]);

	add	QWORD PTR -8[rbp], 1 # i++
.L14:
	mov	rax, QWORD PTR -8[rbp] # rax <-- i
	cmp	rax, QWORD PTR -32[rbp] # i v length
	jbe	.L15 # if (i <= length) - continue the loop
    
	leave # restore stack and frame pointers
	ret # return






	.globl	main
main:
	push rbp # save frame pointer
	mov	rbp, rsp # save stack pointer
	sub	rsp, 2097184 # allocate a lot of memory on the stack

	lea	rax, -1048592[rbp] # rax <-- address of array A
	mov	esi, 131072 # esi ~ rsi <-- MAX_INPUT_LENGTH - second function argument
	mov	rdi, rax # rdi <-- address of array A - first function argument
	call input # input(A, MAX_INPUT_LENGTH)

	mov	rcx, rax # rcx <-- return value of input(A, MAX_INPUT_LENGTH)
	lea	rdx, -2097184[rbp] # rdx <-- address of array B - third function argument
	lea	rax, -1048592[rbp] # rax <-- address of array A
	mov	rsi, rcx # rsi <-- rcx - second function argument
	mov	rdi, rax # rdi <-- address of array A - first function argument
	call solve # solve(A, input(A, MAX_INPUT_LENGTH), B)

	mov	rdx, rax # rdx <-- return value of solve(...)
	lea	rax, -2097184[rbp] # rax <-- address of array B
	mov	rsi, rdx # rsi <-- rdx - second function argument
	mov	rdi, rax # rdi <-- address of array B - first function argument
	call output # output(B, solve(A, input(A, MAX_INPUT_LENGTH), B));

	mov	eax, 0 # 0 - return value
	leave # restore stack and frame pointers
	ret # return
