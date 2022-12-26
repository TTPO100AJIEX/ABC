	.file	"solution.c"
	.intel_syntax noprefix
	.text
	.section	.rodata
.LC3:
	.string	"%lf"
	.text
	.globl	input
	.type	input, @function
input:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	eax, edi
	mov	BYTE PTR -20[rbp], al
	pxor	xmm0, xmm0
	movsd	QWORD PTR -8[rbp], xmm0
	cmp	BYTE PTR -20[rbp], 0
	je	.L2
	mov	edi, 0
	call	time@PLT
	mov	edi, eax
	call	srand@PLT
	call	rand@PLT
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, eax
	addsd	xmm0, xmm0
	movsd	xmm1, QWORD PTR .LC1[rip]
	divsd	xmm0, xmm1
	movsd	xmm1, QWORD PTR .LC2[rip]
	subsd	xmm0, xmm1
	movsd	QWORD PTR -8[rbp], xmm0
	jmp	.L3
.L2:
	lea	rax, -8[rbp]
	mov	rsi, rax
	lea	rdi, .LC3[rip]
	mov	eax, 0
	call	__isoc99_scanf@PLT
.L3:
	movsd	xmm0, QWORD PTR -8[rbp]
	movq	rax, xmm0
	movq	xmm0, rax
	leave
	ret
	.size	input, .-input
	.globl	solve
	.type	solve, @function
solve:
	push	rbp
	mov	rbp, rsp
	movsd	QWORD PTR -40[rbp], xmm0
	movsd	xmm0, QWORD PTR -40[rbp]
	movapd	xmm2, xmm0
	mulsd	xmm2, xmm0
	movsd	xmm0, QWORD PTR .LC2[rip]
	movapd	xmm1, xmm0
	subsd	xmm1, xmm2
	movsd	xmm0, QWORD PTR .LC4[rip]
	comisd	xmm0, xmm1
	jbe	.L20
	pxor	xmm0, xmm0
	comisd	xmm0, QWORD PTR -40[rbp]
	jbe	.L21
	movsd	xmm0, QWORD PTR .LC5[rip]
	jmp	.L11
.L21:
	movsd	xmm0, QWORD PTR .LC6[rip]
	jmp	.L11
.L20:
	pxor	xmm0, xmm0
	movsd	QWORD PTR -8[rbp], xmm0
	movsd	xmm0, QWORD PTR -40[rbp]
	movsd	QWORD PTR -16[rbp], xmm0
	mov	DWORD PTR -20[rbp], 0
	jmp	.L12
.L17:
	movsd	xmm0, QWORD PTR -8[rbp]
	addsd	xmm0, QWORD PTR -16[rbp]
	movsd	QWORD PTR -8[rbp], xmm0
	add	DWORD PTR -20[rbp], 1
	movsd	xmm0, QWORD PTR -40[rbp]
	movapd	xmm1, xmm0
	mulsd	xmm1, xmm0
	mov	eax, DWORD PTR -20[rbp]
	add	eax, eax
	lea	edx, -1[rax]
	mov	eax, DWORD PTR -20[rbp]
	add	eax, eax
	sub	eax, 1
	imul	eax, edx
	mov	eax, eax
	test	rax, rax
	js	.L13
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, rax
	jmp	.L14
.L13:
	mov	rdx, rax
	shr	rdx
	and	eax, 1
	or	rdx, rax
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, rdx
	addsd	xmm0, xmm0
.L14:
	mulsd	xmm1, xmm0
	mov	eax, DWORD PTR -20[rbp]
	sal	eax, 2
	add	eax, 2
	imul	eax, DWORD PTR -20[rbp]
	mov	eax, eax
	test	rax, rax
	js	.L15
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, rax
	jmp	.L16
.L15:
	mov	rdx, rax
	shr	rdx
	and	eax, 1
	or	rdx, rax
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, rdx
	addsd	xmm0, xmm0
.L16:
	divsd	xmm1, xmm0
	movsd	xmm0, QWORD PTR -16[rbp]
	mulsd	xmm0, xmm1
	movsd	QWORD PTR -16[rbp], xmm0
