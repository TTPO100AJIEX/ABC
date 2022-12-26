	.file	"solution.c"
	.intel_syntax noprefix
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC3:
	.string	"%lf"
	.text
	.p2align 4
	.globl	input
	.type	input, @function
input:
	sub	rsp, 24
	mov	QWORD PTR 8[rsp], 0x000000000
	test	dil, dil
	je	.L2
	xor	edi, edi
	call	time@PLT
	mov	rdi, rax
	call	srand@PLT
	call	rand@PLT
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, eax
	addsd	xmm0, xmm0
	divsd	xmm0, QWORD PTR .LC1[rip]
	subsd	xmm0, QWORD PTR .LC2[rip]
	add	rsp, 24
	ret
	.p2align 4,,10
	.p2align 3
.L2:
	lea	rsi, 8[rsp]
	lea	rdi, .LC3[rip]
	xor	eax, eax
	call	__isoc99_scanf@PLT
	movsd	xmm0, QWORD PTR 8[rsp]
	add	rsp, 24
	ret
	.size	input, .-input
	.p2align 4
	.globl	solve
	.type	solve, @function
solve:
	movapd	xmm5, xmm0
	movsd	xmm4, QWORD PTR .LC2[rip]
	movapd	xmm1, xmm0
	mulsd	xmm5, xmm0
	movsd	xmm0, QWORD PTR .LC6[rip]
	subsd	xmm4, xmm5
	comisd	xmm0, xmm4
	ja	.L7
	movapd	xmm0, xmm1
	movq	xmm6, QWORD PTR .LC7[rip]
	movsd	xmm7, QWORD PTR .LC8[rip]
	pxor	xmm2, xmm2
	divsd	xmm0, xmm4
	andpd	xmm0, xmm6
	comisd	xmm0, xmm7
	jb	.L6
	mov	ecx, 6
	mov	eax, 1
	pxor	xmm2, xmm2
	xor	edx, edx
	.p2align 4,,10
	.p2align 3
.L8:
	mov	esi, eax
	pxor	xmm0, xmm0
	pxor	xmm3, xmm3
	add	edx, 1
	imul	esi, eax
	addsd	xmm2, xmm1
	add	eax, 2
	cvtsi2sd	xmm0, rsi
	mov	esi, edx
	imul	esi, ecx
	add	ecx, 4
	mulsd	xmm0, xmm5
	cvtsi2sd	xmm3, rsi
	divsd	xmm0, xmm3
	mulsd	xmm1, xmm0
	movapd	xmm0, xmm1
	divsd	xmm0, xmm4
	andpd	xmm0, xmm6
	comisd	xmm0, xmm7
	jnb	.L8
.L6:
	movapd	xmm0, xmm2
	ret
	.p2align 4,,10
	.p2align 3
.L7:
	pxor	xmm0, xmm0
	movsd	xmm2, QWORD PTR .LC4[rip]
	comisd	xmm0, xmm1
	ja	.L6
	movsd	xmm2, QWORD PTR .LC5[rip]
	movapd	xmm0, xmm2
	ret
	.size	solve, .-solve
	.section	.rodata.str1.1
.LC9:
	.string	"%.7lf\n"
	.text
	.p2align 4
	.globl	output
	.type	output, @function
output:
	lea	rdi, .LC9[rip]
	mov	eax, 1
	jmp	printf@PLT
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
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
	push	r14
	push	r13
	push	r12
	push	rbp
	push	rbx
	sub	rsp, 16
	cmp	edi, 3
	jle	.L22
	mov	rax, QWORD PTR 8[rsi]
	mov	r12d, edi
	mov	rbx, rsi
	movzx	r13d, BYTE PTR [rax]
	mov	rax, QWORD PTR 16[rsi]
	movzx	eax, BYTE PTR [rax]
	cmp	al, 49
	je	.L49
	mov	edx, 3
	cmp	al, 50
	je	.L50
	xor	ebp, ebp
	mov	ecx, 4
