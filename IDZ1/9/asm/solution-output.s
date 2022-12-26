    .intel_syntax noprefix
	
    
	.section	.rodata
.LC3:
	.string	"%lld "  # бывшая переменная lli_output_template

    .text
    .globl	output
output:
	push rbp # save frame pointer
	mov	rbp, rsp # save stack pointer
	push r12 # save r12 on the stack
	push r13 # save r13 on the stack
	push rbx # save rbx on the stack and let it be uint64_t i

	mov r12, rdi # put rdi - first function argument (const int64_t* memory) - into a callee-saved register r12
	mov r13, rsi # put rsi - second function argument (const uint64_t length) - into a callee-saved register r13
	mov rbx, 1 # uint64_t i = 1
	jmp	.L14
.L15:
	lea	rdi, .LC3[rip] # rdi <-- address of "%lld " - first function argument
	mov rsi, [r12 + 8 * rbx] # rsi <-- memory[i] - second function argument
	mov	eax, 0 # we do not expect printf() to use coprocessors (x87, SSE, etc.)
	call printf@PLT # printf("%lld ", memory[i]);

	inc rbx # i++
.L14:
	cmp	rbx, r13 # i v length
	jbe	.L15 # if (i <= length) - continue the loop
    
	pop rbx # restore the value of rbx
	pop r13 # restore the value of r13
	pop r12 # restore the value of r12
	pop	rbp # restore frame pointer, stack pointer has not been changed
	ret # return
