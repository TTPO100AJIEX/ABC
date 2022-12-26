    .intel_syntax noprefix
	
    
    .text
    .globl	solve
solve:
	push rbp # save frame pointer
	mov	rbp, rsp # save stack pointer
	# rdi - first function argument (const int64_t* src)
	# rsi - second function argument (const uint64_t src_length)
	# rdx - third function argument (int64_t* dest)
	# rax - uint64_t length
	# rcx - uint64_t i
	mov rax, 0 # uint64_t length = 0;
	mov rcx, 1 # uint64_t i = 1;
	jmp	.L8
.L11:
	mov r8, [rdi + 8 * rcx] # r8 <-- src[i]
	mov r9, [rdi + 8 * rcx - 8] # r9 <-- src[i - 1]
	cmp	r8, r9 # src[i] v src[i - 1]
	jge	.L9 # src[i] >= src[i - 1] => condition is true ("short-circuit" evaluation)

	mov r10, [rdi + 8 * rcx + 8] # r10 <-- src[i + 1]
	cmp	r8, r10 # src[i] v src[i + 1]
	jg .L10 # src[i] > src[i + 1] => condition is false

.L9:
	inc rax # ++length
	mov	QWORD PTR [rdx + 8 * rax], r8 # dest[++length] = src[i]

.L10:
	inc rcx # i = i + 1 <==> i++
.L8:
	cmp	rcx, rsi # i v src_length
	jbe	.L11 # if (i <= src_length) - continue the loop

	# return value (length) is already in rax
	pop	rbp # restore frame pointer, stack pointer has not been changed
	ret # return
