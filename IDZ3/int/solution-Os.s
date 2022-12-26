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
	xor	edi, edi
	call	time@PLT
	mov	rdi, rax
	call	srand@PLT
	call	rand@PLT
	cvtsi2sd	xmm0, eax
	addsd	xmm0, xmm0
	divsd	xmm0, QWORD PTR .LC1[rip]
	subsd	xmm0, QWORD PTR .LC2[rip]
	movsd	QWORD PTR 8[rsp], xmm0
	jmp	.L3
.L2:
	lea	rsi, 8[rsp]
	lea	rdi, .LC3[rip]
	xor	eax, eax
	call	__isoc99_scanf@PLT
.L3:
	movsd	xmm0, QWORD PTR 8[rsp]
	add	rsp, 24
	ret
	.size	input, .-input
	.globl	solve
	.type	solve, @function
solve:
	movaps	xmm4, xmm0
	movsd	xmm3, QWORD PTR .LC2[rip]
	movsd	xmm1, QWORD PTR .LC6[rip]
	mulsd	xmm4, xmm0
	subsd	xmm3, xmm4
	comisd	xmm1, xmm3
	jbe	.L18
	xorps	xmm2, xmm2
	movsd	xmm1, QWORD PTR .LC5[rip]
	comisd	xmm2, xmm0
	ja	.L6
	movsd	xmm1, QWORD PTR .LC4[rip]
	jmp	.L6
.L18:
	movq	xmm6, QWORD PTR .LC7[rip]
	movsd	xmm5, QWORD PTR .LC8[rip]
	xor	eax, eax
	xorps	xmm1, xmm1
.L7:
	movaps	xmm2, xmm0
	divsd	xmm2, xmm3
	andps	xmm2, xmm6
	comisd	xmm2, xmm5
	jb	.L6
	inc	eax
	addsd	xmm1, xmm0
	lea	edx, -1[rax+rax]
	imul	edx, edx
	cvtsi2sd	xmm2, rdx
	lea	edx, 2[0+rax*4]
	imul	edx, eax
	mulsd	xmm2, xmm4
	cvtsi2sd	xmm7, rdx
	divsd	xmm2, xmm7
	mulsd	xmm0, xmm2
	jmp	.L7
.L6:
	movaps	xmm0, xmm1
	ret
	.size	solve, .-solve
	.section	.rodata.str1.1
.LC9:
	.string	"%.7lf\n"
	.text
	.globl	output
	.type	output, @function
output:
	lea	rdi, .LC9[rip]
	mov	al, 1
	jmp	printf@PLT
	.size	output, .-output
	.section	.rodata.str1.1
.LC10:
	.string	"Incorrect command line arguments provided!"
.LC11:
	.string	"r"
.LC12:
	.string	"Failed to open an input file!"
.LC13:
	.string	"w"
.LC14:
	.string	"Failed to open an output file!"
.LC15:
	.string	"Incorrect input provided!"
.LC17:
	.string	"CPU time used: %lluns"
	.section	.text.startup,"ax",@progbits
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
	jg	.L21
.L24:
	lea	rdi, .LC10[rip]
	jmp	.L46
.L21:
	mov	rax, QWORD PTR 8[rsi]
	mov	ebx, edi
	mov	rbp, rsi
	mov	edx, 3
	mov	r12b, BYTE PTR [rax]
	mov	rax, QWORD PTR 16[rsi]
	cmp	BYTE PTR [rax], 49
	jne	.L23
	cmp	edi, 4
	je	.L24
	mov	rdi, QWORD PTR 24[rsi]
	mov	rdx, QWORD PTR stdin[rip]
	lea	rsi, .LC11[rip]
	call	freopen@PLT
	mov	edx, 4
	lea	rdi, .LC12[rip]
	test	rax, rax
	je	.L46
.L23:
	lea	eax, 1[rdx]
	cmp	eax, ebx
	ja	.L24
	mov	rcx, QWORD PTR 16[rbp]
	mov	r13b, BYTE PTR [rcx]
	mov	ecx, edx
	lea	r14, 0[rbp+rcx*8]
	mov	rcx, QWORD PTR [r14]
	cmp	BYTE PTR [rcx], 49
	jne	.L25
	cmp	edx, 3
	setne	dl
	movzx	edx, dl
	add	edx, 5
	cmp	ebx, edx
	jb	.L24
	mov	rdi, QWORD PTR 0[rbp+rax*8]
	mov	rdx, QWORD PTR stdout[rip]
	lea	rsi, .LC13[rip]
	call	freopen@PLT
	test	rax, rax
	jne	.L25
	lea	rdi, .LC14[rip]
.L46:
	call	puts@PLT
	jmp	.L22
.L25:
	mov	rax, QWORD PTR [r14]
	xor	edi, edi
	cmp	r13b, 50
	sete	dil
	mov	bl, BYTE PTR [rax]
	call	input
	lea	rdi, .LC15[rip]
	movq	r14, xmm0
	andps	xmm0, XMMWORD PTR .LC7[rip]
	comisd	xmm0, QWORD PTR .LC2[rip]
	ja	.L46
	call	clock@PLT
	mov	rbp, rax
	mov	rax, QWORD PTR .LC2[rip]
	movq	xmm8, rax
	cmp	r12b, 49
	jne	.L29
	movsd	xmm8, QWORD PTR .LC16[rip]
.L29:
	xor	ecx, ecx
	xorps	xmm1, xmm1
.L30:
	test	rcx, rcx
	js	.L32
	cvtsi2sd	xmm0, rcx
	jmp	.L33
.L32:
	mov	rax, rcx
	mov	rdx, rcx
	shr	rax
	and	edx, 1
	or	rax, rdx
	cvtsi2sd	xmm0, rax
	addsd	xmm0, xmm0
.L33:
	comisd	xmm8, xmm0
	jbe	.L47
	movq	xmm0, r14
	inc	rcx
	call	solve
	movaps	xmm1, xmm0
	jmp	.L30
.L47:
	movsd	QWORD PTR 8[rsp], xmm1
	call	clock@PLT
	xor	edx, edx
	mov	ecx, 1000000
	movsd	xmm1, QWORD PTR 8[rsp]
	sub	rax, rbp
	imul	rax, rax, 1000000000
	div	rcx
	cmp	bl, 50
	mov	rbp, rax
	je	.L34
	movaps	xmm0, xmm1
	call	output
.L34:
	mov	rsi, rbp
	lea	rdi, .LC17[rip]
	xor	eax, eax
	call	printf@PLT
.L22:
	add	rsp, 16
	xor	eax, eax
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	ret
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
	.long	1073291771
	.align 8
.LC5:
	.long	1293080650
	.long	-1074191877
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
