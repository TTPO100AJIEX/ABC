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
    mov al, BYTE PTR [rsp] # al is either a sign of a number, or the first digit

    mov r8, -1 # just a value of -1
    cmp al, '-'
    cmove r13, r8 # the sign is negative
    je .sign_parsed
    cmp al, '+' # the sign is explicitly positive
    je .sign_parsed
    # the sign is implicitly positive, and al is the first digit
    sub al, '0' # convert symbol to number
    cmp al, 9 # check if it is valid
    ja .return # unsigned compare
    movzx r12, al # write r12 supposing we have read the entire number

.sign_parsed: # .parse_digit
    mov rax, 0 # sys_read
    mov rdi, QWORD PTR .instream[rip] # instream
    mov rsi, rsp # buffer
    mov rdx, 1 # count
    syscall
    cmp rax, 0 # nothing has been read
    je .return
    movzx rax, BYTE PTR [rsp] # rax is a digit of a number
    sub rax, '0' # convert symbol to number
    cmp al, 9 # check if it is valid
    ja .return # unsigned compare
    # new_number = (old_number * 10) + new_digit
    imul r12, r12, 10 # (old_number * 10)
    add r12, rax # + new_digit
    jmp .sign_parsed # .parse_digit
.return:
    imul r12, r13 # multiply by the sign
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
    mov rax, rdi
    mov r8, 10 # just number 10
    mov rcx, 0 # rcx - length of the buffer
    mov r9, 0 # the sign of the number is positive
    cmp rax, 0 # rax v 0
    jge .positive_number # rax >= 0 => the sign is already correct
    mov r9, 1 # the sign is negative
    neg rax # rax = -rax
.positive_number:
    mov rdx, 0 # rdx:rax (rax) - number to print
    div r8 # RAX := Quotient, RDX := Remainder
    add dl, '0' # convert number to character
    mov BYTE PTR [rsp + rcx], dl # put digit into the buffer in reversed order
    inc rcx # next digit
    cmp rax, 0 # number v 0
    ja .positive_number # number > 0 => there are still digits to print
    # the loop works at least once, so 0 is printed correctly: do { } while (number <= 0);

    # print
    cmp r9, 1 # sign
    jnz .positive_sign # r9 != 1 => sign is positive
    mov BYTE PTR [rsp + rcx], '-' # add the negative sign to the number
    inc rcx
.positive_sign:
    mov rdx, rcx # rdx = rcx = length of the actual number in the buffer
    # the digits were put in the reverse order, so we have to flip the buffer
    shr rcx, 1 # rcx /= 2
    mov r8, rdx # r8 = rdx
    sub r8, rcx # r8 = rdx - rcx
.reverse_loop_start:
    cmp rcx, 0 # loop through first length / 2 digits
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
    mov rax, 1 # sys_write
    mov rdi, QWORD PTR .outstream[rip] # outstream
    mov rsi, rsp # buffer
    syscall
    mov rax, 0 # return value
	leave # restore stack and frame pointers
	ret # return
