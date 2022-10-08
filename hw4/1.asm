.intel_syntax noprefix

.section .rodata
    output_template:
        .string "%d\n"
    
.text
.globl main
.type main, @function
main:
    push rbp
    mov rbp, rsp
    
    mov rax, 1
    mov rdx, 0
    mov rcx, 1
    
    check_next:
        inc rcx
        mul rcx
        cmp rdx, 0
        jne print_answer
        jmp check_next
    print_answer:
    dec rcx
    
    lea rdi, output_template[rip]
    mov rsi, rcx
    mov rax, 0
    call printf

    mov rax, 0
    mov rsp, rbp
    pop rbp
    ret
