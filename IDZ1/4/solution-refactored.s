	.intel_syntax noprefix
	

	.section .rodata
ulli_input_template:  # переменная ulli_input_template
	.string	"%llu"
lli_input_template:  # переменная lli_input_template
	.string	"%lld"
lli_output_template:  # переменная lli_output_template
	.string	"%lld "

	.comm A, 134217728, 32  # переменная A - массив 8-байтных элементов размера 16777216 (134217728 байт)
	.comm B, 134217728, 32  # переменная B - массив 8-байтных элементов размера 16777216 (134217728 байт)
	.comm A_length, 8, 8  # переменная A_length размером 8 байт
	.comm B_length, 8, 8  # переменная B_length размером 8 байт

too_long_array_error:  # переменная too_long_array_error
	.string	"Input too large!"





	.text
input:
	push rbp # save frame pointer
	mov	rbp, rsp # save stack pointer
	sub	rsp, 16 # allocate 16 bytes on stack

	lea	rsi, A_length[rip] # rsi <-- &A_length - second function argument
	lea	rdi, ulli_input_template[rip] # rdi <-- ulli_input_template - first function argument
	mov	eax, 0 # we do not expect scanf() to use coprocessors (x87, SSE, etc.)
	call	__isoc99_scanf@PLT # scanf(ulli_input_template, &A_length);

	mov	rax, QWORD PTR A_length[rip]
	cmp	rax, 16777214 # A_length v MAX_INPUT_LENGTH
	jbe	.L2 # if (A_length <= MAX_INPUT_LENGTH)
	mov	eax, 0 # false - return value
	jmp	.L3 # goto: return


.L2:
	# i is located on the stack in the last 8 bytes inside the frame of this call
	mov	QWORD PTR -8[rbp], 1 # size_t i = 1
	jmp	.L4
.L5:
	mov	rax, QWORD PTR -8[rbp] # rax <-- i
	lea	rdx, 0[0+rax*8] # rdx <-- 8*i = i * sizeof(long long int)
	lea	rax, A[rip] # rax <-- A = &A[0]
	add	rax, rdx # rax <-- rax + rdx = &A[i]

	mov	rsi, rax # rsi <-- &A[i] - second function argument
	lea	rdi, lli_input_template[rip] # rdi <-- lli_input_template - first function argument
	mov	eax, 0 # we do not expect scanf() to use coprocessors (x87, SSE, etc.)
	call	__isoc99_scanf@PLT # scanf(lli_input_template, &A[i])
	add	QWORD PTR -8[rbp], 1 # i = i + 1 <==> i++
.L4:
	mov	rax, QWORD PTR A_length[rip]
	cmp	QWORD PTR -8[rbp], rax # i v A_length
	jbe	.L5 # if (i <= A_length) - continue the loop


	movabs	rax, 9223372036854775807 # rax <-- LLONG_MAX
	mov	QWORD PTR A[rip], rax # A[0] = LLONG_MAX;

	mov	rax, QWORD PTR A_length[rip] # rax <-- A_length
	add	rax, 1 # rax <-- A_length + 1
	lea	rdx, 0[0+rax*8] # rdx = rax * 8 = rax * sizeof(long long int)
	lea	rax, A[rip] # rax <-- A = &A[0]
	movabs	rcx, -9223372036854775808 # rcx <-- LLONG_MIN
	mov	QWORD PTR [rdx+rax], rcx # A[A_length + 1] = LLONG_MIN;

	mov	eax, 1 # true - return value
.L3:
	leave # restore stack and frame pointers
	ret # return





solve:
	push rbp # save frame pointer
	mov	rbp, rsp # save stack pointer


	# A_index is located on the stack in the last 8 bytes inside the frame of this call
	mov	QWORD PTR -8[rbp], 1 # size_t A_index = 1
	jmp	.L7
