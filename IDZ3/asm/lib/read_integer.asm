    .intel_syntax noprefix


    .section .text
    .globl read_integer
read_integer: # reads an integer from .instream and returns it with some metadata
	push r12 # save r12 on the stack
	push r13 # save r13 on the stack
	push r14 # save r14 on the stack
	push rbp # save frame pointer
	mov	rbp, rsp # save stack pointer

    mov r12, 0 # r12 will be the number
    mov r13, 1 # r13 is a +/- flag
    mov r14, 1 # 10 ^ len(number)

    call read_symbol # get first symbol
    mov r9, rax # save the symbol read
    mov r8, -1 # just -1
    cmp al, '-'
    cmove r13, r8 # the sign is negative
    je .parse_digit
    cmp al, '+' # the sign is explicitly positive
    je .parse_digit
    # the sign is implicitly positive, and al is the first digit
    sub al, '0' # convert symbol to number
    cmp al, 9 # check if it is valid
    ja .return # unsigned compare
    movzx r12, al # write r12 supposing we have read the entire number
    imul r14, r14, 10
    
.parse_digit: # .sign_parsed
    call read_symbol # get next symbol
    mov r9, rax # save the symbol read
    sub rax, '0' # convert symbol to number
    cmp al, 9 # check if it is valid
    ja .return # unsigned compare
    # new_number = (old_number * 10) + new_digit
    imul r14, r14, 10
    imul r12, r12, 10 # (old_number * 10)
    add r12, rax # + new_digit
    # if the number has more than 17 digits, it is either too big (thus, incorrect input)
    # or the remaining part is too small and can be ignored (it will not affect the value more than the allowed margin of error)
    movabs rcx, 100000000000000000
    cmp r14, rcx
    jb .parse_digit

.return:
    mov rdx, r13 # rdx = sign
    mov rax, r12 # rax = number
    mov r8, r14
    # return value is (r8, r9, rdx, rax) = (10 ^ len(number), first_invalid_symbol, sign, number)
	leave # restore stack and frame pointers
    pop r14 # restore the value of r14
    pop r13 # restore the value of r13
    pop r12 # restore the value of r12
    ret