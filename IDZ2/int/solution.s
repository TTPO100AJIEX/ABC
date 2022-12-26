	.file	"solution.c"
	.intel_syntax noprefix
	.text
	.section	.rodata
.LC0:
	.string	"%llu"
.LC1:
	.string	"The input is too long!"
	.align 8
.LC2:
	.string	"Non-ASCII characters encountered!"
	.text
	.globl	input
	.type	input, @function
input:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 48
	mov	QWORD PTR -40[rbp], rdi
	mov	DWORD PTR -44[rbp], esi
	cmp	DWORD PTR -44[rbp], 1
	jne	.L2
	lea	rax, -32[rbp]
	mov	rsi, rax
	lea	rdi, .LC0[rip]
	mov	eax, 0
	call	__isoc99_scanf@PLT
	mov	rax, QWORD PTR -32[rbp]
	cmp	rax, 1073741824
	jbe	.L3
	lea	rdi, .LC1[rip]
	mov	eax, 0
	call	printf@PLT
	mov	eax, 1073741825
	jmp	.L7
.L3:
	mov	edi, 0
	call	time@PLT
	mov	edi, eax
	call	srand@PLT
	mov	QWORD PTR -8[rbp], 0
	jmp	.L5
.L6:
	call	rand@PLT
	mov	ecx, eax
	mov	rdx, QWORD PTR -40[rbp]
	mov	rax, QWORD PTR -8[rbp]
	add	rax, rdx
	and	ecx, 127
	mov	edx, ecx
	mov	BYTE PTR [rax], dl
	add	QWORD PTR -8[rbp], 1
.L5:
	mov	rax, QWORD PTR -32[rbp]
	cmp	QWORD PTR -8[rbp], rax
	jb	.L6
	mov	rax, QWORD PTR -32[rbp]
	jmp	.L7
.L2:
	mov	rdx, QWORD PTR stdin[rip]
	mov	rax, QWORD PTR -40[rbp]
	mov	rcx, rdx
	mov	edx, 1073741825
	mov	esi, 1
	mov	rdi, rax
	call	fread@PLT
	mov	QWORD PTR -24[rbp], rax
	cmp	QWORD PTR -24[rbp], 1073741825
	jne	.L8
	lea	rdi, .LC1[rip]
	mov	eax, 0
	call	printf@PLT
	mov	eax, 1073741825
	jmp	.L7
.L8:
	mov	QWORD PTR -16[rbp], 0
	jmp	.L9
.L11:
	mov	rdx, QWORD PTR -40[rbp]
	mov	rax, QWORD PTR -16[rbp]
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jns	.L10
	lea	rdi, .LC2[rip]
	mov	eax, 0
	call	printf@PLT
	mov	eax, 1073741825
	jmp	.L7
.L10:
	add	QWORD PTR -16[rbp], 1
.L9:
	mov	rax, QWORD PTR -16[rbp]
	cmp	rax, QWORD PTR -24[rbp]
	jb	.L11
	mov	rax, QWORD PTR -24[rbp]
.L7:
	leave
	ret
	.size	input, .-input
	.globl	solve
	.type	solve, @function
solve:
	push	rbp
	mov	rbp, rsp
	mov	QWORD PTR -40[rbp], rdi
	mov	QWORD PTR -48[rbp], rsi
	mov	QWORD PTR -32[rbp], 0
	mov	QWORD PTR -24[rbp], 0
	mov	QWORD PTR -8[rbp], 0
	jmp	.L13
.L18:
	mov	rdx, QWORD PTR -40[rbp]
	mov	rax, QWORD PTR -8[rbp]
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	cmp	al, 47
	jbe	.L14
	mov	rdx, QWORD PTR -40[rbp]
	mov	rax, QWORD PTR -8[rbp]
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	cmp	al, 57
	ja	.L14
	mov	rax, QWORD PTR -32[rbp]
	add	rax, 1
	mov	QWORD PTR -32[rbp], rax
	jmp	.L15
.L14:
	mov	rdx, QWORD PTR -40[rbp]
	mov	rax, QWORD PTR -8[rbp]
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	cmp	al, 96
	jbe	.L16
	mov	rdx, QWORD PTR -40[rbp]
	mov	rax, QWORD PTR -8[rbp]
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	cmp	al, 122
	jbe	.L17
.L16:
	mov	rdx, QWORD PTR -40[rbp]
	mov	rax, QWORD PTR -8[rbp]
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	cmp	al, 64
	jbe	.L15
	mov	rdx, QWORD PTR -40[rbp]
	mov	rax, QWORD PTR -8[rbp]
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	cmp	al, 90
	ja	.L15
.L17:
	mov	rax, QWORD PTR -24[rbp]
	add	rax, 1
	mov	QWORD PTR -24[rbp], rax
.L15:
	add	QWORD PTR -8[rbp], 1
.L13:
	mov	rax, QWORD PTR -8[rbp]
	cmp	rax, QWORD PTR -48[rbp]
	jb	.L18
	mov	rax, QWORD PTR -32[rbp]
	mov	rdx, QWORD PTR -24[rbp]
	pop	rbp
	ret
	.size	solve, .-solve
	.section	.rodata
.LC3:
	.string	"Numbers: %llu, Letters: %llu"
	.text
	.globl	output
	.type	output, @function
output:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 16
	mov	rax, rdi
	mov	rcx, rsi
	mov	rdx, rcx
	mov	QWORD PTR -16[rbp], rax
	mov	QWORD PTR -8[rbp], rdx
	mov	rdx, QWORD PTR -8[rbp]
	mov	rax, QWORD PTR -16[rbp]
	mov	rsi, rax
	lea	rdi, .LC3[rip]
	mov	eax, 0
	call	printf@PLT
	nop
	leave
	ret
	.size	output, .-output
	.section	.rodata
	.align 8