.L12:
	movsd	xmm0, QWORD PTR -40[rbp]
	movapd	xmm2, xmm0
	mulsd	xmm2, xmm0
	movsd	xmm0, QWORD PTR .LC2[rip]
	movapd	xmm1, xmm0
	subsd	xmm1, xmm2
	movsd	xmm0, QWORD PTR -16[rbp]
	divsd	xmm0, xmm1
	movq	xmm1, QWORD PTR .LC7[rip]
	andpd	xmm0, xmm1
	comisd	xmm0, QWORD PTR .LC8[rip]
	jnb	.L17
	movsd	xmm0, QWORD PTR -8[rbp]
.L11:
	movq	rax, xmm0
	movq	xmm0, rax
	pop	rbp
	ret
	.size	solve, .-solve
	.section	.rodata
.LC9:
	.string	"%.7lf\n"
	.text
	.globl	output
	.type	output, @function
output:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 16
	movsd	QWORD PTR -8[rbp], xmm0
	mov	rax, QWORD PTR -8[rbp]
	movq	xmm0, rax
	lea	rdi, .LC9[rip]
	mov	eax, 1
	call	printf@PLT
	nop
	leave
	ret
	.size	output, .-output
	.section	.rodata
	.align 8
.LC10:
	.string	"Incorrect command line arguments provided!"
.LC11:
	.string	"r"
.LC12:
	.string	"Failed to open an input file!"
.LC13:
	.string	"w"
	.align 8
.LC14:
	.string	"Failed to open an output file!"
.LC15:
	.string	"Incorrect input provided!"
.LC17:
	.string	"CPU time used: %lluns"
	.text
	.globl	main
	.type	main, @function
main:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 80
	mov	DWORD PTR -68[rbp], edi
	mov	QWORD PTR -80[rbp], rsi
	cmp	DWORD PTR -68[rbp], 3
	jg	.L24
	lea	rdi, .LC10[rip]
	call	puts@PLT
	mov	eax, 0
	jmp	.L25
