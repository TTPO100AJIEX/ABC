    .intel_syntax noprefix


    .section .rodata
.too_long_array_error:
	.quad 22 # length
	.string	"The input is too long!"
.not_ascii_error:
	.quad 33 # length
	.string	"Non-ASCII characters encountered!"


    .section .text
    .globl	input
input:
	push r12 # save r12 on the stack
    push r13 # save r13 on the stack
	push rbp # save frame pointer
	mov	rbp, rsp # save stack pointer
    
    mov r12, rdi # put rdi - first function argument (unsigned char* buffer) - into a callee-saved register r12
    # rsi (unsigned int mode) is the second function argument
    cmp rsi, 1 # mode v 1
    jz .input_random
# .input_file:
    # sys_read may not read the entire input if it is buffered (e.g. stdin). We need to read until the input was ended by EOF, not newline
    mov r13, 0 # uint64_t length - the total amount of symbols read
    .read_line:
        mov rax, 0 # sys_read
        mov rdi, QWORD PTR .instream[rip] # instream
        lea rsi, [r12 + r13] # buffer
        mov rdx, 1073741825 # MAX_LENGTH + 1
        sub rdx, r13 # MAX_LENGTH - already_read
        syscall
        cmp rax, 0
        je .read_line_finish # no new symbols have been read, the buffer has only been flushed
        
        add r13, rax # increase the length to account for new bytes read
        cmp BYTE PTR [r12 + r13 - 1], '\n' # check last symbol read
        je .read_line # the buffer has been flushed by newline => continue
    .read_line_finish:

    cmp r13, 1073741824
    ja .too_long_array # the length exceeded the MAX_INPUT_LENGTH, error
    mov rcx, 0 # uint64_t i = 0
.check_ascii:
    cmp rcx, r13 # rcx 
    jae .return # i >= length - stop
    cmp BYTE PTR [r12 + rcx], 127 # buffer[i] v 127
    ja .not_ascii # if (buffer[i] > 127) => error
    inc rcx # i++
    jmp .check_ascii # continue the loop

.input_random:
	call scanf # read length: rax <-- length - return value
    cmp rax, 1073741824 # length v MAX_INPUT_LENGTH
    ja .too_long_array # if (length > MAX_INPUT_LENGTH) - error
    push r14 # save r14 on the stack
    mov r13, rax # r13 <-- length

    # sys_getrandom may not be able to return all bytes in one call
    mov r14, 0 # bytes filled
    .fill_string:
        mov rax, 318 # sys_getrandom
        lea rdi, [r12 + r14] # buffer
        mov rsi, r13 # count
        sub rsi, r14 # count - already_generated
        mov rdx, 0 # flags
        syscall # rax <-- number of bytes generated - return value
        add r14, rax

        cmp r14, r13 # already_generated v length
        jb .fill_string # already_generated < length => continue generating
        
    
    mov rcx, 0
    .fix_ascii:
        cmp rcx, r13 # rcx v length
        jae .fix_ascii_finish # rcx >= length - stop
        and	BYTE PTR [r12 + rcx], 127 # symbol = symbol & 127 ~ symbol % 128
        inc rcx # next symbol
        jmp .fix_ascii # continue the loop
    .fix_ascii_finish:

    pop r14 # save r14 on the stack

.return:
    mov rax, r13 # rax <-- length
	leave # restore stack and frame pointers
    pop r13 # save r13 on the stack
	pop r12 # restore the value of r12
	ret # return

.too_long_array:
	mov rax, 1 # sys_write
	mov rdi, QWORD PTR .outstream[rip] # outstream
	lea rsi, .too_long_array_error[rip + 8] # rsi <-- address of string
	mov rdx, QWORD PTR .too_long_array_error[rip] # length of string
	syscall
    mov r13, 1073741825
    jmp .return
.not_ascii:
	mov rax, 1 # sys_write
	mov rdi, QWORD PTR .outstream[rip] # outstream
	lea rsi, .not_ascii_error[rip + 8] # rsi <-- address of string
	mov rdx, QWORD PTR .not_ascii_error[rip] # length of string
	syscall
    mov r13, 1073741825
    jmp .return
