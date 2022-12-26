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
	.p2align 4
	.globl	input
	.type	input, @function
input:
	push	r12
	push	rbp
	push	rbx
	mov	rbx, rdi
	sub	rsp, 16
	cmp	esi, 1
	je	.L19
	mov	rcx, QWORD PTR stdin[rip]
	mov	edx, 1073741825
	mov	esi, 1
	call	fread@PLT
	mov	r12, rax
	cmp	rax, 1073741825
	je	.L7
	mov	rdi, rbx
	add	rax, rbx
	test	r12, r12
	jne	.L10
	jmp	.L1
	.p2align 4,,10
	.p2align 3
.L9:
	add	rdi, 1
	cmp	rdi, rax
	je	.L1
.L10:
	cmp	BYTE PTR [rdi], 0
	jns	.L9
	lea	rdi, .LC2[rip]
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
	.p2align 4,,10
	.p2align 3
.L19:
	xor	eax, eax
	lea	rsi, 8[rsp]
	lea	rdi, .LC0[rip]
	call	__isoc99_scanf@PLT
	cmp	QWORD PTR 8[rsp], 1073741824
	ja	.L20
	xor	edi, edi
	call	time@PLT
	mov	rdi, rax
	call	srand@PLT
	mov	r12, QWORD PTR 8[rsp]
	test	r12, r12
	je	.L1
	xor	ebp, ebp
	.p2align 4,,10
	.p2align 3
.L5:
	call	rand@PLT
	mov	r12, QWORD PTR 8[rsp]
	and	eax, 127
	mov	BYTE PTR [rbx+rbp], al
	add	rbp, 1
	cmp	r12, rbp
	ja	.L5
	add	rsp, 16
	mov	rax, r12
	pop	rbx
	pop	rbp
	pop	r12
	ret
	.p2align 4,,10
	.p2align 3
.L20:
	lea	rdi, .LC1[rip]
	xor	eax, eax
	mov	r12d, 1073741825
	call	printf@PLT
	add	rsp, 16
	mov	rax, r12
	pop	rbx
	pop	rbp
	pop	r12
	ret
.L7:
	lea	rdi, .LC1[rip]
	xor	eax, eax
	call	printf@PLT
	jmp	.L1
	.size	input, .-input
	.p2align 4
	.globl	solve
	.type	solve, @function
solve:
	mov	r9, rsi
	test	rsi, rsi
	je	.L26
	lea	rcx, [rdi+rsi]
	xor	r8d, r8d
	xor	r9d, r9d
	jmp	.L25
	.p2align 4,,10
	.p2align 3
.L23:
	and	eax, -33
	sub	eax, 65
	cmp	al, 26
	adc	r8, 0
	add	rdi, 1
	cmp	rdi, rcx
	je	.L22
.L25:
	movzx	eax, BYTE PTR [rdi]
	lea	edx, -48[rax]
	cmp	dl, 9
	ja	.L23
	add	rdi, 1
	add	r9, 1
	cmp	rdi, rcx
	jne	.L25
.L22:
	mov	rax, r9
	mov	rdx, r8
	ret
	.p2align 4,,10
	.p2align 3
.L26:
	xor	r8d, r8d
	mov	rax, r9
	mov	rdx, r8
	ret
	.size	solve, .-solve
	.section	.rodata.str1.1
.LC3:
	.string	"Numbers: %llu, Letters: %llu"
	.text
	.p2align 4
	.globl	output
	.type	output, @function
output:
	mov	rdx, rsi
	xor	eax, eax
	mov	rsi, rdi
	lea	rdi, .LC3[rip]
	jmp	printf@PLT
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
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
	push	r13
	push	r12
	push	rbp
	push	rbx
	sub	rsp, 8
	cmp	edi, 1
	jle	.L33
	mov	rdx, QWORD PTR 8[rsi]
	mov	ebp, edi
	mov	rbx, rsi
	mov	eax, 2
	cmp	BYTE PTR [rdx], 49
	je	.L41
.L32:
	lea	edx, 1[rax]
	cmp	edx, ebp
	ja	.L33
	mov	rcx, QWORD PTR 8[rbx]
	movzx	r12d, BYTE PTR [rcx]
	mov	ecx, eax
	mov	rcx, QWORD PTR [rbx+rcx*8]
	cmp	BYTE PTR [rcx], 49
	jne	.L34
	cmp	eax, 2
	setne	al
	movzx	eax, al
	add	eax, 4
	cmp	ebp, eax
	jb	.L33
	mov	rdi, QWORD PTR [rbx+rdx*8]
	mov	rdx, QWORD PTR stdout[rip]
	lea	rsi, .LC7[rip]
	call	freopen@PLT
	test	rax, rax
	je	.L42
.L34:
	xor	esi, esi
	cmp	r12b, 50
	lea	rdi, string.0[rip]
	sete	sil
	call	input
	mov	rbp, rax
	cmp	rax, 1073741824
	ja	.L31
	call	clock@PLT
	mov	rsi, rbp
	lea	rdi, string.0[rip]
	mov	r12, rax
	call	solve
	mov	rbp, rax
	mov	r13, rdx
	call	clock@PLT
	mov	rdx, r13
	mov	rsi, rbp
	lea	rdi, .LC3[rip]
	mov	rbx, rax
	xor	eax, eax
	call	printf@PLT
	sub	rbx, r12
	mov	ecx, 1000000
	xor	edx, edx
	imul	rax, rbx, 1000000000
	lea	rdi, .LC9[rip]
	div	rcx
	mov	rsi, rax
	xor	eax, eax
	call	printf@PLT
.L31:
	add	rsp, 8
	xor	eax, eax
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	ret
.L33:
	lea	rdi, .LC4[rip]
	call	puts@PLT
	jmp	.L31
.L41:
	cmp	edi, 2
	je	.L33
	mov	rdi, QWORD PTR 16[rsi]
	mov	rdx, QWORD PTR stdin[rip]
	lea	rsi, .LC5[rip]
	call	freopen@PLT
	mov	r8, rax
	mov	eax, 3
	test	r8, r8
	jne	.L32
	lea	rdi, .LC6[rip]
	call	puts@PLT
	jmp	.L31
.L42:
	lea	rdi, .LC8[rip]
	call	puts@PLT
	jmp	.L31
	.size	main, .-main
	.local	string.0
	.comm	string.0,1073741825,32
	.ident	"GCC: (Debian 10.2.1-6) 10.2.1 20210110"
	.section	.note.GNU-stack,"",@progbits
