    .intel_syntax noprefix
	
	.section .rodata
.error_cli:
	.quad 43 # length
	.string	"Incorrect command line arguments provided!\n"
.error_input:
	.quad 30 # length
	.string	"Failed to open an input file!\n"
.error_output:
	.quad 31 # length
	.string	"Failed to open an output file!\n"


.time_output_template_string_part_1:
	.quad 17
	.string	"\n\nCPU time used: "
.time_output_template_string_part_2:
	.quad 3
	.string	"ns\n"

	.section .data
	.globl .instream
.instream:
	.quad 0
	.globl .outstream
.outstream:
	.quad 1
	
	.section .bss
	.comm A, 268435440, 32  # переменная A - массив 8-байтных элементов размера 33554428 (268435440 байт)
	.comm B, 268435440, 32  # переменная B - массив 8-байтных элементов размера 33554428 (268435440 байт)

	

    .section .text
    .globl	_start
_start:
	push r12 # save r12 on the stack
	push r13 # save r13 on the stack
	push rbx # save rbx on the stack
	push rbp # save frame pointer
	mov	rbp, rsp # save stack pointer
	sub rsp, 16

	mov r12, QWORD PTR [rbp + 4 * 8] # put rdi - first function argument (int argc) - into a callee-saved register r12
	lea r13, QWORD PTR [rbp + 5 * 8] # put rsi (char** argv) - second function argument - into a callee-saved register r13


	cmp r12, 2 # argc v 2
	jb .error_cli_print # if (argc < 2)
	mov rcx, 2 # rcx <-- output_flag_argv_index = 2
	mov rdx, 0 # rdx <-- array_read_mode = 0
# PARSE INPUT MODE
	mov rax, [r13 + 8] # argv[1]
	mov al, BYTE PTR [rax] # al <-- argv[1][0]
	cmp al, '1' # argv[1][0] v '1'
	je .input_from_file # if (argv[1][0] == '1') - input from file
	cmp al, '2' # argv[1][0] v '2'
	je .input_random # if (argv[1][0] == '2') - random input
	jmp .input_parse_complete
.input_from_file:
	cmp r12, 3 # argc v 3
	jb .error_cli_print # if (argc < 3)
	# open file
	mov rax, 2 # sys_open
	mov rdi, [r13 + 2 * 8] # filename
	mov rsi, 0
	mov rdx, 00700
	syscall
	cmp rax, 0
	jl .error_input_print # if (!freopen(argv[output_flag_argv_index++], "r", stdin))
	mov QWORD PTR .instream[rip], rax

	mov rcx, 3 # rcx <-- output_flag_argv_index = 3 ~ output_flag_argv_index++
	mov rdx, 0 # rdx <-- array_read_mode = 0
	jmp .input_parse_complete
.input_random:
	mov rdx, 1 # rdx <-- array_read_mode = 1
.input_parse_complete:

# PARSE OUTPUT MODE
	inc rcx # rcx <-- output_flag_argv_index + 1
	cmp r12, rcx # argc v output_flag_argv_index + 1
	jb .error_cli_print # if (argc < output_flag_argv_index + 1)
	dec rcx # rcx <-- output_flag_argv_index
	mov rax, [r13 + 8 * rcx] # argv[2] or argv[3]
	mov al, BYTE PTR [rax] # al <-- argv[output_flag_argv_index][0]
	cmp al, '1' # argv[output_flag_argv_index][0] v '1'
	je .output_to_file # if (argv[output_flag_argv_index][0] == '1') - output to file
	jmp .output_parse_complete
.output_to_file:
	add rcx, 2 # rcx <-- output_flag_argv_index + 2
	cmp r12, rcx # argc v output_flag_argv_index + 2
	jb .error_cli_print # if (argc < output_flag_argv_index + 2)
	sub rcx, 2 # rcx <-- output_flag_argv_index
	# open file
	mov r12, rdx # rdx may be changed by freopen, so it has to be saved in r12, which is callee-saved and not needed anymore
	mov rax, 2 # sys_open
	mov rdi, [r13 + rcx * 8 + 8] # filename
	mov rsi, 65
	mov rdx, 00700
	syscall
	cmp rax, 0
	jl .error_output_print # if (!freopen(argv[output_flag_argv_index++], "r", stdin))
	mov QWORD PTR .outstream[rip], rax
	mov rdx, r12 # restore rdx
