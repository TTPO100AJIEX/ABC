	.file	"solution.c"
	.intel_syntax noprefix
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
	push	rbx
	sub	rsp, 72
	mov	QWORD PTR -56[rbp], rdi
	mov	QWORD PTR -64[rbp], rsi
	mov	DWORD PTR -68[rbp], edx
	lea	rax, -40[rbp]
	mov	rsi, rax
	lea	rdi, .LC0[rip]
	mov	eax, 0
	call	__isoc99_scanf@PLT
	mov	rax, QWORD PTR -40[rbp]
	cmp	rax, QWORD PTR -64[rbp]
	jbe	.L2
	lea	rdi, .LC1[rip]
	mov	eax, 0
	call	printf@PLT
	mov	eax, 0
	jmp	.L10
.L2:
	cmp	DWORD PTR -68[rbp], 1
	jne	.L4
	mov	edi, 0
	call	time@PLT
	mov	edi, eax
	call	srand@PLT
	mov	QWORD PTR -24[rbp], 1
	jmp	.L5
.L6:
	mov	rax, QWORD PTR -24[rbp]
	lea	rdx, 0[0+rax*8]
	mov	rax, QWORD PTR -56[rbp]
	lea	rbx, [rdx+rax]
	call	rand@PLT
	cdqe
	mov	QWORD PTR [rbx], rax
	add	QWORD PTR -24[rbp], 1
.L5:
	mov	rax, QWORD PTR -40[rbp]
	cmp	QWORD PTR -24[rbp], rax
	jbe	.L6
	jmp	.L7
.L4:
	mov	QWORD PTR -32[rbp], 1
	jmp	.L8
.L9:
	mov	rax, QWORD PTR -32[rbp]
	lea	rdx, 0[0+rax*8]
	mov	rax, QWORD PTR -56[rbp]
	add	rax, rdx
	mov	rsi, rax
	lea	rdi, .LC2[rip]
	mov	eax, 0
	call	__isoc99_scanf@PLT
	add	QWORD PTR -32[rbp], 1
.L8:
	mov	rax, QWORD PTR -40[rbp]
	cmp	QWORD PTR -32[rbp], rax
	jbe	.L9
.L7:
	mov	rax, QWORD PTR -56[rbp]
	movabs	rcx, 9223372036854775807
	mov	QWORD PTR [rax], rcx
	mov	rax, QWORD PTR -40[rbp]
	add	rax, 1
	lea	rdx, 0[0+rax*8]
	mov	rax, QWORD PTR -56[rbp]
	add	rax, rdx
	movabs	rcx, -9223372036854775808
	mov	QWORD PTR [rax], rcx
	mov	rax, QWORD PTR -40[rbp]
.L10:
	add	rsp, 72
	pop	rbx
	pop	rbp
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
	jmp	.L12
.L15:
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
	jge	.L13
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
	jg	.L14
.L13:
	add	QWORD PTR -8[rbp], 1
	mov	rax, QWORD PTR -8[rbp]
	lea	rdx, 0[0+rax*8]
	mov	rax, QWORD PTR -40[rbp]
	add	rdx, rax
	mov	rax, QWORD PTR -16[rbp]
	lea	rcx, 0[0+rax*8]
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rcx
	mov	rax, QWORD PTR [rax]
	mov	QWORD PTR [rdx], rax
.L14:
	add	QWORD PTR -16[rbp], 1
.L12:
	mov	rax, QWORD PTR -16[rbp]
	cmp	rax, QWORD PTR -32[rbp]
	jbe	.L15
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
	jmp	.L18
.L19:
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
.L18:
	mov	rax, QWORD PTR -8[rbp]
	cmp	rax, QWORD PTR -32[rbp]
	jbe	.L19
	nop
	leave
	ret
	.size	output, .-output
	.local	A
	.comm	A,268435440,32
	.local	B
	.comm	B,268435440,32
	.section	.rodata
	.align 8
.LC4:
	.string	"Incorrect command line arguments provided!"
.LC5:
	.string	"r"
.LC6:
	.string	"Failed to open an input file!"
.LC7:
	.string	"w"
	.align 8
.LC8:
	.string	"Failed to open an output file!"
.LC9:
	.string	"\n\nCPU time used: %lluns\n"
	.text
	.globl	main
	.type	main, @function
main:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 80
	mov	DWORD PTR -68[rbp], edi
	mov	QWORD PTR -80[rbp], rsi
	cmp	DWORD PTR -68[rbp], 1
	jg	.L21
	lea	rdi, .LC4[rip]
	call	puts@PLT
	mov	eax, 0
	jmp	.L22
