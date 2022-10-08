.intel_syntax noprefix

.section .rodata
    output_template:
        .string "%d! = %llu\n"
    
.text
.globl main
.type main, @function
factorial:
    push rbp
    mov rbp, rsp

    mov rax, 1
    mov rdx, 0
    mov rcx, 0
    calculate:
        inc rcx
        mul rcx
        cmp rcx, rdi
        jne calculate
    
    leave
    ret

main:
    push rbp
    mov rbp, rsp
        
    mov r12, 0
    check_next:
        inc r12
        mov rdi, r12
        call factorial
        cmp rdx, 0
        jne finish

        lea rdi, output_template[rip]
        mov rsi, r12
        mov rdx, rax
        mov rax, 0
        call printf

        jmp check_next

    finish:
    mov rax, 0
    mov rsp, rbp
    pop rbp
    ret
    