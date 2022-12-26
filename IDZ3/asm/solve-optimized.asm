    .intel_syntax noprefix


    .section .rodata
.constant_1:
    .double 1
.constant_0_0000001:
    .double 0.0000001
.constant_0_0005:
    .double 0.0005
.constant_1_5707963:
    .double 1.5707963
.constant_neg_1_5707963:
    .double -1.5707963
.fabs_mask: # mask to take the absolute value of a number. Basically, 0b0111...111, where the only 0 bit is the sign bit of a double precision floating point number
	.long -1 # 0b11111...1111
	.long 2147483647 # 0b0111111
.fneg_mask: # mask to change the sign of a number to negative. Basically, 0b100.000, where the only 1 bit is the sign bit of a double precision floating point number
	.long 0 # 0b0000...0000
	.long 2147483648 # 0b100..0000

    .section .text
    .globl	solve
solve:
    # xmm4 - xmm7 is a storage for constants that may be needed multiple times
    movapd xmm7, xmm0 # xmm7 <-- x
    mulsd xmm7, xmm0 # xmm7 <-- x * x

    movq xmm6, .constant_1[rip] # xmm6 <-- 1
    subsd xmm6, xmm7 # xmm6 <-- 1 - x * x
    movsd xmm5, .constant_0_0000001[rip] # xmm5 <-- 1e-7
    comisd xmm6, xmm5 # (1 - x * x) v 1e-7
    jb .return_edgecase

    pxor xmm5, xmm5 # break dependencies on xmm5
    pxor xmm1, xmm1 # xmm1 <-- 0; let xmm1 be double answer
    movq xmm5, .fabs_mask[rip]

    mov r10, 0 # sign flag of x: x is positive
    mov r9, 1 # just a number 1
    comisd xmm0, xmm1 # x v 0
    cmovb r10, r9 # r10 <-- 1: x is negative
    andpd xmm0, xmm5 # xmm0 <-- |x|
    
    pxor xmm5, xmm5 # break dependencies on xmm5
    # calculate the answer for x := |x|
    # let xmm0 be double g
    divsd xmm0, xmm6 # xmm0 <-- (g / (1 - x * x))
    movq xmm5, .constant_0_0005[rip] # xmm5 <-- 0.0005

    xor rax, rax # 2k
    mov rcx, -1 # 2k - 1
    mov rdx, 1 # 2k + 1
    .loop:
        pxor xmm2, xmm2 # break dependencies on xmm2
        pxor xmm3, xmm3 # break dependencies on xmm3

        comisd xmm0, xmm5 # (g / (1 - x * x)) v 0.0005
        jb .return # (g / (1 - x * x)) < 0.0005 => stop
        
        addsd xmm1, xmm0 # answer += (g / (1 - x*x))
        add rcx, 2 # (2k-1)(k+1) = 2k-1 + 2

        mov rsi, rcx # rsi <-- (2k-1)
        imul rsi, rcx # rsi <-- ((2k-1) * (2k-1))
        cvtsi2sd xmm2, rsi # xmm2 <-- ((2k-1) * (2k-1))
        mulsd xmm2, xmm7 # xmm2 <-- (x*x) * ((2k-1) * (2k-1))

        add rax, 2 # (2k)(k+1) = 2k + 2
        add rdx, 2 # (2k+1)(k+1) = 2k+1 + 2
        mov rdi, rax # rdi <-- 2k
        imul rdi, rdx # rdi <-- ((2*k) * (2*k+1))
        cvtsi2sd xmm3, rdi # xmm3 <-- ((2*k) * (2*k+1))

        divsd xmm2, xmm3 # xmm2 <-- (x*x) * ((2k-1) * (2k-1)) / ((2*k) * (2*k+1))
        mulsd xmm0, xmm2 # g *= (x*x) * ((2k-1) * (2k-1)) / ((2*k) * (2*k+1))

        jmp .loop

.return:
    cmp r10, 0 # sgn(x) v 0
    je .already_correct_sign # sgn(x) == 0 => x is positive => answer is positive
    movq xmm4, .fneg_mask[rip] # xmm4 <-- 0b1000...0000
    orpd xmm1, xmm4 # xmm1 <-- -xmm1
    .already_correct_sign:
    mulsd xmm1, xmm6 # answer *= (1 - x * x)
    movapd xmm0, xmm1 # xmm0 <-- answer
    # no callee-saved registers have been used and no outside calls have been made, so it is not necessary to organize the function frame on the stack
	ret # return
.return_edgecase:
    pxor xmm1, xmm1 # xmm1 <-- 0
    comisd xmm0, xmm1 # x v 0
    jb .negative
    movsd xmm0, .constant_1_5707963[rip]
    ret # return
.negative:
    movsd xmm0, .constant_neg_1_5707963[rip]
    ret # return
