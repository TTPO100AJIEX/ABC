	.file	"solution.c"
	.intel_syntax noprefix
	.text
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
	push	rbp
	push	rbx
	sub	rsp, 24
	mov	r13, rdi
	mov	rbx, rsi
	mov	ebp, edx
	lea	rsi, 8[rsp]
	lea	rdi, .LC0[rip]
	mov	eax, 0
	call	__isoc99_scanf@PLT
	mov	rax, QWORD PTR 8[rsp]
	cmp	rax, rbx
	ja	.L13
	cmp	ebp, 1
	je	.L4
	lea	rbp, 8[r13]
	mov	ebx, 1
	lea	r12, .LC2[rip]
	test	rax, rax
	je	.L6
.L8:
	mov	rsi, rbp
	mov	rdi, r12
	mov	eax, 0
	call	__isoc99_scanf@PLT
	add	rbx, 1
	add	rbp, 8
	cmp	QWORD PTR 8[rsp], rbx
	jnb	.L8
.L6:
	movabs	rax, 9223372036854775807
	mov	QWORD PTR 0[r13], rax
	mov	rax, QWORD PTR 8[rsp]
	movabs	rcx, -9223372036854775808
	mov	QWORD PTR 8[r13+rax*8], rcx
.L1:
	add	rsp, 24
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	ret
.L13:
	lea	rdi, .LC1[rip]
	mov	eax, 0
	call	printf@PLT
	mov	eax, 0
	jmp	.L1
.L4:
	mov	edi, 0
	call	time@PLT
	mov	edi, eax
	call	srand@PLT
	cmp	QWORD PTR 8[rsp], 0
	je	.L6
	mov	ebx, 1
.L7:
	call	rand@PLT
	cdqe
	mov	QWORD PTR 0[r13+rbx*8], rax
	add	rbx, 1
	cmp	QWORD PTR 8[rsp], rbx
	jnb	.L7
	jmp	.L6
	.size	input, .-input
	.globl	solve
	.type	solve, @function
solve:
	test	rsi, rsi
	je	.L19
	mov	rcx, rdi
	lea	rsi, [rdi+rsi*8]
	mov	eax, 0
	jmp	.L18
.L16:
	add	rax, 1
	mov	QWORD PTR [rdx+rax*8], rdi
.L17:
	add	rcx, 8
	cmp	rcx, rsi
	je	.L21
.L18:
	mov	rdi, QWORD PTR 8[rcx]
	cmp	rdi, QWORD PTR [rcx]
	jge	.L16
	cmp	rdi, QWORD PTR 16[rcx]
	jg	.L17
	jmp	.L16
.L21:
	ret
.L19:
	mov	rax, rsi
	ret
	.size	solve, .-solve
	.section	.rodata.str1.1
.LC3:
	.string	"%lld "
	.text
	.globl	output
	.type	output, @function
output:
	test	rsi, rsi
	je	.L27
	push	r12
	push	rbp
	push	rbx
	lea	rbx, 8[rdi]
	lea	r12, [rbx+rsi*8]
	lea	rbp, .LC3[rip]
.L24:
	mov	rsi, QWORD PTR [rbx]
	mov	rdi, rbp
	mov	eax, 0
	call	printf@PLT
	add	rbx, 8
	cmp	rbx, r12
	jne	.L24
	pop	rbx
	pop	rbp
	pop	r12
	ret
.L27:
	ret
	.size	output, .-output
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC4:
	.string	"Incorrect command line arguments provided!"
	.section	.rodata.str1.1
.LC5:
	.string	"r"
.LC6:
	.string	"Failed to open an input file!"
.LC7:
	.string	"w"
	.section	.rodata.str1.8
	.align 8
.LC8:
	.string	"Failed to open an output file!"
	.section	.rodata.str1.1
.LC9:
	.string	"\n\nCPU time used: %lluns\n"
	.text
	.globl	main
	.type	main, @function
main:
	push	r14
	push	r13
	push	r12
	push	rbp
	push	rbx
	cmp	edi, 1
	jle	.L43
	mov	ebp, edi
	mov	rbx, rsi
	mov	rax, QWORD PTR 8[rsi]
	mov	edx, 2
	cmp	BYTE PTR [rax], 49
	je	.L44
.L33:
	lea	eax, 1[rdx]
	cmp	eax, ebp
	ja	.L45
	mov	rcx, QWORD PTR 8[rbx]
	movzx	r12d, BYTE PTR [rcx]
	mov	ecx, edx
	mov	rcx, QWORD PTR [rbx+rcx*8]
	cmp	BYTE PTR [rcx], 49
	jne	.L36
	add	edx, 2
	cmp	ebp, edx
	jb	.L46
	mov	eax, eax
	mov	rdi, QWORD PTR [rbx+rax*8]
	mov	rdx, QWORD PTR stdout[rip]
	lea	rsi, .LC7[rip]
	call	freopen@PLT
	test	rax, rax
	je	.L47
.L36:
	cmp	r12b, 50
	sete	dl
	movzx	edx, dl
	mov	esi, 33554428
	lea	rdi, A[rip]
	call	input
	mov	r13, rax
	call	clock@PLT
	mov	r14, rax
	mov	ebx, 15
	lea	r12, B[rip]
.L38:
	mov	rdx, r12
	mov	rsi, r13
	lea	rdi, A[rip]
	call	solve
	mov	rbp, rax
	sub	ebx, 1
	jne	.L38
	call	clock@PLT
	mov	rbx, rax
	mov	rsi, rbp
	lea	rdi, B[rip]
	call	output
	sub	rbx, r14
	imul	rsi, rbx, 1000
	lea	rdi, .LC9[rip]
	mov	eax, 0
	call	printf@PLT
.L32:
	mov	eax, 0
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	ret
.L43:
	lea	rdi, .LC4[rip]
	call	puts@PLT
	jmp	.L32
.L44:
	cmp	edi, 2
	jle	.L48
	mov	rdi, QWORD PTR 16[rsi]
	mov	rdx, QWORD PTR stdin[rip]
	lea	rsi, .LC5[rip]
	call	freopen@PLT
	mov	edx, 3
	test	rax, rax
	jne	.L33
	lea	rdi, .LC6[rip]
	call	puts@PLT
	jmp	.L32
.L48:
	lea	rdi, .LC4[rip]
	call	puts@PLT
	jmp	.L32
.L45:
	lea	rdi, .LC4[rip]
	call	puts@PLT
	jmp	.L32
.L46:
	lea	rdi, .LC4[rip]
	call	puts@PLT
	jmp	.L32
.L47:
	lea	rdi, .LC8[rip]
	call	puts@PLT
	jmp	.L32
	.size	main, .-main
	.local	B
	.comm	B,268435440,32
	.local	A
	.comm	A,268435440,32
	.ident	"GCC: (Debian 8.3.0-6) 8.3.0"
	.section	.note.GNU-stack,"",@progbits
