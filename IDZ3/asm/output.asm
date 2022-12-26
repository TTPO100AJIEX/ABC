    .intel_syntax noprefix


    .section .text
    .globl	output
output:
	push rbp # save frame pointer
	mov	rbp, rsp # save stack pointer

    call print_double

    sub rsp, 8
    mov BYTE PTR [rsp], '\n'
    mov rax, 1 # sys_write
    mov rdi, .outstream[rip] # outstream
    lea rsi, [rsp] # buffer
    mov rdx, 1 # length
    syscall # print newline character

	leave # restore stack and frame pointers
    ret # return
