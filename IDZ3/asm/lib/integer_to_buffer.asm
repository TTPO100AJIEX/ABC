    .intel_syntax noprefix


    .section .text
    .globl integer_to_buffer
integer_to_buffer: # transforms integer in rdi into a string buffer of length 24 pointed by rsi, and returns the length of the used part
    mov rax, rdi
    mov r8, 10 # just number 10
    mov rcx, 24 # (24 - rcx) is the length of the buffer
    mov r9, 0 # the sign of the number is positive
    cmp rax, 0 # rax v 0
    jge .positive_number # rax >= 0 => the sign is already correct
    mov r9, 1 # the sign is negative
    neg rax # rax = -rax
.positive_number:
    mov rdx, 0 # rdx:rax (rax) - number to print
    div r8 # RAX := Quotient, RDX := Remainder
    add dl, '0' # convert number to character
    mov [rsi + rcx], dl # put digit into the end of the buffer
    sub rcx, 1 # next digit
    cmp rax, 0 # number v 0
    ja .positive_number # number > 0 => there are still digits to print
    # the loop works at least once, so 0 is printed correctly: do { } while (number > 0);
    
    # print
    cmp r9, 1 # sign
    jnz .positive_sign # r9 != 1 => sign is positive
    mov BYTE PTR [rsi + rcx], '-' # add the negative sign to the number
    sub rcx, 1
.positive_sign:

    mov rax, 24 # rax <-- 24
    sub rax, rcx # rax <-- (24 - rcx) = length of the buffer
    ret