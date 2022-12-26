	.file	"5-solution.c"
	.intel_syntax noprefix
	.text
	.section	.rodata
.LC0:
	.string	"%llu"
.LC1:
	.string	"Input too large!"
.LC2:
	.string	"%lld"
	.text
	.globl	input
	.type	input, @function
input:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	QWORD PTR -24[rbp], rdi
	mov	QWORD PTR -32[rbp], rsi
	lea	rax, -16[rbp]
	mov	rsi, rax
	lea	rdi, .LC0[rip]
	mov	eax, 0
	call	__isoc99_scanf@PLT
	mov	rax, QWORD PTR -16[rbp]
	cmp	QWORD PTR -32[rbp], rax
	jnb	.L2
	lea	rdi, .LC1[rip]
	mov	eax, 0
	call	printf@PLT
	mov	eax, 0
	jmp	.L6
.L2:
	mov	QWORD PTR -8[rbp], 1
	jmp	.L4
.L5:
	mov	rax, QWORD PTR -8[rbp]
	lea	rdx, 0[0+rax*8]
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rdx
	mov	rsi, rax
	lea	rdi, .LC2[rip]
	mov	eax, 0
	call	__isoc99_scanf@PLT
	add	QWORD PTR -8[rbp], 1
.L4:
	mov	rax, QWORD PTR -16[rbp]
	cmp	QWORD PTR -8[rbp], rax
	jbe	.L5
	mov	rax, QWORD PTR -24[rbp]
	movabs	rcx, 9223372036854775807
	mov	QWORD PTR [rax], rcx
	mov	rax, QWORD PTR -16[rbp]
	add	rax, 1
	lea	rdx, 0[0+rax*8]
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rdx
	movabs	rcx, -9223372036854775808
	mov	QWORD PTR [rax], rcx
	mov	rax, QWORD PTR -16[rbp]
.L6:
	leave
	ret
	.size	input, .-input
	.globl	solve
	.type	solve, @function
solve:
	push	rbp
	mov	rbp, rsp
	mov	QWORD PTR -24[rbp], rdi
	mov	QWORD PTR -32[rbp], rsi
	mov	QWORD PTR -40[rbp], rdx
	mov	QWORD PTR -8[rbp], 0
	mov	QWORD PTR -16[rbp], 1
	jmp	.L8
.L11:
	mov	rax, QWORD PTR -16[rbp]
	lea	rdx, 0[0+rax*8]
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rdx
	mov	rdx, QWORD PTR [rax]
	mov	rax, QWORD PTR -16[rbp]
	sal	rax, 3
	lea	rcx, -8[rax]
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rcx
	mov	rax, QWORD PTR [rax]
	cmp	rdx, rax
	jge	.L9
	mov	rax, QWORD PTR -16[rbp]
	lea	rdx, 0[0+rax*8]
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rdx
	mov	rdx, QWORD PTR [rax]
	mov	rax, QWORD PTR -16[rbp]
	add	rax, 1
	lea	rcx, 0[0+rax*8]
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rcx
	mov	rax, QWORD PTR [rax]
	cmp	rdx, rax
	jg	.L10
.L9:
	mov	rax, QWORD PTR -16[rbp]
	lea	rdx, 0[0+rax*8]
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rdx
	add	QWORD PTR -8[rbp], 1
	mov	rdx, QWORD PTR -8[rbp]
	lea	rcx, 0[0+rdx*8]
	mov	rdx, QWORD PTR -40[rbp]
	add	rdx, rcx
	mov	rax, QWORD PTR [rax]
	mov	QWORD PTR [rdx], rax
.L10:
	add	QWORD PTR -16[rbp], 1
.L8:
	mov	rax, QWORD PTR -16[rbp]
	cmp	rax, QWORD PTR -32[rbp]
	jbe	.L11
	mov	rax, QWORD PTR -8[rbp]
	pop	rbp
	ret
	.size	solve, .-solve
	.section	.rodata
.LC3:
	.string	"%lld "
	.text
	.globl	output
	.type	output, @function
output:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	QWORD PTR -24[rbp], rdi
	mov	QWORD PTR -32[rbp], rsi
	mov	QWORD PTR -8[rbp], 1
	jmp	.L14
.L15:
	mov	rax, QWORD PTR -8[rbp]
	lea	rdx, 0[0+rax*8]
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rdx
	mov	rax, QWORD PTR [rax]
	mov	rsi, rax
	lea	rdi, .LC3[rip]
	mov	eax, 0
	call	printf@PLT
	add	QWORD PTR -8[rbp], 1
.L14:
	mov	rax, QWORD PTR -8[rbp]
	cmp	rax, QWORD PTR -32[rbp]
	jbe	.L15
	nop
	leave
	ret
	.size	output, .-output
	.globl	main
	.type	main, @function
main:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 2097184
	lea	rax, -1048592[rbp]
	mov	esi, 131072
	mov	rdi, rax
	call	input
	mov	rcx, rax
	lea	rdx, -2097184[rbp]
	lea	rax, -1048592[rbp]
	mov	rsi, rcx
	mov	rdi, rax
	call	solve
	mov	rdx, rax
	lea	rax, -2097184[rbp]
	mov	rsi, rdx
	mov	rdi, rax
	call	output
	mov	eax, 0
	leave
	ret
	.size	main, .-main
	.ident	"GCC: (Debian 8.3.0-6) 8.3.0"
	.section	.note.GNU-stack,"",@progbits