.LC4:
	.string	"Incorrect command line arguments provided!"
.LC5:
	.string	"r"
.LC6:
	.string	"Failed to open an input file!"
.LC7:
	.string	"w"
	.align 8
.LC8:
	.string	"Failed to open an output file!"
.LC9:
	.string	"\nCPU time used: %lluns"
	.text
	.globl	main
	.type	main, @function
main:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 80
	mov	DWORD PTR -68[rbp], edi
	mov	QWORD PTR -80[rbp], rsi
	cmp	DWORD PTR -68[rbp], 1
	jg	.L22
	lea	rdi, .LC4[rip]
	call	puts@PLT
	mov	eax, 0
	jmp	.L31
.L22:
	mov	DWORD PTR -4[rbp], 2
	mov	DWORD PTR -8[rbp], 0
	mov	rax, QWORD PTR -80[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	movzx	eax, BYTE PTR [rax]
	cmp	al, 49
	jne	.L24
	cmp	DWORD PTR -68[rbp], 2
	jg	.L25
	lea	rdi, .LC4[rip]
	call	puts@PLT
	mov	eax, 0
	jmp	.L31
.L25:
	mov	rdx, QWORD PTR stdin[rip]
	mov	eax, DWORD PTR -4[rbp]
	lea	ecx, 1[rax]
	mov	DWORD PTR -4[rbp], ecx
	mov	eax, eax
	lea	rcx, 0[0+rax*8]
	mov	rax, QWORD PTR -80[rbp]
	add	rax, rcx
	mov	rax, QWORD PTR [rax]
	lea	rsi, .LC5[rip]
	mov	rdi, rax
	call	freopen@PLT
	test	rax, rax
	jne	.L24
	lea	rdi, .LC6[rip]
	call	puts@PLT
	mov	eax, 0
	jmp	.L31
.L24:
	mov	rax, QWORD PTR -80[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	movzx	eax, BYTE PTR [rax]
	cmp	al, 50
	jne	.L26
	mov	DWORD PTR -8[rbp], 1
.L26:
	mov	eax, DWORD PTR -4[rbp]
	lea	edx, 1[rax]
	mov	eax, DWORD PTR -68[rbp]
	cmp	edx, eax
	jbe	.L27
	lea	rdi, .LC4[rip]
	call	puts@PLT
	mov	eax, 0
	jmp	.L31
.L27:
	mov	eax, DWORD PTR -4[rbp]
	lea	rdx, 0[0+rax*8]
	mov	rax, QWORD PTR -80[rbp]
	add	rax, rdx
	mov	rax, QWORD PTR [rax]
	movzx	eax, BYTE PTR [rax]
	cmp	al, 49
	jne	.L28
	mov	eax, DWORD PTR -4[rbp]
	lea	edx, 2[rax]
	mov	eax, DWORD PTR -68[rbp]
	cmp	edx, eax
	jbe	.L29
	lea	rdi, .LC4[rip]
	call	puts@PLT
	mov	eax, 0
	jmp	.L31
.L29:
	mov	rdx, QWORD PTR stdout[rip]
	mov	eax, DWORD PTR -4[rbp]
	add	eax, 1
	mov	eax, eax
	lea	rcx, 0[0+rax*8]
	mov	rax, QWORD PTR -80[rbp]
	add	rax, rcx
	mov	rax, QWORD PTR [rax]
	lea	rsi, .LC7[rip]
	mov	rdi, rax
	call	freopen@PLT
	test	rax, rax
	jne	.L28
	lea	rdi, .LC8[rip]
	call	puts@PLT
	mov	eax, 0
	jmp	.L31
.L28:
	mov	eax, DWORD PTR -8[rbp]
	mov	esi, eax
	lea	rdi, string.0[rip]
	call	input
	mov	QWORD PTR -16[rbp], rax
	cmp	QWORD PTR -16[rbp], 1073741824
	jbe	.L30
	mov	eax, 0
	jmp	.L31
.L30:
	call	clock@PLT
	mov	QWORD PTR -24[rbp], rax
	mov	rax, QWORD PTR -16[rbp]
	mov	rsi, rax
	lea	rdi, string.0[rip]
	call	solve
	mov	QWORD PTR -64[rbp], rax
	mov	QWORD PTR -56[rbp], rdx
	call	clock@PLT
	mov	QWORD PTR -32[rbp], rax
	mov	rax, QWORD PTR -32[rbp]
	sub	rax, QWORD PTR -24[rbp]
	imul	rax, rax, 1000000000
	movabs	rdx, 4835703278458516699
	mul	rdx
	mov	rax, rdx
	shr	rax, 18
	mov	QWORD PTR -40[rbp], rax
	mov	rdx, QWORD PTR -64[rbp]
	mov	rax, QWORD PTR -56[rbp]
	mov	rdi, rdx
	mov	rsi, rax
	call	output
	mov	rax, QWORD PTR -40[rbp]
	mov	rsi, rax
	lea	rdi, .LC9[rip]
	mov	eax, 0
	call	printf@PLT
	mov	eax, 0
.L31:
	leave
	ret
	.size	main, .-main
	.local	string.0
	.comm	string.0,1073741825,32
	.ident	"GCC: (Debian 10.2.1-6) 10.2.1 20210110"
	.section	.note.GNU-stack,"",@progbits
