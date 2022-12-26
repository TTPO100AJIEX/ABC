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
	.p2align 4,,15
	.globl	input
	.type	input, @function
input:
	push	r13
	xor	eax, eax
	mov	r13, rdi
	lea	rdi, .LC0[rip]
	push	r12
	push	rbp
	mov	ebp, edx
	push	rbx
	mov	rbx, rsi
	sub	rsp, 24
	lea	rsi, 8[rsp]
	call	__isoc99_scanf@PLT
	mov	rax, QWORD PTR 8[rsp]
	cmp	rax, rbx
	ja	.L17
	cmp	ebp, 1
	je	.L4
	lea	rbp, 8[r13]
	mov	ebx, 1
	lea	r12, .LC2[rip]
	test	rax, rax
	je	.L6
	.p2align 4,,10
	.p2align 3
.L8:
	mov	rsi, rbp
	mov	rdi, r12
	xor	eax, eax
	add	rbx, 1
	call	__isoc99_scanf@PLT
	mov	rax, QWORD PTR 8[rsp]
	add	rbp, 8
	cmp	rax, rbx
	jnb	.L8
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
	je	.L23
	lea	rsi, [rdi+rsi*8]
	xor	eax, eax
	.p2align 4,,10
	.p2align 3
.L22:
	mov	rcx, QWORD PTR 8[rdi]
	cmp	rcx, QWORD PTR [rdi]
	jge	.L20
	cmp	rcx, QWORD PTR 16[rdi]
	jg	.L21
.L20:
	add	rax, 1
	mov	QWORD PTR [rdx+rax*8], rcx
.L21:
	add	rdi, 8
	cmp	rdi, rsi
	jne	.L22
	ret
	.p2align 4,,10
	.p2align 3
.L23:
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
	je	.L33
	push	r12
	push	rbp
	lea	rbp, .LC3[rip]
	push	rbx
	lea	rbx, 8[rdi]
	lea	r12, [rbx+rsi*8]
	.p2align 4,,10
	.p2align 3
.L27:
	mov	rsi, QWORD PTR [rbx]
	mov	rdi, rbp
	xor	eax, eax
	add	rbx, 8
	call	printf@PLT
	cmp	rbx, r12
	jne	.L27
	pop	rbx
	pop	rbp
	pop	r12
	ret
	.p2align 4,,10
	.p2align 3
.L33:
	ret
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
	push	r13
	push	r12
	push	rbp
	push	rbx
	sub	rsp, 8
	cmp	edi, 1
	jle	.L40
	mov	rax, QWORD PTR 8[rsi]
	mov	ebp, edi
	mov	rbx, rsi
	mov	edx, 2
	cmp	BYTE PTR [rax], 49
	je	.L61
.L39:
	lea	eax, 1[rdx]
	cmp	eax, ebp
	ja	.L40
	mov	rcx, QWORD PTR 8[rbx]
	movzx	r12d, BYTE PTR [rcx]
	mov	ecx, edx
	mov	rcx, QWORD PTR [rbx+rcx*8]
	cmp	BYTE PTR [rcx], 49
	jne	.L41
	cmp	edx, 2
	setne	dl
	movzx	edx, dl
	add	edx, 4
	cmp	ebp, edx
	jb	.L40
	mov	rdi, QWORD PTR [rbx+rax*8]
	mov	rdx, QWORD PTR stdout[rip]
	lea	rsi, .LC7[rip]
	call	freopen@PLT
	test	rax, rax
	je	.L62
.L41:
	xor	edx, edx
	cmp	r12b, 50
	mov	esi, 33554428
	lea	rdi, A[rip]
	sete	dl
	call	input
	mov	rbp, rax
	call	clock@PLT
	lea	r8, A[rip]
	mov	ecx, 15
	lea	rsi, B[rip]
	mov	r12, rax
	lea	rdi, [r8+rbp*8]
	.p2align 4,,10
	.p2align 3
.L42:
	mov	rax, r8
	xor	ebx, ebx
	test	rbp, rbp
	je	.L63
	.p2align 4,,10
	.p2align 3
.L45:
	mov	rdx, QWORD PTR 8[rax]
	cmp	rdx, QWORD PTR [rax]
	jge	.L43
	cmp	rdx, QWORD PTR 16[rax]
	jg	.L44
.L43:
	add	rbx, 1
	mov	QWORD PTR [rsi+rbx*8], rdx
.L44:
	add	rax, 8
	cmp	rdi, rax
	jne	.L45
	sub	ecx, 1
	jne	.L42
.L46:
	call	clock@PLT
	sub	rax, r12
	imul	r13, rax, 1000
	test	rbx, rbx
	je	.L50
	lea	rbp, B[rip]
	lea	r12, 0[rbp+rbx*8]
	lea	rbx, .LC3[rip]
	.p2align 4,,10
	.p2align 3
.L49:
	mov	rsi, QWORD PTR 8[rbp]
	mov	rdi, rbx
	xor	eax, eax
	add	rbp, 8
	call	printf@PLT
	cmp	rbp, r12
	jne	.L49
.L50:
	mov	rsi, r13
	lea	rdi, .LC9[rip]
	xor	eax, eax
	call	printf@PLT
.L38:
	add	rsp, 8
	xor	eax, eax
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	ret
.L61:
	cmp	edi, 2
	jne	.L64
.L40:
	lea	rdi, .LC4[rip]
	call	puts@PLT
	jmp	.L38
	.p2align 4,,10
	.p2align 3
.L63:
	mov	rbx, rbp
	sub	ecx, 1
	jne	.L42
	jmp	.L46
.L64:
	mov	rdi, QWORD PTR 16[rsi]
	mov	rdx, QWORD PTR stdin[rip]
	lea	rsi, .LC5[rip]
	call	freopen@PLT
	mov	edx, 3
	test	rax, rax
	jne	.L39
	lea	rdi, .LC6[rip]
	call	puts@PLT
	jmp	.L38
.L62:
	lea	rdi, .LC8[rip]
	call	puts@PLT
	jmp	.L38
	.size	main, .-main
	.local	B
	.comm	B,268435440,32
	.local	A
	.comm	A,268435440,32
	.ident	"GCC: (Debian 8.3.0-6) 8.3.0"
	.section	.note.GNU-stack,"",@progbits
