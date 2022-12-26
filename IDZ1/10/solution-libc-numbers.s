    .intel_syntax noprefix

    .section .text
    .globl	scanf
scanf: # reads an integer from .instream and returns it
	push r12 # save r12 on the stack
	push r13 # save r13 on the stack
	push rbp # save frame pointer
	mov	rbp, rsp # save stack pointer
    sub rsp, 1 # buffer to read symbols
    mov r12, 0 # r12 will be the answer
    mov r13, 1 # r13 will be a +/- flag

    mov rax, 0 # sys_read
    mov rdi, QWORD PTR .instream[rip] # instream
    mov rsi, rsp # buffer
    mov rdx, 1 # count
    syscall
    mov al, BYTE PTR [rsp]

    mov r8, -1
    cmp al, '-'
    cmove r13, r8
    je .sign_parsed

    cmp al, '+'
    je .sign_parsed

    sub al, '0'
    cmp al, 9
    ja .return # unsigned compare
    movzx r12, al

.sign_parsed: # .parse_digit
    mov rax, 0 # sys_read
    mov rdi, QWORD PTR .instream[rip] # instream
    mov rsi, rsp # buffer
    mov rdx, 1 # count
    syscall
    cmp rax, 0
    je .parse_digit_stop
    movzx rax, BYTE PTR [rsp]
    sub rax, '0'
    cmp al, 9
    ja .parse_digit_stop # unsigned compare
    imul r12, r12, 10
    add r12, rax
    jmp .sign_parsed # .parse_digit
.parse_digit_stop:
    imul r12, r13
.return:
    mov rax, r12 # return value
	leave # restore stack and frame pointers
	pop r13 # restore the value of r13
	pop r12 # restore the value of r12
	ret # return


    
    .globl	printf
printf: # prints an integer into .outstream
	push rbp # save frame pointer
	mov	rbp, rsp # save stack pointer
    sub rsp, 24 # buffer
    # rdi - number to print
    mov rdx, 0
    mov rax, rdi
    mov r8, 10
    # rdx:rax (rax) - number to print
    mov rcx, 0 # rcx - length of the buffer
    mov r9, 0 # the sign of the number is positive
    cmp rax, 0
    jge .positive_number
    mov r9, 1 # the sign is negative
    imul rax, rax, -1
.positive_number:
    mov rdx, 0
    div r8 # RAX := Quotient, RDX := Remainder
    add dl, '0'
    mov BYTE PTR [rsp + rcx], dl
    inc rcx
    cmp rax, 0
    ja .positive_number

    # print
    cmp r9, 1
    jnz .positive_sign
    mov BYTE PTR [rsp + rcx], '-'
    inc rcx
.positive_sign:
    mov rdx, rcx # count
    # reverse the buffer
    shr rcx, 1 # rcx /= 2
    mov r8, rdx
    sub r8, rcx
.reverse_loop_start:
    cmp rcx, 0
    jz .reverse_loop_end
    # swap BYTE PTR [rsp + rcx - 1] and BYTE PTR [rsp + rdx - rcx] = [rsp + r8]
    mov al, BYTE PTR [rsp + rcx - 1]
    mov r9b, BYTE PTR [rsp + r8]
    mov BYTE PTR [rsp + rcx - 1], r9b
    mov BYTE PTR [rsp + r8], al
    # next iteration
    dec rcx
    inc r8
    jmp .reverse_loop_start
.reverse_loop_end:
    mov BYTE PTR [rsp + rdx], ' '
    inc rdx

    mov rax, 1 # sys_write
    mov rdi, QWORD PTR .outstream[rip] # outstream
    mov rsi, rsp # buffer
    syscall
    mov rax, 0 # return value
	leave # restore stack and frame pointers
	ret # return
