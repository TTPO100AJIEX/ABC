    .intel_syntax noprefix


    .section .text
    .globl read_double
read_double: # reads a double-precision floating point number from .instream and returns it
	push r12 # save r12 on the stack
	push r13 # save r13 on the stack
	push rbp # save frame pointer
	mov	rbp, rsp # save stack pointer

    # we are trying to read a number x.y; idea:
    # read one symbol at a time until "." and calculate x
    # if a symbol is outside of ['0', '9'] range and not a ".", return x and stop the algorithm
    # read one symbol at a time until any symbol outside of ['0', '9'] is encountered and calculate y
    # at the same time calculate 10 ^ len(y)
    # answer is: x.y = x + y / (10 ^ len(y))

    # r12 ~ x; rax ~ y; r8 ~ length

    call read_integer # (r8, r9, rdx, rax) = (10 ^ len(number), first_invalid_symbol, sign, number)
    mov r12, rax # r12 <-- x
    mov r13, rdx # r13 <-- sign(x)
    mov rax, 0 # there is no decimal part
    mov r8, 1 # there is no decimal part
    cmp r9, '.' # first_invalid_symbol v '.'
    jnz .return

    call read_integer # (r8, r9, rdx, rax) = (10 ^ len(number), first_invalid_symbol, sign, number)
    # rax = y; rdx = sign(y); r8 = 10^len(y)
    mov rcx, 0 # default for rax when there is no decimal part 
    mov r10, 1 # default for r8 when there is no decimal part 
    cmp rdx, 0
    cmovl rax, rcx # y cannot be negative. Make it 0 if it is
    cmovl r8, r10 # y cannot be negative. Make it 0 if it is

.return:
    # apply the sign from r13
    imul r12, r13 # x *= sign
    imul rax, r13 # y *= sign
    cvtsi2sd xmm0, r12 # x
    cvtsi2sd xmm1, rax # y
    cvtsi2sd xmm2, r8 # 10^len(y)
    divsd xmm1, xmm2 # y / 10^len(y) = 0.y
    addsd xmm0, xmm1 # x + 0.y = x.y
	leave # restore stack and frame pointers
    pop r13 # restore the value of r13
    pop r12 # restore the value of r12
    ret
