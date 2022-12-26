    .intel_syntax noprefix


    .section .rodata
.template_part_1:
	.quad 9 # length
	.string	"Numbers: "
.template_part_2:
	.quad 11 # length
	.string	", Letters: "


    .section .text
    .globl	output
output:
    push rsi # save rsi = answer.letters on the stack
    push rdi # save rdi = answer.numbers on the stack

	mov rax, 1 # sys_write
	mov rdi, QWORD PTR .outstream[rip] # outstream
	lea rsi, .template_part_1[rip + 8] # rsi <-- address of "Numbers: "
	mov rdx, QWORD PTR .template_part_1[rip] # 9 - length of "Numbers: "
	syscall

    pop rdi # rdi <-- answer.numbers
    call printf
    
	mov rax, 1 # sys_write
	mov rdi, QWORD PTR .outstream[rip] # outstream
	lea rsi, .template_part_2[rip + 8] # rsi <-- address of ", Letters: "
	mov rdx, QWORD PTR .template_part_2[rip] # 9 - length of ", Letters: "
	syscall

    pop rdi # rdi <-- answer.letters
    call printf

	ret # return