.output_parse_complete:

	lea	rdi, A[rip] # rdi <-- address of array A - first function argument
	mov	esi, 33554428 # esi ~ rsi <-- MAX_INPUT_LENGTH - second function argument
	# rdx - third function argument - is already in place
	call input # input(A, MAX_INPUT_LENGTH)

	mov r13, rax # save return value of input in r13
	mov rax, 228 # sys_clock_gettime
	mov rdi, 0 # system clock
	mov rsi, rsp
	syscall
	mov r12, QWORD PTR [rsp] # seconds
	imul r12, r12, 1000000000 # r12 <-- seconds in nanoseconds
	add r12, QWORD PTR [rsp + 8] # nanoseconds


	mov rbx, 0 # int i = 0
	.solve_loop_start:
		lea	rdi, A[rip] # rdi <-- address of array A - first function argument
		mov	rsi, r13 # rsi <-- return value of input(A, MAX_INPUT_LENGTH) - second function argument
		lea	rdx, B[rip] # rdx <-- address of array B - third function argument
		call solve # solve(A, input(A, MAX_INPUT_LENGTH), B)
	inc rbx # i++
	cmp rbx, 10 # i v 10
	jne .solve_loop_start # if (i < 10) - continue the loop


	mov	r13, rax # save return value of solve in r13
	mov rax, 228 # sys_clock_gettime
	mov rdi, 0 # system clock
	mov rsi, rsp
	syscall
	mov rdi, QWORD PTR [rsp] # seconds
	imul rdi, rdi, 1000000000 # rax <-- seconds in nanoseconds
	add rdi, QWORD PTR [rsp + 8] # nanoseconds
	sub r12, rdi
	neg r12


	lea	rdi, B[rip] # rdi <-- address of array B - first function argument
	mov	rsi, r13 # rsi <-- return value of solve(...) - second function argument
	call output # output(B, solve(A, input(A, MAX_INPUT_LENGTH), B));

	
	mov rax, 1 # sys_write
	mov rdi, QWORD PTR .outstream[rip] # outstream
	lea rsi, .time_output_template_string_part_1[rip + 8] # rdi <-- address of "\n\nCPU time used: "
	mov rdx, QWORD PTR .time_output_template_string_part_1[rip] # 17 - length of string
	syscall
	mov rdi, r12
	call printf
	mov rax, 1 # sys_write
	mov rdi, QWORD PTR .outstream[rip] # outstream
	lea rsi, .time_output_template_string_part_2[rip + 8] # rdi <-- address of "\n\nCPU time used: "
	mov rdx, QWORD PTR .time_output_template_string_part_2[rip] # 17 - length of string
	syscall


.main_return:
	mov rax, 3 # sys_close
	mov rdi, QWORD PTR .instream[rip] # instream
	syscall
	mov rax, 3 # sys_close
	mov rdi, QWORD PTR .outstream[rip] # outstream
	syscall

	mov	rax, 0 # 0 - return value
	leave # restore stack and frame pointers
	pop rbx # restore the value of rbx
	pop r13 # restore the value of r13
	pop r12 # restore the value of r12

	mov rax, 60 # sys_exit
	mov rdi, 0
	syscall

.error_cli_print:
	mov rax, 1 # sys_write
	mov rdi, QWORD PTR .outstream[rip] # outstream
	lea rsi, .error_cli[rip + 8] # rdi <-- address of "Incorrect command line arguments provided!"
	mov rdx, QWORD PTR .error_cli[rip] # 43 - length of string
	syscall
	jmp .main_return
.error_input_print:
	mov rax, 1 # sys_write
	mov rdi, QWORD PTR .outstream[rip] # outstream
	lea rsi, .error_input[rip + 8] # rdi <-- address of "Failed to open an input file!\n"
	mov rdx, QWORD PTR .error_input[rip] # 30 - length of string
	syscall
	jmp .main_return
.error_output_print:
	mov rax, 1 # sys_write
	mov rdi, QWORD PTR .outstream[rip] # outstream
	lea rsi, .error_output[rip + 8] # rdi <-- address of "Failed to open an output file!\n"
	mov rdx, QWORD PTR .error_output[rip] # 31 - length of string
	syscall
	jmp .main_return