.L36:
	mov	eax, edx
	lea	r14, [rbx+rax*8]
	mov	rax, QWORD PTR [r14]
	cmp	BYTE PTR [rax], 49
	je	.L51
.L25:
	movzx	edi, bpl
	movzx	r12d, BYTE PTR [rax]
	call	input
	movq	rbx, xmm0
	andpd	xmm0, XMMWORD PTR .LC7[rip]
	comisd	xmm0, QWORD PTR .LC2[rip]
	ja	.L52
	call	clock@PLT
	mov	rbp, rax
	mov	rax, QWORD PTR .LC2[rip]
	movq	xmm8, rax
	cmp	r13b, 49
	je	.L53
.L29:
	xor	edi, edi
	pxor	xmm1, xmm1
	jmp	.L30
	.p2align 4,,10
	.p2align 3
.L55:
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, rdi
	comisd	xmm8, xmm0
	jbe	.L54
.L31:
	movq	xmm0, rbx
	add	rdi, 1
	call	solve
	movapd	xmm1, xmm0
.L30:
	test	rdi, rdi
	jns	.L55
	mov	rax, rdi
	mov	rdx, rdi
	pxor	xmm0, xmm0
	shr	rax
	and	edx, 1
	or	rax, rdx
	cvtsi2sd	xmm0, rax
	addsd	xmm0, xmm0
	comisd	xmm8, xmm0
	ja	.L31
.L54:
	movsd	QWORD PTR 8[rsp], xmm1
	call	clock@PLT
	xor	edx, edx
	mov	ecx, 1000000
	movsd	xmm1, QWORD PTR 8[rsp]
	sub	rax, rbp
	imul	rax, rax, 1000000000
	div	rcx
	cmp	r12b, 50
	mov	rbp, rax
	jne	.L56
.L34:
	mov	rsi, rbp
	lea	rdi, .LC17[rip]
	xor	eax, eax
	call	printf@PLT
	jmp	.L45
.L22:
	lea	rdi, .LC10[rip]
	call	puts@PLT
.L45:
	add	rsp, 16
	xor	eax, eax
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	ret
.L49:
	cmp	edi, 4
	je	.L22
	mov	rdi, QWORD PTR 24[rsi]
	mov	rdx, QWORD PTR stdin[rip]
	lea	rsi, .LC11[rip]
	call	freopen@PLT
	test	rax, rax
	je	.L57
	mov	rax, QWORD PTR 16[rbx]
	mov	edx, 4
	cmp	BYTE PTR [rax], 50
	sete	bpl
.L24:
	lea	ecx, 1[rdx]
	jmp	.L36
.L52:
	lea	rdi, .LC15[rip]
	call	puts@PLT
	jmp	.L45
.L50:
	mov	ebp, 1
	jmp	.L24
.L53:
	movsd	xmm8, QWORD PTR .LC16[rip]
	jmp	.L29
.L56:
	movapd	xmm0, xmm1
	lea	rdi, .LC9[rip]
	mov	eax, 1
	call	printf@PLT
	jmp	.L34
.L51:
	xor	eax, eax
	cmp	edx, 3
	setne	al
	add	eax, 5
	cmp	eax, r12d
	ja	.L22
	mov	rdi, QWORD PTR [rbx+rcx*8]
	mov	rdx, QWORD PTR stdout[rip]
	lea	rsi, .LC13[rip]
	call	freopen@PLT
	test	rax, rax
	je	.L46
	mov	rax, QWORD PTR [r14]
	jmp	.L25
.L57:
	lea	rdi, .LC12[rip]
	call	puts@PLT
	jmp	.L45
.L46:
	lea	rdi, .LC14[rip]
	call	puts@PLT
	jmp	.L45
	.size	main, .-main
	.section	.rodata.cst8,"aM",@progbits,8
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
