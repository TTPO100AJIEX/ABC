    .intel_syntax noprefix


    .section .text
    .globl	solve
solve:
    mov rax, 0 # res.numbers
    mov rdx, 0 # res.letters
    # rdi = const unsigned char* buffer; rsi = const uint64_t length

    mov rcx, 0 # uint64_t i = 0
.loop:
    cmp rcx, rsi # i v length
    jae .return # if (i >= length) - stop loop
    mov r8b, BYTE PTR [rdi + rcx] # r8b <-- buffer[i]
    inc rcx # i++
.check_if_number:
    cmp r8b, '0' # buffer[i] v '0'
    jb .check_if_small_letter # buffer[i] < '0' => it is not a number
    cmp r8b, '9' # buffer[i] v '9'
    ja .check_if_small_letter # buffer[i] > '9' => it is not a number
    inc rax # it is a number, count it
    jmp .loop # it if is a number, it is not a letter => go to the next iteration
.check_if_small_letter:
    cmp r8b, 'a' # buffer[i] v 'a'
    jb .check_if_capital_letter # buffer[i] < 'a' => it is not a small letter
    cmp r8b, 'z' # buffer[i] v 'z'
    ja .check_if_capital_letter # buffer[i] > 'z' => it is not a small letter
    inc rdx # it is a letter, count it
    jmp .loop # go to the next iteration
.check_if_capital_letter:
    cmp r8b, 'A' # buffer[i] v 'A'
    jb .loop # buffer[i] < 'A' => it is not a letter, go to the next iteration
    cmp r8b, 'Z' # buffer[i] v 'Z'
    ja .loop # buffer[i] > 'Z' => it is not a letter, go to the next iteration
    inc rdx # it is a letter, count it
    jmp .loop # go to the next iteration to check the next symbol

.return:
	ret # return
