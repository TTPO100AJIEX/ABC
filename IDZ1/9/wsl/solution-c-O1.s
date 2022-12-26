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
.L9:
	mov	rsi, rbp
	mov	rdi, r12
	mov	eax, 0
	call	__isoc99_scanf@PLT
	add	rbx, 1
	add	rbp, 8
	cmp	QWORD PTR 8[rsp], rbx
	jnb	.L9
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
	mov	ecx, 1
	mov	eax, 0
	jmp	.L18
.L16:
	add	rax, 1
	mov	QWORD PTR [rdx+rax*8], r8
.L17:
	add	rcx, 1
	cmp	rsi, rcx
	jb	.L21
.L18:
	mov	r8, QWORD PTR [rdi+rcx*8]
	cmp	r8, QWORD PTR -8[rdi+rcx*8]
	jge	.L16
	cmp	r8, QWORD PTR 8[rdi+rcx*8]
	jg	.L17
	jmp	.L16
.L21:
	rep ret
.L19:
	mov	eax, 0
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
	je	.L30
	push	r13
	push	r12
	push	rbp
	push	rbx
	sub	rsp, 8
	mov	rbp, rsi
	mov	r12, rdi
	mov	ebx, 1
	lea	r13, .LC3[rip]
.L24:
	mov	rsi, QWORD PTR [r12+rbx*8]
	mov	rdi, r13
	mov	eax, 0
	call	printf@PLT
	add	rbx, 1
	cmp	rbp, rbx
	jnb	.L24
	add	rsp, 8
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
.L30:
	rep ret
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
	jle	.L44
	mov	ebp, edi
	mov	rbx, rsi
	mov	rax, QWORD PTR 8[rsi]
	mov	edx, 2
	cmp	BYTE PTR [rax], 49
	je	.L45
.L34:
	lea	eax, 1[rdx]
	cmp	eax, ebp
	ja	.L46
	mov	rcx, QWORD PTR 8[rbx]
	movzx	r12d, BYTE PTR [rcx]
	mov	ecx, edx
	mov	rcx, QWORD PTR [rbx+rcx*8]
	cmp	BYTE PTR [rcx], 49
	je	.L47
.L37:
	cmp	r12b, 50
	sete	dl
	movzx	edx, dl
	mov	esi, 33554428
	lea	rdi, A[rip]
	call	input
	mov	r12, rax
	call	clock@PLT
	mov	r14, rax
	mov	ebx, 15
	lea	rbp, B[rip]
.L39:
	mov	rdx, rbp
	mov	rsi, r12
	lea	rdi, A[rip]
	call	solve
	mov	r13, rax
	sub	ebx, 1
	jne	.L39
	call	clock@PLT
	mov	rbx, rax
	mov	rsi, r13
	lea	rdi, B[rip]
	call	output
	sub	rbx, r14
	imul	rax, rbx, 1000000000
	mov	ecx, 1000000
	cqo
	idiv	rcx
	mov	rsi, rax
	lea	rdi, .LC9[rip]
	mov	eax, 0
	call	printf@PLT
.L33:
	mov	eax, 0
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	ret
.L44:
	lea	rdi, .LC4[rip]
	call	puts@PLT
	jmp	.L33
.L45:
	cmp	edi, 2
	jle	.L48
	mov	rdi, QWORD PTR 16[rsi]
	mov	rdx, QWORD PTR stdin[rip]
	lea	rsi, .LC5[rip]
	call	freopen@PLT
	mov	edx, 3
	test	rax, rax
	jne	.L34
	lea	rdi, .LC6[rip]
	call	puts@PLT
	jmp	.L33
.L48:
	lea	rdi, .LC4[rip]
	call	puts@PLT
	jmp	.L33
.L46:
	lea	rdi, .LC4[rip]
	call	puts@PLT
	jmp	.L33
.L47:
	add	edx, 2
	cmp	ebp, edx
	jb	.L49
	mov	eax, eax
	mov	rdi, QWORD PTR [rbx+rax*8]
	mov	rdx, QWORD PTR stdout[rip]
	lea	rsi, .LC7[rip]
	call	freopen@PLT
	test	rax, rax
	jne	.L37
	lea	rdi, .LC8[rip]
	call	puts@PLT
	jmp	.L33
.L49:
	lea	rdi, .LC4[rip]
	call	puts@PLT
	jmp	.L33
	.size	main, .-main
	.local	B
	.comm	B,268435440,32
	.local	A
	.comm	A,268435440,32
	.ident	"GCC: (Debian 6.3.0-18+deb9u1) 6.3.0 20170516"
	.section	.note.GNU-stack,"",@progbits
