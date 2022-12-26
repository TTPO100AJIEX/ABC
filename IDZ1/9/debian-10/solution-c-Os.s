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
	xor	eax, eax
	mov	r13d, edx
	push	r12
	push	rbp
	mov	rbp, rsi
	push	rbx
	mov	rbx, rdi
	lea	rdi, .LC0[rip]
	sub	rsp, 24
	lea	rsi, 8[rsp]
	call	__isoc99_scanf@PLT
	cmp	QWORD PTR 8[rsp], rbp
	jbe	.L2
	lea	rdi, .LC1[rip]
	xor	eax, eax
	call	printf@PLT
	xor	eax, eax
	jmp	.L1
.L2:
	dec	r13d
	mov	ebp, 1
	lea	r12, .LC2[rip]
	jne	.L4
	xor	edi, edi
	call	time@PLT
	mov	edi, eax
	call	srand@PLT
.L5:
	cmp	QWORD PTR 8[rsp], rbp
	jb	.L8
	call	rand@PLT
	cdqe
	mov	QWORD PTR [rbx+rbp*8], rax
	inc	rbp
	jmp	.L5
.L8:
	movabs	rax, 9223372036854775807
	mov	ecx, 1
	mov	QWORD PTR [rbx], rax
	mov	rax, QWORD PTR 8[rsp]
	sal	rcx, 63
	mov	QWORD PTR 8[rbx+rax*8], rcx
	jmp	.L1
.L4:
	cmp	QWORD PTR 8[rsp], rbp
	jb	.L8
	lea	rsi, [rbx+rbp*8]
	mov	rdi, r12
	xor	eax, eax
	inc	rbp
	call	__isoc99_scanf@PLT
	jmp	.L4
.L1:
	add	rsp, 24
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	ret
	.size	input, .-input
	.globl	solve
	.type	solve, @function
solve:
	mov	ecx, 1
	xor	eax, eax
.L14:
	cmp	rcx, rsi
	ja	.L18
	mov	r8, QWORD PTR [rdi+rcx*8]
	mov	r9, QWORD PTR -8[rdi+rcx*8]
	inc	rcx
	cmp	r8, r9
	jge	.L15
	cmp	r8, QWORD PTR [rdi+rcx*8]
	jg	.L14
.L15:
	inc	rax
	mov	QWORD PTR [rdx+rax*8], r8
	jmp	.L14
.L18:
	ret
	.size	solve, .-solve
	.section	.rodata.str1.1
.LC3:
	.string	"%lld "
	.text
	.globl	output
	.type	output, @function
output:
	push	r12
	lea	r12, .LC3[rip]
	push	rbp
	lea	rbp, [rdi+rsi*8]
	push	rbx
	mov	rbx, rdi
.L20:
	cmp	rbx, rbp
	je	.L23
	mov	rsi, QWORD PTR 8[rbx]
	mov	rdi, r12
	xor	eax, eax
	add	rbx, 8
	call	printf@PLT
	jmp	.L20
.L23:
	pop	rbx
	pop	rbp
	pop	r12
	ret
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
	.string	"\n\nCPU time used: %lluns\n"
	.section	.text.startup,"ax",@progbits
	.globl	main
	.type	main, @function
main:
	push	r12
	push	rbp
	push	rbx
	cmp	edi, 1
	jg	.L25
.L28:
	lea	rdi, .LC4[rip]
	jmp	.L38
.L25:
	mov	rax, QWORD PTR 8[rsi]
	mov	ebp, edi
	mov	rbx, rsi
	mov	edx, 2
	cmp	BYTE PTR [rax], 49
	jne	.L27
	cmp	edi, 2
	je	.L28
	mov	rdi, QWORD PTR 16[rsi]
	mov	rdx, QWORD PTR stdin[rip]
	lea	rsi, .LC5[rip]
	call	freopen@PLT
	mov	edx, 3
	lea	rdi, .LC6[rip]
	test	rax, rax
	je	.L38
.L27:
	lea	eax, 1[rdx]
	cmp	eax, ebp
	ja	.L28
	mov	rcx, QWORD PTR 8[rbx]
	mov	r12b, BYTE PTR [rcx]
	mov	ecx, edx
	mov	rcx, QWORD PTR [rbx+rcx*8]
	cmp	BYTE PTR [rcx], 49
	jne	.L29
	cmp	edx, 2
	setne	dl
	movzx	edx, dl
	add	edx, 4
	cmp	ebp, edx
	jb	.L28
	mov	rdi, QWORD PTR [rbx+rax*8]
	mov	rdx, QWORD PTR stdout[rip]
	lea	rsi, .LC7[rip]
	call	freopen@PLT
	test	rax, rax
	jne	.L29
	lea	rdi, .LC8[rip]
.L38:
	call	puts@PLT
	jmp	.L26
.L29:
	xor	edx, edx
	cmp	r12b, 50
	mov	esi, 33554428
	sete	dl
	lea	rdi, A[rip]
	call	input
	mov	rbx, rax
	call	clock@PLT
	mov	r10d, 15
	lea	r11, B[rip]
	mov	rbp, rax
.L30:
	mov	rdx, r11
	mov	rsi, rbx
	lea	rdi, A[rip]
	call	solve
	mov	r12, rax
	dec	r10d
	jne	.L30
	call	clock@PLT
	mov	rsi, r12
	lea	rdi, B[rip]
	mov	rbx, rax
	call	output
	sub	rbx, rbp
	lea	rdi, .LC9[rip]
	xor	eax, eax
	imul	rsi, rbx, 1000
	call	printf@PLT
.L26:
	pop	rbx
	xor	eax, eax
	pop	rbp
	pop	r12
	ret
	.size	main, .-main
	.local	B
	.comm	B,268435440,32
	.local	A
	.comm	A,268435440,32
	.ident	"GCC: (Debian 8.3.0-6) 8.3.0"
	.section	.note.GNU-stack,"",@progbits