.L24:
	mov	rax, QWORD PTR -80[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	movzx	eax, BYTE PTR [rax]
	cmp	al, 49
	sete	al
	mov	BYTE PTR -25[rbp], al
	mov	BYTE PTR -1[rbp], 0
	mov	BYTE PTR -2[rbp], 1
	mov	DWORD PTR -8[rbp], 3
	mov	rax, QWORD PTR -80[rbp]
	add	rax, 16
	mov	rax, QWORD PTR [rax]
	movzx	eax, BYTE PTR [rax]
	cmp	al, 49
	jne	.L26
	cmp	DWORD PTR -68[rbp], 4
	jg	.L27
	lea	rdi, .LC10[rip]
	call	puts@PLT
	mov	eax, 0
	jmp	.L25
.L27:
	mov	rdx, QWORD PTR stdin[rip]
	mov	eax, DWORD PTR -8[rbp]
	lea	ecx, 1[rax]
	mov	DWORD PTR -8[rbp], ecx
	mov	eax, eax
	lea	rcx, 0[0+rax*8]
	mov	rax, QWORD PTR -80[rbp]
	add	rax, rcx
	mov	rax, QWORD PTR [rax]
	lea	rsi, .LC11[rip]
	mov	rdi, rax
	call	freopen@PLT
	test	rax, rax
	jne	.L26
	lea	rdi, .LC12[rip]
	call	puts@PLT
	mov	eax, 0
	jmp	.L25
.L26:
	mov	rax, QWORD PTR -80[rbp]
	add	rax, 16
	mov	rax, QWORD PTR [rax]
	movzx	eax, BYTE PTR [rax]
	cmp	al, 50
	jne	.L28
	mov	BYTE PTR -1[rbp], 1
.L28:
	mov	eax, DWORD PTR -8[rbp]
	lea	edx, 1[rax]
	mov	eax, DWORD PTR -68[rbp]
	cmp	edx, eax
	jbe	.L29
	lea	rdi, .LC10[rip]
	call	puts@PLT
	mov	eax, 0
	jmp	.L25
.L29:
	mov	eax, DWORD PTR -8[rbp]
	lea	rdx, 0[0+rax*8]
	mov	rax, QWORD PTR -80[rbp]
	add	rax, rdx
	mov	rax, QWORD PTR [rax]
	movzx	eax, BYTE PTR [rax]
	cmp	al, 49
	jne	.L30
	mov	eax, DWORD PTR -8[rbp]
	lea	edx, 2[rax]
	mov	eax, DWORD PTR -68[rbp]
	cmp	edx, eax
	jbe	.L31
	lea	rdi, .LC10[rip]
	call	puts@PLT
	mov	eax, 0
	jmp	.L25
.L31:
	mov	rdx, QWORD PTR stdout[rip]
	mov	eax, DWORD PTR -8[rbp]
	add	eax, 1
	mov	eax, eax
	lea	rcx, 0[0+rax*8]
	mov	rax, QWORD PTR -80[rbp]
	add	rax, rcx
	mov	rax, QWORD PTR [rax]
	lea	rsi, .LC13[rip]
	mov	rdi, rax
	call	freopen@PLT
	test	rax, rax
	jne	.L30
	lea	rdi, .LC14[rip]
	call	puts@PLT
	mov	eax, 0
	jmp	.L25
.L30:
	mov	eax, DWORD PTR -8[rbp]
	lea	rdx, 0[0+rax*8]
	mov	rax, QWORD PTR -80[rbp]
	add	rax, rdx
	mov	rax, QWORD PTR [rax]
	movzx	eax, BYTE PTR [rax]
	cmp	al, 50
	jne	.L32
	mov	BYTE PTR -2[rbp], 0
.L32:
	movzx	eax, BYTE PTR -1[rbp]
	mov	edi, eax
	call	input
	movq	rax, xmm0
	mov	QWORD PTR -40[rbp], rax
	movsd	xmm0, QWORD PTR -40[rbp]
	movq	xmm1, QWORD PTR .LC7[rip]
	andpd	xmm0, xmm1
	movsd	xmm1, QWORD PTR .LC2[rip]
	comisd	xmm0, xmm1
	jbe	.L43
	lea	rdi, .LC15[rip]
	call	puts@PLT
	mov	eax, 0
	jmp	.L25
.L43:
	pxor	xmm0, xmm0
	movsd	QWORD PTR -16[rbp], xmm0
	call	clock@PLT
	mov	QWORD PTR -48[rbp], rax
	mov	QWORD PTR -24[rbp], 0
	jmp	.L35
.L40:
	mov	rax, QWORD PTR -40[rbp]
	movq	xmm0, rax
	call	solve
	movq	rax, xmm0
	mov	QWORD PTR -16[rbp], rax
	add	QWORD PTR -24[rbp], 1
.L35:
	mov	rax, QWORD PTR -24[rbp]
	test	rax, rax
	js	.L36
	pxor	xmm1, xmm1
	cvtsi2sd	xmm1, rax
	jmp	.L37
.L36:
	mov	rdx, rax
	shr	rdx
	and	eax, 1
	or	rdx, rax
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, rdx
	movapd	xmm1, xmm0
	addsd	xmm1, xmm0
.L37:
	cmp	BYTE PTR -25[rbp], 0
	je	.L38
	movsd	xmm0, QWORD PTR .LC16[rip]
	jmp	.L39
.L38:
	movsd	xmm0, QWORD PTR .LC2[rip]
.L39:
	comisd	xmm0, xmm1
	ja	.L40
	call	clock@PLT
	mov	QWORD PTR -56[rbp], rax
	mov	rax, QWORD PTR -56[rbp]
	sub	rax, QWORD PTR -48[rbp]
	imul	rax, rax, 1000000000
	movabs	rdx, 4835703278458516699
	mul	rdx
	mov	rax, rdx
	shr	rax, 18
	mov	QWORD PTR -64[rbp], rax
	cmp	BYTE PTR -2[rbp], 0
	je	.L41
	mov	rax, QWORD PTR -16[rbp]
	movq	xmm0, rax
	call	output
.L41:
	mov	rax, QWORD PTR -64[rbp]
	mov	rsi, rax
	lea	rdi, .LC17[rip]
	mov	eax, 0
	call	printf@PLT
	mov	eax, 0
.L25:
	leave
	ret
	.size	main, .-main
	.section	.rodata
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
	.long	-1698910392
	.long	1048238066
	.align 8
.LC5:
	.long	1293080650
	.long	-1074191877
	.align 8
.LC6:
	.long	1293080650
	.long	1073291771
	.align 16
.LC7:
	.long	-1
	.long	2147483647
	.long	0
	.long	0
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