.L10:
	mov	rax, QWORD PTR -8[rbp] # rax <-- A_index
	lea	rdx, 0[0+rax*8] # rdx <-- 8 * A_index = A_index * sizeof(long long int)
	lea	rax, A[rip] # rax <-- A = &A[0]
	mov	rdx, QWORD PTR [rdx+rax] # rdx <-- A[A_index]

	mov	rax, QWORD PTR -8[rbp] # rax <-- A_index
	sub	rax, 1 # rax <-- A_index - 1
	lea	rcx, 0[0+rax*8] # rcx <-- 8 * (A_index - 1) = (A_index - 1) * sizeof(long long int)
	lea	rax, A[rip] # rax <-- A = &A[0]
	mov	rax, QWORD PTR [rcx+rax] # A[A_index - 1]
	
	cmp	rdx, rax # A[A_index] v A[A_index - 1]
	jge	.L8 # A[A_index] >= A[A_index - 1] => condition is true ("short-circuit" evaluation)

	mov	rax, QWORD PTR -8[rbp] # rax <-- A_index
	lea	rdx, 0[0+rax*8] # rdx <-- 8 * A_index = A_index * sizeof(long long int)
	lea	rax, A[rip] # rax <-- A = &A[0]
	mov	rdx, QWORD PTR [rdx+rax] # rdx <-- A[A_index]

	mov	rax, QWORD PTR -8[rbp] # rax <-- A_index
	add	rax, 1 # rax <-- A_index + 1
	lea	rcx, 0[0+rax*8] # rcx <-- 8 * (A_index + 1) = (A_index + 1) * sizeof(long long int)
	lea	rax, A[rip] # rax <-- A = &A[0]
	mov	rax, QWORD PTR [rcx+rax] # A[A_index + 1]
	
	cmp	rdx, rax # A[A_index] v A[A_index + 1]
	jg	.L9 # A[A_index] > A[A_index - 1] => condition is false

.L8:
	mov	rax, QWORD PTR B_length[rip] # rax <-- B_length
	lea	rdx, 1[rax] # rdx <-- rax + 1 = B_length + 1
	mov	QWORD PTR B_length[rip], rdx # B_length = rdx = B_length + 1

	mov	rdx, QWORD PTR -8[rbp] # rdx <-- A_index
	lea	rcx, 0[0+rdx*8] # rcx <-- 8 * A_index = A_index * sizeof(long long int)
	lea	rdx, A[rip] # rdx <-- A = &A[0]
	mov	rdx, QWORD PTR [rcx+rdx] # rdx <-- A[A_index]

	lea	rcx, 0[0+rax*8] # rcx <-- 8 * rax = 8 * B_length = B_length * sizeof(long long int)
	lea	rax, B[rip] # rax <-- B = &B[0]
	mov	QWORD PTR [rcx+rax], rdx # B[B_length] = A[A_index]

.L9:
	add	QWORD PTR -8[rbp], 1 # A_index = A_index + 1 <==> A_index++
.L7:
	mov	rax, QWORD PTR A_length[rip]
	cmp	QWORD PTR -8[rbp], rax # A_index v A_length
	jbe	.L10 # A_index <= A_length - continue the loop

	
	pop	rbp # restore frame pointer, stack pointer has not been changed
	ret # return





output:
	push rbp # save frame pointer
	mov	rbp, rsp # save stack pointer
	sub	rsp, 16 # allocate 16 bytes on stack

	# i is located on the stack in the last 8 bytes inside the frame of this call
	mov	QWORD PTR -8[rbp], 0 # size_t i = 1
	jmp	.L12
.L13:
	mov	rax, QWORD PTR -8[rbp] # rax <-- i
	lea	rdx, 0[0+rax*8] # rdx <-- 8 * rax = 8 * i = i * sizeof(long long int)
	lea	rax, B[rip] # rax <-- B = &B[0]
	mov	rax, QWORD PTR [rdx+rax] # rax <-- B[i]
	
	mov	rsi, rax # rsi <-- B[i] - second function argument
	lea	rdi, lli_output_template[rip] # rdi <-- lli_output_template - first function argument
	mov	eax, 0 # we do not expect printf() to use coprocessors (x87, SSE,G etc.)
	call printf@PLT # printf(lli_output_template, B[i]);
	add	QWORD PTR -8[rbp], 1 # i++
.L12:
	mov	rax, QWORD PTR B_length[rip] # rax <-- B_length
	cmp	QWORD PTR -8[rbp], rax # i v B_length
	jb	.L13 # i < B_length - continue the loop
	
	leave # restore stack and frame pointers
	ret # return





.globl main
main:
	push rbp # save frame pointer
	mov	rbp, rsp # save stack pointer

	mov	eax, 0 # we do not expect input() to use coprocessors (x87, SSE,G etc.)
	call input # input
	xor	eax, 1 # remove all bits except the first one
	test al, al # check if the return value is 0
	je .L15 # input() = 0 => everything if fine

	# printf input error
	lea	rdi, too_long_array_error[rip] # rdi <-- too_long_array_error - first function argument
	mov	eax, 0 # we do not expect printf() to use coprocessors (x87, SSE,G etc.)
	call printf@PLT # printf(too_long_array_error);
	mov	eax, 0 # 0 - return value
	jmp	.L16 # goto: return

.L15:
	mov	eax, 0 # we do not expect solve() to use coprocessors (x87, SSE,G etc.)
	call solve # solve();
	mov	eax, 0 # we do not expect output() to use coprocessors (x87, SSE,G etc.)
	call output # output();
	
	mov	eax, 0 # 0 - return value
.L16:
	pop	rbp # restore frame pointer, stack pointer has not been changed
	ret # return
