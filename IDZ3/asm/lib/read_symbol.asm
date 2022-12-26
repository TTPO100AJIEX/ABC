    .intel_syntax noprefix


    .section .text
    .globl read_symbol
read_symbol: # reads a symbol from .instream and returns it or 0 if nothing has been read
	push rbp # save frame pointer
	mov	rbp, rsp # save stack pointer
    sub rsp, 1 # buffer to read symbols
    mov rax, 0 # sys_read
    mov rdi, .instream[rip] # instream
    lea rsi, [rsp] # buffer
    mov rdx, 1 # count
    syscall # rax <-- amount of symbols that have been read
    cmp rax, 0
    jz .return # if (nothing has been read)
    mov rax, 0
    mov al, [rsp] # rax ~ al is the code of the symbol read
.return:
	leave # restore stack and frame pointers
    ret