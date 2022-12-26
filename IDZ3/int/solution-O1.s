	.file	"solution.c"
	.intel_syntax noprefix
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC3:
	.string	"%lf"
	.text
	.globl	input
	.type	input, @function
input:
	sub	rsp, 24
	mov	QWORD PTR 8[rsp], 0x000000000
	test	dil, dil
	je	.L2
	mov	edi, 0
	call	time@PLT
	mov	rdi, rax
	call	srand@PLT
	call	rand@PLT
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, eax
	addsd	xmm0, xmm0
	divsd	xmm0, QWORD PTR .LC1[rip]
	subsd	xmm0, QWORD PTR .LC2[rip]
	movsd	QWORD PTR 8[rsp], xmm0
.L3:
	movsd	xmm0, QWORD PTR 8[rsp]
	add	rsp, 24
	ret
.L2:
	lea	rsi, 8[rsp]
	lea	rdi, .LC3[rip]
	mov	eax, 0
	call	__isoc99_scanf@PLT
	jmp	.L3
	.size	input, .-input
	.globl	solve
	.type	solve, @function
solve:
	movapd	xmm1, xmm0
	movapd	xmm5, xmm0
	mulsd	xmm5, xmm0
	movsd	xmm4, QWORD PTR .LC2[rip]
	subsd	xmm4, xmm5
	movsd	xmm0, QWORD PTR .LC6[rip]
	comisd	xmm0, xmm4
	ja	.L6
	movapd	xmm0, xmm1
	divsd	xmm0, xmm4
	andpd	xmm0, XMMWORD PTR .LC7[rip]
	pxor	xmm2, xmm2
	comisd	xmm0, QWORD PTR .LC8[rip]
	jb	.L5
	mov	ecx, 6
	mov	eax, 1
	mov	edx, 0
	pxor	xmm2, xmm2
	movq	xmm7, QWORD PTR .LC7[rip]
	movsd	xmm6, QWORD PTR .LC8[rip]
.L7:
	addsd	xmm2, xmm1
	add	edx, 1
	mov	esi, eax
	imul	esi, eax
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, rsi
	mulsd	xmm0, xmm5
	mov	esi, ecx
	imul	esi, edx
	pxor	xmm3, xmm3
	cvtsi2sd	xmm3, rsi
	divsd	xmm0, xmm3
	mulsd	xmm1, xmm0
	add	eax, 2
	add	ecx, 4
	movapd	xmm0, xmm1
	divsd	xmm0, xmm4
	andpd	xmm0, xmm7
	comisd	xmm0, xmm6
	jnb	.L7
.L5:
	movapd	xmm0, xmm2
	ret
.L6:
	movsd	xmm2, QWORD PTR .LC4[rip]
	pxor	xmm0, xmm0
	comisd	xmm0, xmm1
	ja	.L5
	movsd	xmm2, QWORD PTR .LC5[rip]
	jmp	.L5
	.size	solve, .-solve
	.section	.rodata.str1.1
.LC9:
	.string	"%.7lf\n"
	.text
	.globl	output
	.type	output, @function
output:
	sub	rsp, 8
	lea	rdi, .LC9[rip]
	mov	eax, 1
	call	printf@PLT
	add	rsp, 8
	ret
	.size	output, .-output
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC10:
	.string	"Incorrect command line arguments provided!"
	.section	.rodata.str1.1
.LC11:
	.string	"r"
.LC12:
	.string	"Failed to open an input file!"
.LC13:
	.string	"w"
	.section	.rodata.str1.8
	.align 8
.LC14:
	.string	"Failed to open an output file!"
	.section	.rodata.str1.1
.LC15:
	.string	"Incorrect input provided!"
.LC17:
	.string	"CPU time used: %lluns"
	.text
	.globl	main
	.type	main, @function
main:
	push	r15
	push	r14
	push	r13
	push	r12
	push	rbp
	push	rbx
	sub	rsp, 8
	cmp	edi, 3
	jle	.L41
	mov	ebp, edi
	mov	rbx, rsi
	mov	rax, QWORD PTR 8[rsi]
	movzx	r15d, BYTE PTR [rax]
	mov	rdx, QWORD PTR 16[rsi]
	mov	eax, 3
	cmp	BYTE PTR [rdx], 49
	je	.L42
