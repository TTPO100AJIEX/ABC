    .intel_syntax noprefix


    .section .rodata
.constant_10000000:
    .double 10000000

    .section .text
    .globl print_double
print_double:
	push rbp # save frame pointer
	mov	rbp, rsp # save stack pointer

    movsd xmm1, .constant_10000000[rip] # xmm1 <-- 1e7
    mulsd xmm0, xmm1 # xmm0 <-- 1e7 * xmm0
    cvttsd2si rdi, xmm0 # rdi <-- 1e7 * answer: last 7 digits are the digits after the decimal point

    sub rsp, 32 # buffer
    # fill the buffer with symbols of zero
    # '0' = 48  => '0' = 0b00110000 => 8 zeros smushed together is 0b0011000000110000001100000011000000110000001100000011000000110000 = 0x3030303030303030
    movabs rax, 0x3030303030303030 # the immediate is 64-bit, so it cannot be put in memory right away
    mov QWORD PTR[rsp], rax
    mov QWORD PTR[rsp + 8], rax
    mov QWORD PTR[rsp + 16], rax
    mov QWORD PTR[rsp + 24], rax
    # rdi - number to print
    mov rsi, rsp # rsi <-- address of the buffer for the number
    call integer_to_buffer # rax <-- length of the buffer
    # buffer starts at [rsp - rax + 24] and ends at [rsp + 24]; rax is its length
    # now we need to add a dot and maybe some digits in the beginning of the buffer (while there are less than 8 digits in total)

    mov r10, 25 # r10 <-- 25
    sub r10, rax # r10 <-- 25 - rax
    
    mov dl, [rsp + r10] # either the highest digit or the negative sign
    mov r8, 8 # minimum total length of the buffer for positive number (decimal dot is not counted)
    mov r9, 9 # minimum total length of the buffer for negative number (decimal dot is not counted)
    cmp dl, '-'
    cmove r8, r9
    # r8 is now the minimum total length of the buffer (decimal dot is not counted)
    cmp rax, r8
    jae .add_decimal_dot
    # extend the buffer to r8 digits maybe moving the negative sign (as the buffer was filled with zeros, all new digits will be zeros automatically)
    cmp dl, '-'
    jne .positive_number
    mov BYTE PTR [rsp + r10], '0' # remove the negative sign
    mov BYTE PTR [rsp + 16], '-' # add the negative sign in the new position
    .positive_number:
    mov rax, r8 # update the buffer length
    
.add_decimal_dot:
    mov rdi, QWORD PTR [rsp + 18]
    mov QWORD PTR [rsp + 19], rdi # move 7 lowest digits (and one "rubbish" byte) one symbol lower
    mov BYTE PTR [rsp + 18], '.' # add the dot at the previous position of the 7-th lowest digit
    add rax, 1 # adjust the length of the buffer

    mov rcx, rax # rcx <-- length
    neg rcx # rcx <-- (-length)
    mov rdx, rax # length
    mov rax, 1 # sys_write
    mov rdi, .outstream[rip] # outstream
    lea rsi, [rsp + rcx + 26] # buffer (starts at [rsp + 25 - (length - 1)])
    syscall

    mov rax, 0 # return value
	leave # restore stack and frame pointers
    ret # return