    .intel_syntax noprefix

    .section .text
    .globl	input
input:
	push rbp # save frame pointer
	mov	rbp, rsp # save stack pointer

    # rdi - first function argument (bool is_random)
    cmp rdi, 0
    jz .scanf

    # .random:
    # idea: generate 4 byte-integer, divide by 2^31 => get [0; 2] range; subtract 1 => get [-1; 1] range
    sub rsp, 4
    mov rax, 318 # sys_getrandom
    lea rdi, [rsp] # buffer
    mov rsi, 4 # count
    mov rdx, 0 # flags
    syscall

    mov eax, [rsp + 4] # extend to 64 bits - needed as cvtsi2sd only works with signed integers
    cvtsi2sd xmm0, rax # [0; 2^32]
    mov rax, 1
    shl rax, 31 # rax <-- 2^31 = 2147483648
    cvtsi2sd xmm1, rax # xmm1 <-- 2^31
    divsd xmm0, xmm1 # [0; 2]
    mov rax, 1
    cvtsi2sd xmm1, rax # xmm1 <-- 1
    subsd xmm0, xmm1 # [-1, 1]
    jmp .return

    .scanf:
    call read_double

    .return:
	leave # restore stack and frame pointers
    ret
