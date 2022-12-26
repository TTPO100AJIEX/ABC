    .intel_syntax noprefix


    .section .text
    .globl print_integer
print_integer: # prints an integer into .outstream
	push rbp # save frame pointer
	mov	rbp, rsp # save stack pointer
    sub rsp, 32 # buffer
    # rdi - number to print
    mov rsi, rsp # rsi <-- address of the buffer for the number
    call integer_to_buffer # rax <-- length of the buffer
    # buffer starts at [rsp - rax + 24] and ends at [rsp + 24]
    
    mov rcx, rax # rcx <-- length
    neg rcx # rcx <-- (-length)
    mov rdx, rax # length
    mov rax, 1 # sys_write
    mov rdi, .outstream[rip] # outstream
    lea rsi, [rsp + rcx + 25] # buffer (starts at [rsp + 24 - (length - 1)])
    syscall

    mov rax, 0 # return value
	leave # restore stack and frame pointers
    ret # return
