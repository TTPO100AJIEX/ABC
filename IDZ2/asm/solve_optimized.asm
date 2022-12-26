    .intel_syntax noprefix


    .section .text
    .globl	solve
solve:
    mov rax, 0 # res.numbers
    mov rdx, 0 # res.letters
    # rdi = const unsigned char* buffer; rsi = const uint64_t length
    lea r9, [rdi + rsi] # address past last symbol - end of loop
.loop:
    cmp rdi, r9
    je .return # if (i >= length) - stop loop
    movzx ecx, BYTE PTR [rdi] # rcx ~ ecx ~ cl <-- buffer[i]
    add rdi, 1
    lea r8, [rcx - 48]
    cmp r8, 9
    ja .check_if_letter
    add rax, 1
    jmp .loop
.check_if_letter:
    btr rcx, 5
    lea rcx, [rcx - 65]
    cmp rcx, 26
    adc rdx, 0
    jmp .loop

.return:
	ret # return