.L21:
	mov	rdx, QWORD PTR 16[rbx]
	cmp	BYTE PTR [rdx], 50
	sete	r12b
	mov	edx, eax
	lea	r13, [rbx+rdx*8]
	mov	rdx, QWORD PTR 0[r13]
	cmp	BYTE PTR [rdx], 49
	je	.L43
.L24:
	mov	rax, QWORD PTR 0[r13]
	movzx	r14d, BYTE PTR [rax]
	movzx	edi, r12b
	call	input
	movq	rbp, xmm0
	andpd	xmm0, XMMWORD PTR .LC7[rip]
	comisd	xmm0, QWORD PTR .LC2[rip]
	ja	.L44
	call	clock@PLT
	mov	r13, rax
	movsd	xmm0, QWORD PTR .LC2[rip]
	cmp	r15b, 49
	je	.L45
.L28:
	movq	r12, xmm0
	mov	ebx, 0
	mov	r15, QWORD PTR .LC0[rip]
	jmp	.L29
.L41:
	lea	rdi, .LC10[rip]
	call	puts@PLT
	jmp	.L38
.L42:
	cmp	edi, 4
	jle	.L46
	mov	rdi, QWORD PTR 24[rsi]
	mov	rdx, QWORD PTR stdin[rip]
	lea	rsi, .LC11[rip]
	call	freopen@PLT
	mov	rdx, rax
	mov	eax, 4
	test	rdx, rdx
	jne	.L21
	lea	rdi, .LC12[rip]
	call	puts@PLT
	jmp	.L38
.L46:
	lea	rdi, .LC10[rip]
	call	puts@PLT
	jmp	.L38
.L43:
	lea	edx, 2[rax]
	cmp	edx, ebp
	ja	.L47
	add	eax, 1
	mov	eax, eax
	mov	rdi, QWORD PTR [rbx+rax*8]
	mov	rdx, QWORD PTR stdout[rip]
	lea	rsi, .LC13[rip]
	call	freopen@PLT
	test	rax, rax
	jne	.L24
	lea	rdi, .LC14[rip]
	call	puts@PLT
	jmp	.L38
.L47:
	lea	rdi, .LC10[rip]
	call	puts@PLT
	jmp	.L38
.L44:
	lea	rdi, .LC15[rip]
	call	puts@PLT
	jmp	.L38
.L45:
	movsd	xmm0, QWORD PTR .LC16[rip]
	jmp	.L28
.L31:
	mov	rax, rbx
	shr	rax
	mov	rdx, rbx
	and	edx, 1
	or	rax, rdx
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, rax
	addsd	xmm0, xmm0
.L32:
	movq	xmm1, r12
	comisd	xmm1, xmm0
	jbe	.L48
	movq	xmm0, rbp
	call	solve
	movq	r15, xmm0
	add	rbx, 1
.L29:
	test	rbx, rbx
	js	.L31
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, rbx
	jmp	.L32
.L48:
	call	clock@PLT
	sub	rax, r13
	imul	rax, rax, 1000000000
	mov	ecx, 1000000
	mov	edx, 0
	div	rcx
	mov	rbx, rax
	cmp	r14b, 50
	jne	.L49
.L33:
	mov	rsi, rbx
	lea	rdi, .LC17[rip]
	mov	eax, 0
	call	printf@PLT
.L38:
	mov	eax, 0
	add	rsp, 8
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	ret
.L49:
	movq	xmm0, r15
	call	output
	jmp	.L33
	.size	main, .-main
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC0:
	.long	0
	.long	0
	.align 8
.LC1:
	.long	-4194304
	.long	1105199103
	.align 8
.LC2:
	.long	0
	.long	1072693248
	.align 8
.LC4:
	.long	1293080650
	.long	-1074191877
	.align 8
.LC5:
	.long	1293080650
	.long	1073291771
	.align 8
.LC6:
	.long	-1698910392
	.long	1048238066
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC7:
	.long	-1
	.long	2147483647
	.long	0
	.long	0
	.section	.rodata.cst8
	.align 8
.LC8:
	.long	-755914244
	.long	1061184077
	.align 8
.LC16:
	.long	0
	.long	1100470148
	.ident	"GCC: (Debian 10.2.1-6) 10.2.1 20210110"
	.section	.note.GNU-stack,"",@progbits
