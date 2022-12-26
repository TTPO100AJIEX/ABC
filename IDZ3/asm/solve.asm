    .intel_syntax noprefix


    .section .rodata
.constant_1:
    .double 1
.constant_0_0000001:
    .double 0.0000001
.constant_0_0005_squared:
    .double 0.00000025
.constant_1_5707963:
    .double 1.5707963
.constant_neg_1_5707963:
    .double -1.5707963

    .section .text
    .globl	solve
solve:
    # xmm4 - xmm7 is a storage for constants that may be needed multiple times
    movsd xmm7, xmm0 # save the input argument (double x) in xmm7
    movsd xmm6, xmm0 # xmm6 <-- x
    mulsd xmm6, xmm0 # xmm6 <-- x * x

    movsd xmm5, .constant_1[rip] # xmm5 <-- 1
    subsd xmm5, xmm6 # xmm5 <-- 1 - x * x
    comisd xmm5, .constant_0_0000001[rip] # (1 - x * x) v 1e-7
    jb .return_edgecase
    
    movsd xmm4, .constant_0_0005_squared[rip]

    pxor xmm0, xmm0 # xmm0 <-- 0; let xmm0 be double answer
    movsd xmm1, xmm7 # xmm1 <-- x; let xmm1 be double g
    mov rcx, 0 # unsigned int k = 0 ~ rcx <-- 0
    .loop:
        # |g / (1 - x * x)| v 0.0005
        # (g / (1 - x * x)) ^ 2 v 0.0005 ^ 2
        movsd xmm2, xmm1 # xmm2 <-- g
        divsd xmm2, xmm5 # g / (1 - x * x)
        mulsd xmm2, xmm2 # (g / (1 - x * x)) ^ 2
        comisd xmm2, xmm4 # (g / (1 - x * x)) ^ 2 v 0.0005 ^ 2
        jb .return # (g / (1 - x * x)) ^ 2 < 0.0005 ^ 2 => |g / (1 - x * x)| < 0.0005 => stop
        
        addsd xmm0, xmm1 # xmm0 <-- xmm0 + xmm1 ~ answer += g
        add rcx, 1 # k++
        mov rdx, rcx # rdx <-- k
        shl rdx, 1 # rdx <-- 2 * k
        
        pxor xmm2, xmm2 # break dependencies on xmm2
        lea rax, [rdx - 1] # rax <-- 2 * k - 1
        imul rax, rax # rax <-- (2k-1) * (2k-1)
        cvtsi2sd xmm2, rax # xmm2 <-- ((2k-1) * (2k-1))
        mulsd xmm2, xmm6 # xmm2 <-- (x*x) * ((2k-1) * (2k-1))

        lea rax, [rdx + 1] # rax <-- 2 * k + 1
        imul rax, rdx # rax <-- (2*k) * (2*k+1)
        cvtsi2sd xmm3, rax
        divsd xmm2, xmm3 # xmm2 <-- (x*x) * ((2k-1) * (2k-1)) / ((2*k) * (2*k+1))

        mulsd xmm1, xmm2 # g *= (x*x) * ((2k-1) * (2k-1)) / ((2*k) * (2*k+1))
        jmp .loop

.return:
    # no callee-saved registers have been used and no outside calls have been made, so it is not necessary to organize the function frame on the stack
	ret # return
.return_edgecase:
    pxor xmm1, xmm1 # xmm1 <-- 0
    comisd xmm7, xmm1 # x v 0
    jb .negative
    movsd xmm0, .constant_1_5707963[rip]
    jmp .return
.negative:
    movsd xmm0, .constant_neg_1_5707963[rip]
    jmp .return
