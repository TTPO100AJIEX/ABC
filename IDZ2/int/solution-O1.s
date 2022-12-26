	.file	"solution.c"
	.intel_syntax noprefix
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"%llu"
.LC1:
	.string	"The input is too long!"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC2:
	.string	"Non-ASCII characters encountered!"
	.text
	.globl	input
	.type	input, @function
input:
	push	r12
	push	rbp
	push	rbx
	sub	rsp, 16
	mov	rbx, rdi
	cmp	esi, 1
	je	.L15
	mov	rcx, QWORD PTR stdin[rip]
	mov	edx, 1073741825
	mov	esi, 1
	call	fread@PLT
	mov	rbp, rax
	cmp	rax, 1073741825
	je	.L7
	mov	rax, rbx
	lea	rdi, [rbx+rbp]
	test	rbp, rbp
	je	.L1
.L10:
	cmp	BYTE PTR [rax], 0
	js	.L16
	add	rax, 1
	cmp	rax, rdi
	jne	.L10
	jmp	.L1
.L15:
	lea	rsi, 8[rsp]
	lea	rdi, .LC0[rip]
	mov	eax, 0
	call	__isoc99_scanf@PLT
	cmp	QWORD PTR 8[rsp], 1073741824
	jbe	.L3
	lea	rdi, .LC1[rip]
	mov	eax, 0
	call	printf@PLT
	mov	ebp, 1073741825
	jmp	.L1
.L3:
	mov	edi, 0
	call	time@PLT
	mov	rdi, rax
	call	srand@PLT
	mov	rbp, QWORD PTR 8[rsp]
	test	rbp, rbp
	je	.L1
	mov	r12d, 0
.L5:
	call	rand@PLT
	and	eax, 127
	mov	BYTE PTR [rbx+r12], al
	add	r12, 1
	mov	rbp, QWORD PTR 8[rsp]
	cmp	rbp, r12
	ja	.L5
	jmp	.L1
.L7:
	lea	rdi, .LC1[rip]
	mov	eax, 0
	call	printf@PLT
	jmp	.L1
.L16:
	lea	rdi, .LC2[rip]
	mov	eax, 0
	call	printf@PLT
	mov	ebp, 1073741825
.L1:
	mov	rax, rbp
	add	rsp, 16
	pop	rbx
	pop	rbp
	pop	r12
	ret
	.size	input, .-input
	.globl	solve
	.type	solve, @function
solve:
	mov	r8, rsi
	test	rsi, rsi
	je	.L18
	mov	rdx, rdi
	add	rdi, rsi
	mov	esi, 0
	mov	r8d, 0
	jmp	.L21
.L19:
	and	eax, -33
	sub	eax, 65
	cmp	al, 26
	adc	rsi, 0
.L20:
	add	rdx, 1
	cmp	rdx, rdi
	je	.L18
.L21:
	movzx	eax, BYTE PTR [rdx]
	lea	ecx, -48[rax]
	cmp	cl, 9
	ja	.L19
	add	r8, 1
	jmp	.L20
.L18:
	mov	rax, r8
	mov	rdx, rsi
	ret
	.size	solve, .-solve
	.section	.rodata.str1.1
.LC3:
	.string	"Numbers: %llu, Letters: %llu"
	.text
	.globl	output
	.type	output, @function
output:
	sub	rsp, 8
	mov	rdx, rsi
	mov	rsi, rdi
	lea	rdi, .LC3[rip]
	mov	eax, 0
	call	printf@PLT
	add	rsp, 8
	ret
	.size	output, .-output
	.section	.rodata.str1.8
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
	.string	"\nCPU time used: %lluns"
	.text
	.globl	main
	.type	main, @function
main:
	push	r13
	push	r12
	push	rbp
	push	rbx
	sub	rsp, 8
	cmp	edi, 1
	jle	.L37
	mov	ebp, edi
	mov	rbx, rsi
	mov	rdx, QWORD PTR 8[rsi]
	mov	eax, 2
	cmp	BYTE PTR [rdx], 49
	je	.L38
.L29:
	lea	edx, 1[rax]
	cmp	edx, ebp
	ja	.L39
	mov	rcx, QWORD PTR 8[rbx]
	movzx	r12d, BYTE PTR [rcx]
	mov	ecx, eax
	mov	rcx, QWORD PTR [rbx+rcx*8]
	cmp	BYTE PTR [rcx], 49
	jne	.L32
	add	eax, 2
	cmp	ebp, eax
	jb	.L40
	mov	edx, edx
	mov	rdi, QWORD PTR [rbx+rdx*8]
	mov	rdx, QWORD PTR stdout[rip]
	lea	rsi, .LC7[rip]
	call	freopen@PLT
	test	rax, rax
	je	.L41
.L32:
	cmp	r12b, 50
	sete	sil
	movzx	esi, sil
	lea	rdi, string.0[rip]
	call	input
	mov	rbx, rax
	cmp	rax, 1073741824
	jbe	.L42
.L28:
	mov	eax, 0
	add	rsp, 8
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	ret
.L37:
	lea	rdi, .LC4[rip]
	call	puts@PLT
	jmp	.L28
.L38:
	cmp	edi, 2
	jle	.L43
	mov	rdi, QWORD PTR 16[rsi]
	mov	rdx, QWORD PTR stdin[rip]
	lea	rsi, .LC5[rip]
	call	freopen@PLT
	mov	rdx, rax
	mov	eax, 3
	test	rdx, rdx
	jne	.L29
	lea	rdi, .LC6[rip]
	call	puts@PLT
	jmp	.L28
.L43:
	lea	rdi, .LC4[rip]
	call	puts@PLT
	jmp	.L28
.L39:
	lea	rdi, .LC4[rip]
	call	puts@PLT
	jmp	.L28
.L40:
	lea	rdi, .LC4[rip]
	call	puts@PLT
	jmp	.L28
.L41:
	lea	rdi, .LC8[rip]
	call	puts@PLT
	jmp	.L28
.L42:
	call	clock@PLT
	mov	rbp, rax
	mov	rsi, rbx
	lea	rdi, string.0[rip]
	call	solve
	mov	r13, rax
	mov	r12, rdx
	call	clock@PLT
	mov	rbx, rax
	mov	rsi, r12
	mov	rdi, r13
	call	output
	sub	rbx, rbp
	imul	rax, rbx, 1000000000
	mov	ecx, 1000000
	mov	edx, 0
	div	rcx
	mov	rsi, rax
	lea	rdi, .LC9[rip]
	mov	eax, 0
	call	printf@PLT
	jmp	.L28
	.size	main, .-main
	.local	string.0
	.comm	string.0,1073741825,32
	.ident	"GCC: (Debian 10.2.1-6) 10.2.1 20210110"
	.section	.note.GNU-stack,"",@progbits
