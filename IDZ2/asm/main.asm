    .intel_syntax noprefix


	.section .data
	.globl .instream
.instream:
	.quad 0 # stdin
	.globl .outstream
.outstream:
	.quad 1 # stdout

	.section .rodata
.error_cli:
	.quad 43 # length
	.string	"Incorrect command line arguments provided!"
.error_input:
	.quad 30 # length
	.string	"Failed to open an input file!"
.error_output:
	.quad 31 # length
	.string	"Failed to open an output file!"
    
.time_output_template_string_part_1:
	.quad 16 # length
	.string	"\nCPU time used: "
.time_output_template_string_part_2:
	.quad 2 # length
	.string	"ns"


    .section .text
    .globl	_start
_start:
	push r12 # save r12 on the stack
	push r13 # save r13 on the stack
	push rbx # save rbx on the stack
	push rbp # save frame pointer
	mov	rbp, rsp # save stack pointer

	mov r12, QWORD PTR [rbp + 4 * 8] # put first function argument (int argc) - into a callee-saved register r12
	lea r13, QWORD PTR [rbp + 5 * 8] # put second function argument (char** argv) - into a callee-saved register r13


	cmp r12, 2 # argc v 2
	jb .error_cli_print # if (argc < 2)
	mov rcx, 2 # rcx <-- output_flag_argv_index = 2
	mov rsi, 0 # rsi <-- array_read_mode = 0
.parse_input:
	mov rax, [r13 + 8] # argv[1]
	mov al, BYTE PTR [rax] # al <-- argv[1][0]
	cmp al, '1' # argv[1][0] v '1'
	je .input_from_file # if (argv[1][0] == '1') - input from file
	cmp al, '2' # argv[1][0] v '2'
	je .input_random # if (argv[1][0] == '2') - random input
	jmp .parse_output
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
	jmp .parse_output
.input_random:
	mov rsi, 1 # rsi <-- array_read_mode = 1

.parse_output:
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
	mov r12, rsi # rsi may be changed by freopen, so it has to be saved in r12, which is callee-saved and not needed anymore
	mov rax, 2 # sys_open
	mov rdi, [r13 + rcx * 8 + 8] # filename
	mov rsi, 65
	mov rdx, 00700
	syscall
	cmp rax, 0
	jl .error_output_print # if (!freopen(argv[output_flag_argv_index++], "r", stdin))
	mov QWORD PTR .outstream[rip], rax
	mov rsi, r12 # restore rsi
.output_parse_complete:


	.comm buffer, 1073741825, 32 # static unsigned char string[MAX_INPUT_LENGTH + 1];
    
	lea	rdi, buffer[rip] # rdi <-- address of string - first function argument
	# rsi - second function argument - is already in place
	call input # input(string, read_mode)
    mov r12, rax # r12 <-- length
    cmp r12, 1073741824 # length v MAX_INPUT_LENGTH
    ja .main_return # if (length > MAX_INPUT_LENGTH) goto return


    sub rsp, 16 # allocate some memory for clock
	mov rax, 228 # sys_clock_gettime
	mov rdi, 0 # system clock
	mov rsi, rsp # address
	syscall
	mov r13, QWORD PTR [rsp] # seconds
	imul r13, r13, 1000000000 # r13 <-- seconds in nanoseconds
	add r13, QWORD PTR [rsp + 8] # nanoseconds

    lea	rdi, buffer[rip] # rdi <-- address of string - first function argument
    mov	rsi, r12 # rsi <-- return value of input - second function argument
    call solve # solve(string, length)
    # rdx:rax - return value
    mov rbx, rdx # save rdx in a calle-saved register rbx
    mov r12, rax # save rax in a calle-saved register r12
    
    
	mov rax, 228 # sys_clock_gettime
	mov rdi, 0 # system clock
	mov rsi, rsp # address
	syscall
	mov rax, QWORD PTR [rsp] # seconds
	imul rax, rax, 1000000000 # rax <-- seconds in nanoseconds
	add rax, QWORD PTR [rsp + 8] # nanoseconds
	sub r13, rax
	neg r13
    # r13 - result of time measurement (cpu_time_used)
    # rbx - answer.letters
    # r12 - answer.numbers


    mov	rdi, r12 # rdi <-- answer.numbers - first function argument
    mov	rsi, rbx # rsi <-- answer.letters - second function argument
    call output # output(answer)
    
	mov rax, 1 # sys_write
	mov rdi, QWORD PTR .outstream[rip] # outstream
	lea rsi, .time_output_template_string_part_1[rip + 8] # rdi <-- address of "\nCPU time used: "
	mov rdx, QWORD PTR .time_output_template_string_part_1[rip] # 16 - length of string
	syscall
	mov rdi, r13 # cpu_time_used
	call printf
	mov rax, 1 # sys_write
	mov rdi, QWORD PTR .outstream[rip] # outstream
	lea rsi, .time_output_template_string_part_2[rip + 8] # rdi <-- address of "ns"
	mov rdx, QWORD PTR .time_output_template_string_part_2[rip] # 2 - length of string
	syscall


.main_return:
	mov rax, 3 # sys_close
	mov rdi, QWORD PTR .instream[rip] # instream
	syscall
	mov rax, 3 # sys_close
	mov rdi, QWORD PTR .outstream[rip] # outstream
	syscall

	leave # restore stack and frame pointers
	pop rbx # restore the value of rbx
	pop r13 # restore the value of r13
	pop r12 # restore the value of r12

	mov rax, 60 # sys_exit
	mov rdi, 0 # 0 - return value
	syscall
    

.error_cli_print:
	mov rax, 1 # sys_write
	mov rdi, QWORD PTR .outstream[rip] # outstream
	lea rsi, .error_cli[rip + 8] # rsi <-- address of "Incorrect command line arguments provided!"
	mov rdx, QWORD PTR .error_cli[rip] # 43 - length of string
	syscall
	jmp .main_return
.error_input_print:
	mov rax, 1 # sys_write
	mov rdi, QWORD PTR .outstream[rip] # outstream
	lea rsi, .error_input[rip + 8] # rsi <-- address of "Failed to open an input file!\n"
	mov rdx, QWORD PTR .error_input[rip] # 30 - length of string
	syscall
	jmp .main_return
.error_output_print:
	mov rax, 1 # sys_write
	mov rdi, QWORD PTR .outstream[rip] # outstream
	lea rsi, .error_output[rip + 8] # rsi <-- address of "Failed to open an output file!\n"
	mov rdx, QWORD PTR .error_output[rip] # 31 - length of string
	syscall
	jmp .main_return