.L21:
	mov	DWORD PTR -4[rbp], 2
	mov	DWORD PTR -8[rbp], 0
	mov	rax, QWORD PTR -80[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	movzx	eax, BYTE PTR [rax]
	cmp	al, 49
	jne	.L23
	cmp	DWORD PTR -68[rbp], 2
	jg	.L24
	lea	rdi, .LC4[rip]
	call	puts@PLT
	mov	eax, 0
	jmp	.L22
.L24:
	mov	rdx, QWORD PTR stdin[rip]
	mov	eax, DWORD PTR -4[rbp]
	lea	ecx, 1[rax]
	mov	DWORD PTR -4[rbp], ecx
	mov	eax, eax
	lea	rcx, 0[0+rax*8]
	mov	rax, QWORD PTR -80[rbp]
	add	rax, rcx
	mov	rax, QWORD PTR [rax]
	lea	rsi, .LC5[rip]
	mov	rdi, rax
	call	freopen@PLT
	test	rax, rax
	jne	.L23
	lea	rdi, .LC6[rip]
	call	puts@PLT
	mov	eax, 0
	jmp	.L22
.L23:
	mov	rax, QWORD PTR -80[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	movzx	eax, BYTE PTR [rax]
	cmp	al, 50
	jne	.L25
	mov	DWORD PTR -8[rbp], 1
.L25:
	mov	eax, DWORD PTR -4[rbp]
	lea	edx, 1[rax]
	mov	eax, DWORD PTR -68[rbp]
	cmp	edx, eax
	jbe	.L26
	lea	rdi, .LC4[rip]
	call	puts@PLT
	mov	eax, 0
	jmp	.L22
.L26:
	mov	eax, DWORD PTR -4[rbp]
	lea	rdx, 0[0+rax*8]
	mov	rax, QWORD PTR -80[rbp]
	add	rax, rdx
	mov	rax, QWORD PTR [rax]
	movzx	eax, BYTE PTR [rax]
	cmp	al, 49
	jne	.L27
	mov	eax, DWORD PTR -4[rbp]
	lea	edx, 2[rax]
	mov	eax, DWORD PTR -68[rbp]
	cmp	edx, eax
	jbe	.L28
	lea	rdi, .LC4[rip]
	call	puts@PLT
	mov	eax, 0
	jmp	.L22
.L28:
	mov	rdx, QWORD PTR stdout[rip]
	mov	eax, DWORD PTR -4[rbp]
	add	eax, 1
	mov	eax, eax
	lea	rcx, 0[0+rax*8]
	mov	rax, QWORD PTR -80[rbp]
	add	rax, rcx
	mov	rax, QWORD PTR [rax]
	lea	rsi, .LC7[rip]
	mov	rdi, rax
	call	freopen@PLT
	test	rax, rax
	jne	.L27
	lea	rdi, .LC8[rip]
	call	puts@PLT
	mov	eax, 0
	jmp	.L22
.L27:
	mov	eax, DWORD PTR -8[rbp]
	mov	edx, eax
	mov	esi, 33554428
	lea	rdi, A[rip]
	call	input
	mov	QWORD PTR -32[rbp], rax
	call	clock@PLT
	mov	QWORD PTR -40[rbp], rax
	mov	DWORD PTR -20[rbp], 0
	jmp	.L29
.L30:
	mov	rax, QWORD PTR -32[rbp]
	lea	rdx, B[rip]
	mov	rsi, rax
	lea	rdi, A[rip]
	call	solve
	mov	QWORD PTR -16[rbp], rax
	add	DWORD PTR -20[rbp], 1
.L29:
	cmp	DWORD PTR -20[rbp], 14
	jle	.L30
	call	clock@PLT
	mov	QWORD PTR -48[rbp], rax
	mov	rax, QWORD PTR -48[rbp]
	sub	rax, QWORD PTR -40[rbp]
	imul	rcx, rax, 1000000000
	movabs	rdx, 4835703278458516699
	mov	rax, rcx
	imul	rdx
	sar	rdx, 18
	mov	rax, rcx
	sar	rax, 63
	sub	rdx, rax
	mov	rax, rdx
	mov	QWORD PTR -56[rbp], rax
	mov	rax, QWORD PTR -16[rbp]
	mov	rsi, rax
	lea	rdi, B[rip]
	call	output
	mov	rax, QWORD PTR -56[rbp]
	mov	rsi, rax
	lea	rdi, .LC9[rip]
	mov	eax, 0
	call	printf@PLT
	mov	eax, 0
.L22:
	leave
	ret
	.size	main, .-main
	.ident	"GCC: (Debian 6.3.0-18+deb9u1) 6.3.0 20170516"
	.section	.note.GNU-stack,"",@progbits
