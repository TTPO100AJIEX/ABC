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
	.p2align 4,,15
	.globl	input
	.type	input, @function
input:
	push	r13
	push	r12
	mov	r13, rdi
	push	rbp
	push	rbx
	lea	rdi, .LC0[rip]
	mov	rbx, rsi
	xor	eax, eax
	mov	ebp, edx
	sub	rsp, 24
	lea	rsi, 8[rsp]
	call	__isoc99_scanf@PLT
	mov	rax, QWORD PTR 8[rsp]
	cmp	rax, rbx
	ja	.L17
	cmp	ebp, 1
	je	.L4
	test	rax, rax
	lea	rbp, 8[r13]
	mov	ebx, 1
	lea	r12, .LC2[rip]
	je	.L6
	.p2align 4,,10
	.p2align 3
.L11:
	mov	rsi, rbp
	xor	eax, eax
	mov	rdi, r12
	call	__isoc99_scanf@PLT
	mov	rax, QWORD PTR 8[rsp]
	add	rbx, 1
	add	rbp, 8
	cmp	rax, rbx
	jnb	.L11
.L6:
	movabs	rcx, 9223372036854775807
	movabs	rdx, -9223372036854775808
	mov	QWORD PTR 0[r13], rcx
	mov	QWORD PTR 8[r13+rax*8], rdx
	add	rsp, 24
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	ret
	.p2align 4,,10
	.p2align 3
.L17:
	lea	rdi, .LC1[rip]
	xor	eax, eax
	call	printf@PLT
	add	rsp, 24
	xor	eax, eax
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	ret
	.p2align 4,,10
	.p2align 3
.L4:
	xor	edi, edi
	call	time@PLT
	mov	edi, eax
	call	srand@PLT
	mov	rax, QWORD PTR 8[rsp]
	test	rax, rax
	je	.L6
	mov	ebx, 1
	.p2align 4,,10
	.p2align 3
.L7:
	call	rand@PLT
	cdqe
	mov	QWORD PTR 0[r13+rbx*8], rax
	mov	rax, QWORD PTR 8[rsp]
	add	rbx, 1
	cmp	rax, rbx
	jnb	.L7
	jmp	.L6
	.size	input, .-input
	.p2align 4,,15
	.globl	solve
	.type	solve, @function
solve:
	test	rsi, rsi
	je	.L24
	mov	ecx, 2
	xor	eax, eax
	.p2align 4,,10
	.p2align 3
.L23:
	mov	r8, QWORD PTR -8[rdi+rcx*8]
	cmp	r8, QWORD PTR -16[rdi+rcx*8]
	mov	r9, rcx
	jge	.L21
	cmp	r8, QWORD PTR [rdi+rcx*8]
	jg	.L22
.L21:
	add	rax, 1
	mov	QWORD PTR [rdx+rax*8], r8
.L22:
	add	rcx, 1
	cmp	rsi, r9
	jnb	.L23
	rep ret
.L24:
	xor	eax, eax
	ret
	.size	solve, .-solve
	.section	.rodata.str1.1
.LC3:
	.string	"%lld "
	.text
	.p2align 4,,15
	.globl	output
	.type	output, @function
output:
	test	rsi, rsi
	je	.L37
	push	r13
	push	r12
	lea	r12, .LC3[rip]
	push	rbp
	push	rbx
	mov	r13, rdi
	mov	rbp, rsi
	mov	ebx, 1
	sub	rsp, 8
	.p2align 4,,10
	.p2align 3
.L31:
	mov	rsi, QWORD PTR 0[r13+rbx*8]
	xor	eax, eax
	mov	rdi, r12
	add	rbx, 1
	call	printf@PLT
	cmp	rbp, rbx
	jnb	.L31
	add	rsp, 8
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
.L37:
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
	.section	.text.startup,"ax",@progbits
	.p2align 4,,15
	.globl	main
	.type	main, @function
main:
	cmp	edi, 1
	push	r14
	push	r13
	push	r12
	push	rbp
	push	rbx
	jle	.L42
	mov	rax, QWORD PTR 8[rsi]
	mov	ebp, edi
	mov	rbx, rsi
	mov	edx, 2
	cmp	BYTE PTR [rax], 49
	je	.L57
.L41:
	lea	eax, 1[rdx]
	cmp	eax, ebp
	ja	.L42
	mov	rcx, QWORD PTR 8[rbx]
	movzx	r12d, BYTE PTR [rcx]
	mov	ecx, edx
	mov	rcx, QWORD PTR [rbx+rcx*8]
	cmp	BYTE PTR [rcx], 49
	je	.L58
.L43:
	xor	edx, edx
	lea	rdi, A[rip]
	cmp	r12b, 50
	sete	dl
	mov	esi, 33554428
	call	input
	mov	rbx, rax
	call	clock@PLT
	lea	r11, B[rip]
	mov	r12, rax
	mov	r10d, 15
	.p2align 4,,10
	.p2align 3
.L44:
	lea	rdi, A[rip]
	mov	rdx, r11
	mov	rsi, rbx
	call	solve
	sub	r10d, 1
	mov	rbp, rax
	jne	.L44
	call	clock@PLT
	sub	rax, r12
	mov	ebx, 1
	lea	r13, B[rip]
	imul	r14, rax, 1000
	test	rbp, rbp
	lea	r12, .LC3[rip]
	je	.L47
	.p2align 4,,10
	.p2align 3
.L52:
	mov	rsi, QWORD PTR 0[r13+rbx*8]
	xor	eax, eax
	mov	rdi, r12
	add	rbx, 1
	call	printf@PLT
	cmp	rbp, rbx
	jnb	.L52
.L47:
	lea	rdi, .LC9[rip]
	mov	rsi, r14
	xor	eax, eax
	call	printf@PLT
.L40:
	pop	rbx
	xor	eax, eax
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	ret
.L58:
	add	edx, 2
	cmp	ebp, edx
	jb	.L42
	mov	rdi, QWORD PTR [rbx+rax*8]
	mov	rdx, QWORD PTR stdout[rip]
	lea	rsi, .LC7[rip]
	call	freopen@PLT
	test	rax, rax
	jne	.L43
	lea	rdi, .LC8[rip]
	call	puts@PLT
	jmp	.L40
.L57:
	cmp	edi, 2
	jne	.L59
.L42:
	lea	rdi, .LC4[rip]
	call	puts@PLT
	jmp	.L40
.L59:
	mov	rdi, QWORD PTR 16[rsi]
	mov	rdx, QWORD PTR stdin[rip]
	lea	rsi, .LC5[rip]
	call	freopen@PLT
	test	rax, rax
	mov	edx, 3
	jne	.L41
	lea	rdi, .LC6[rip]
	call	puts@PLT
	jmp	.L40
	.size	main, .-main
	.local	B
	.comm	B,268435440,32
	.local	A
	.comm	A,268435440,32
	.ident	"GCC: (Debian 6.3.0-18+deb9u1) 6.3.0 20170516"
	.section	.note.GNU-stack,"",@progbits
