	.file	"solution.c"
	.intel_syntax noprefix
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"%llu"
.LC1:
	.string	"The input is too long!"
.LC2:
	.string	"Non-ASCII characters encountered!"
	.text
	.globl	input
	.type	input, @function
input:
	push	r12
	push	rbp
	push	rbx
	mov	rbx, rdi
	sub	rsp, 16
	dec	esi
	jne	.L2
	lea	rdi, .LC0[rip]
	xor	eax, eax
	lea	rsi, 8[rsp]
	call	__isoc99_scanf@PLT
	lea	rdi, .LC1[rip]
	cmp	QWORD PTR 8[rsp], 1073741824
	ja	.L14
	xor	edi, edi
	xor	ebp, ebp
	call	time@PLT
	mov	rdi, rax
	call	srand@PLT
.L5:
	mov	r12, QWORD PTR 8[rsp]
	cmp	r12, rbp
	jbe	.L1
	call	rand@PLT
	and	eax, 127
	mov	BYTE PTR [rbx+rbp], al
	inc	rbp
	jmp	.L5
.L2:
	mov	rcx, QWORD PTR stdin[rip]
	mov	edx, 1073741825
	mov	esi, 1
	call	fread@PLT
	mov	r12, rax
	xor	eax, eax
	cmp	r12, 1073741825
	jne	.L8
	lea	rdi, .LC1[rip]
	call	printf@PLT
	jmp	.L1
.L9:
	inc	rax
.L8:
	cmp	rax, r12
	je	.L1
	cmp	BYTE PTR [rbx+rax], 0
	jns	.L9
	lea	rdi, .LC2[rip]
.L14:
	xor	eax, eax
	mov	r12d, 1073741825
	call	printf@PLT
.L1:
	add	rsp, 16
	mov	rax, r12
	pop	rbx
	pop	rbp
	pop	r12
	ret
	.size	input, .-input
	.globl	solve
	.type	solve, @function
solve:
	xor	r8d, r8d
	xor	r9d, r9d
	xor	edx, edx
.L17:
	cmp	rdx, rsi
	je	.L21
	mov	al, BYTE PTR [rdi+rdx]
	lea	ecx, -48[rax]
	cmp	cl, 9
	ja	.L18
	inc	r9
	jmp	.L19
.L18:
	and	eax, -33
	sub	eax, 65
	cmp	al, 26
	adc	r8, 0
.L19:
	inc	rdx
	jmp	.L17
.L21:
	mov	rax, r9
	mov	rdx, r8
	ret
	.size	solve, .-solve
	.section	.rodata.str1.1
.LC3:
	.string	"Numbers: %llu, Letters: %llu"
	.text
	.globl	output
	.type	output, @function
output:
	mov	rdx, rsi
	xor	eax, eax
	mov	rsi, rdi
	lea	rdi, .LC3[rip]
	jmp	printf@PLT
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
	.string	"\nCPU time used: %lluns"
	.section	.text.startup,"ax",@progbits
	.globl	main
	.type	main, @function
main:
	push	r13
	push	r12
	push	rbp
	push	rbx
	push	rcx
	cmp	edi, 1
	jg	.L24
.L27:
	lea	rdi, .LC4[rip]
	jmp	.L35
.L24:
	mov	rax, QWORD PTR 8[rsi]
	mov	ebp, edi
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
	mov	edx, 3
	lea	rdi, .LC6[rip]
	test	rax, rax
	je	.L35
.L26:
	lea	eax, 1[rdx]
	cmp	eax, ebp
	ja	.L27
	mov	rcx, QWORD PTR 8[rbx]
	mov	r12b, BYTE PTR [rcx]
	mov	ecx, edx
	mov	rcx, QWORD PTR [rbx+rcx*8]
	cmp	BYTE PTR [rcx], 49
	jne	.L28
	cmp	edx, 2
	setne	dl
	movzx	edx, dl
	add	edx, 4
	cmp	ebp, edx
	jb	.L27
	mov	rdi, QWORD PTR [rbx+rax*8]
	mov	rdx, QWORD PTR stdout[rip]
	lea	rsi, .LC7[rip]
	call	freopen@PLT
	test	rax, rax
	jne	.L28
	lea	rdi, .LC8[rip]
.L35:
	call	puts@PLT
	jmp	.L25
.L28:
	xor	esi, esi
	cmp	r12b, 50
	lea	rdi, string.0[rip]
	sete	sil
	call	input
	mov	rbp, rax
	cmp	rax, 1073741824
	ja	.L25
	call	clock@PLT
	mov	rsi, rbp
	lea	rdi, string.0[rip]
	mov	r12, rax
	call	solve
	mov	rbp, rdx
	mov	r13, rax
	call	clock@PLT
	mov	rsi, rbp
	mov	rdi, r13
	mov	rbx, rax
	call	output
	sub	rbx, r12
	mov	ecx, 1000000
	xor	edx, edx
	imul	rax, rbx, 1000000000
	lea	rdi, .LC9[rip]
	div	rcx
	mov	rsi, rax
	xor	eax, eax
	call	printf@PLT
.L25:
	pop	rdx
	xor	eax, eax
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	ret
	.size	main, .-main
	.local	string.0
	.comm	string.0,1073741825,32
	.ident	"GCC: (Debian 10.2.1-6) 10.2.1 20210110"
	.section	.note.GNU-stack,"",@progbits
