	.file	"solution.c"
	.intel_syntax noprefix
	.section	.rodata.str1.1,"aMS",@progbits,1
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
	push	r13
	push	r12
	mov	r12, rsi
	push	rbp
	push	rbx
	mov	rbx, rdi
	lea	rdi, .LC0[rip]
	xor	eax, eax
	mov	ebp, edx
	sub	rsp, 24
	lea	rsi, 8[rsp]
	call	__isoc99_scanf@PLT
	cmp	QWORD PTR 8[rsp], r12
	jbe	.L2
	lea	rdi, .LC1[rip]
	xor	eax, eax
	call	printf@PLT
	xor	eax, eax
	jmp	.L1
.L2:
	dec	ebp
	je	.L4
	lea	r12, 8[rbx]
	mov	ebp, 1
	lea	r13, .LC2[rip]
	jmp	.L5
.L4:
	xor	edi, edi
	mov	ebp, 1
	call	time@PLT
	mov	edi, eax
	call	srand@PLT
.L6:
	cmp	rbp, QWORD PTR 8[rsp]
	ja	.L9
	call	rand@PLT
	cdqe
	mov	QWORD PTR [rbx+rbp*8], rax
	inc	rbp
	jmp	.L6
.L9:
	movabs	rax, 9223372036854775807
	movabs	rcx, -9223372036854775808
	mov	QWORD PTR [rbx], rax
	mov	rax, QWORD PTR 8[rsp]
	mov	QWORD PTR 8[rbx+rax*8], rcx
	jmp	.L1
.L5:
	cmp	rbp, QWORD PTR 8[rsp]
	ja	.L9
	mov	rsi, r12
	mov	rdi, r13
	xor	eax, eax
	call	__isoc99_scanf@PLT
	inc	rbp
	add	r12, 8
	jmp	.L5
.L1:
	add	rsp, 24
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	ret
	.size	input, .-input
	.globl	solve
	.type	solve, @function
solve:
	mov	ecx, 1
	xor	eax, eax
.L13:
	cmp	rcx, rsi
	ja	.L17
	mov	r8, QWORD PTR [rdi+rcx*8]
	cmp	r8, QWORD PTR -8[rdi+rcx*8]
	jge	.L14
	cmp	r8, QWORD PTR 8[rdi+rcx*8]
	jg	.L15
.L14:
	inc	rax
	mov	QWORD PTR [rdx+rax*8], r8
.L15:
	inc	rcx
	jmp	.L13
.L17:
	ret
	.size	solve, .-solve
	.section	.rodata.str1.1
.LC3:
	.string	"%lld "
	.text
	.globl	output
	.type	output, @function
output:
	push	r13
	push	r12
	lea	r13, .LC3[rip]
	push	rbp
	push	rbx
	mov	r12, rdi
	mov	rbp, rsi
	mov	ebx, 1
	sub	rsp, 8
.L19:
	cmp	rbx, rbp
	ja	.L22
	mov	rsi, QWORD PTR [r12+rbx*8]
	mov	rdi, r13
	xor	eax, eax
	inc	rbx
	call	printf@PLT
	jmp	.L19
.L22:
	pop	rax
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	ret
	.size	output, .-output
	.section	.rodata.str1.1
.LC4:
	.string	"Incorrect command line arguments provided!"
.LC5:
	.string	"r"
.LC6:
	.string	"Failed to open an input file!"
.LC7:
	.string	"w"
.LC8:
	.string	"Failed to open an output file!"
.LC9:
	.string	"\n\nCPU time used: %lluns\n"
	.section	.text.startup,"ax",@progbits
	.globl	main
	.type	main, @function
main:
	cmp	edi, 1
	push	r12
	push	rbp
	push	rbx
	jg	.L24
.L27:
	lea	rdi, .LC4[rip]
	jmp	.L37
.L24:
	mov	rax, QWORD PTR 8[rsi]
	mov	r12d, edi
	mov	rbx, rsi
	mov	edx, 2
	cmp	BYTE PTR [rax], 49
	jne	.L26
	cmp	edi, 2
	je	.L27
	mov	rdi, QWORD PTR 16[rsi]
	mov	rdx, QWORD PTR stdin[rip]
	lea	rsi, .LC5[rip]
	call	freopen@PLT
	test	rax, rax
	mov	edx, 3
	lea	rdi, .LC6[rip]
	je	.L37
.L26:
	lea	eax, 1[rdx]
	cmp	eax, r12d
	ja	.L27
	mov	rcx, QWORD PTR 8[rbx]
	mov	bpl, BYTE PTR [rcx]
	mov	ecx, edx
	mov	rcx, QWORD PTR [rbx+rcx*8]
	cmp	BYTE PTR [rcx], 49
	jne	.L28
	add	edx, 2
	cmp	r12d, edx
	jb	.L27
	mov	rdi, QWORD PTR [rbx+rax*8]
	mov	rdx, QWORD PTR stdout[rip]
	lea	rsi, .LC7[rip]
	call	freopen@PLT
	test	rax, rax
	jne	.L28
	lea	rdi, .LC8[rip]
.L37:
	call	puts@PLT
	jmp	.L25
.L28:
	xor	edx, edx
	lea	rdi, A[rip]
	cmp	bpl, 50
	sete	dl
	mov	esi, 33554428
	call	input
	mov	rbx, rax
	call	clock@PLT
	lea	r10, B[rip]
	mov	rbp, rax
	mov	r9d, 15
.L29:
	lea	rdi, A[rip]
	mov	rdx, r10
	mov	rsi, rbx
	call	solve
	dec	r9d
	mov	r12, rax
	jne	.L29
	call	clock@PLT
	lea	rdi, B[rip]
	mov	rbx, rax
	mov	rsi, r12
	sub	rbx, rbp
	call	output
	imul	rsi, rbx, 1000
	lea	rdi, .LC9[rip]
	xor	eax, eax
	call	printf@PLT
.L25:
	pop	rbx
	xor	eax, eax
	pop	rbp
	pop	r12
	ret
	.size	main, .-main
	.local	B
	.comm	B,268435440,32
	.local	A
	.comm	A,268435440,32
	.ident	"GCC: (Debian 6.3.0-18+deb9u1) 6.3.0 20170516"
	.section	.note.GNU-stack,"",@progbits
