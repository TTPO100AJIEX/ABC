	.file	"4-solution.c"
	.intel_syntax noprefix
	.text
	.section	.rodata
	.type	ulli_input_template, @object
	.size	ulli_input_template, 5
ulli_input_template:
	.string	"%llu"
	.type	lli_input_template, @object
	.size	lli_input_template, 5
lli_input_template:
	.string	"%lld"
	.type	lli_output_template, @object
	.size	lli_output_template, 6
lli_output_template:
	.string	"%lld "
	.local	A
	.comm	A,134217728,32
	.local	B
	.comm	B,134217728,32
	.local	A_length
	.comm	A_length,8,8
	.local	B_length
	.comm	B_length,8,8
	.align 16
	.type	too_long_array_error, @object
	.size	too_long_array_error, 17
too_long_array_error:
	.string	"Input too large!"
	.text
	.globl	input
	.type	input, @function
input:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 16
	lea	rsi, A_length[rip]
	lea	rdi, ulli_input_template[rip]
	mov	eax, 0
	call	__isoc99_scanf@PLT
	mov	rax, QWORD PTR A_length[rip]
	cmp	rax, 16777214
	jbe	.L2
	mov	eax, 0
	jmp	.L3
.L2:
	mov	QWORD PTR -8[rbp], 1
	jmp	.L4
.L5:
	mov	rax, QWORD PTR -8[rbp]
	lea	rdx, 0[0+rax*8]
	lea	rax, A[rip]
	add	rax, rdx
	mov	rsi, rax
	lea	rdi, lli_input_template[rip]
	mov	eax, 0
	call	__isoc99_scanf@PLT
	add	QWORD PTR -8[rbp], 1
.L4:
	mov	rax, QWORD PTR A_length[rip]
	cmp	QWORD PTR -8[rbp], rax
	jbe	.L5
	movabs	rax, 9223372036854775807
	mov	QWORD PTR A[rip], rax
	mov	rax, QWORD PTR A_length[rip]
	add	rax, 1
	lea	rdx, 0[0+rax*8]
	lea	rax, A[rip]
	movabs	rcx, -9223372036854775808
	mov	QWORD PTR [rdx+rax], rcx
	mov	eax, 1
.L3:
	leave
	ret
	.size	input, .-input
	.globl	solve
	.type	solve, @function
solve:
	push	rbp
	mov	rbp, rsp
	mov	QWORD PTR -8[rbp], 1
	jmp	.L7
.L10:
	mov	rax, QWORD PTR -8[rbp]
	lea	rdx, 0[0+rax*8]
	lea	rax, A[rip]
	mov	rdx, QWORD PTR [rdx+rax]
	mov	rax, QWORD PTR -8[rbp]
	sub	rax, 1
	lea	rcx, 0[0+rax*8]
	lea	rax, A[rip]
	mov	rax, QWORD PTR [rcx+rax]
	cmp	rdx, rax
	jge	.L8
	mov	rax, QWORD PTR -8[rbp]
	lea	rdx, 0[0+rax*8]
	lea	rax, A[rip]
	mov	rdx, QWORD PTR [rdx+rax]
	mov	rax, QWORD PTR -8[rbp]
	add	rax, 1
	lea	rcx, 0[0+rax*8]
	lea	rax, A[rip]
	mov	rax, QWORD PTR [rcx+rax]
	cmp	rdx, rax
	jg	.L9
.L8:
	mov	rax, QWORD PTR B_length[rip]
	lea	rdx, 1[rax]
	mov	QWORD PTR B_length[rip], rdx
	mov	rdx, QWORD PTR -8[rbp]
	lea	rcx, 0[0+rdx*8]
	lea	rdx, A[rip]
	mov	rdx, QWORD PTR [rcx+rdx]
	lea	rcx, 0[0+rax*8]
	lea	rax, B[rip]
	mov	QWORD PTR [rcx+rax], rdx
.L9:
	add	QWORD PTR -8[rbp], 1
.L7:
	mov	rax, QWORD PTR A_length[rip]
	cmp	QWORD PTR -8[rbp], rax
	jbe	.L10
	nop
	pop	rbp
	ret
	.size	solve, .-solve
	.globl	output
	.type	output, @function
output:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 16
	mov	QWORD PTR -8[rbp], 0
	jmp	.L12
.L13:
	mov	rax, QWORD PTR -8[rbp]
	lea	rdx, 0[0+rax*8]
	lea	rax, B[rip]
	mov	rax, QWORD PTR [rdx+rax]
	mov	rsi, rax
	lea	rdi, lli_output_template[rip]
	mov	eax, 0
	call	printf@PLT
	add	QWORD PTR -8[rbp], 1
.L12:
	mov	rax, QWORD PTR B_length[rip]
	cmp	QWORD PTR -8[rbp], rax
	jb	.L13
	nop
	leave
	ret
	.size	output, .-output
	.globl	main
	.type	main, @function
main:
	push	rbp
	mov	rbp, rsp
	mov	eax, 0
	call	input
	xor	eax, 1
	test	al, al
	je	.L15
	lea	rdi, too_long_array_error[rip]
	mov	eax, 0
	call	printf@PLT
	mov	eax, 0
	jmp	.L16
.L15:
	mov	eax, 0
	call	solve
	mov	eax, 0
	call	output
	mov	eax, 0
.L16:
	pop	rbp
	ret
	.size	main, .-main
	.ident	"GCC: (Debian 8.3.0-6) 8.3.0"
	.section	.note.GNU-stack,"",@progbits
