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
	.string	"Incorrect command line arguments provided!\n"
.error_input:
	.quad 30 # length
	.string	"Failed to open an input file!\n"
.error_output:
	.quad 31 # length
	.string	"Failed to open an output file!\n"
.error_input_incorrect:
	.quad 26 # length
	.string	"Incorrect input provided!\n"
    
.time_output_template_string_part_1:
	.quad 15 # length
	.string	"CPU time used: "
.time_output_template_string_part_2:
	.quad 2 # length
	.string	"ns"
    
.fabs_mask:
	.long -1
	.long 2147483647
	.long 0
	.long 0

    .section .text
    .globl	_start
_start:
	push r12 # save r12 on the stack
	push r13 # save r13 on the stack
	push rbx # save rbx on the stack
	push rbp # save frame pointer
	mov	rbp, rsp # save stack pointer

	mov r12, [rbp + 4 * 8] # put first function argument (int argc) - into a callee-saved register r12
	lea r13, [rbp + 5 * 8] # put second function argument (char** argv) - into a callee-saved register r13

    lea rdi, .error_cli[rip] # code of the possible error
	cmp r12, 4 # argc v 4
	jb .throw_error # if (argc < 4)
	mov rcx, 3 # rcx <-- output_flag_argv_index = 3
    mov rbx, 0 # rbx <-- random_input = false
    
.parse_input:
	mov rax, [r13 + 16] # argv[2]
	mov al, [rax] # al <-- argv[2][0]
	cmp al, '1' # argv[2][0] v '1'
	je .input_from_file # if (argv[2][0] == '1') - input from file
    mov rdx, 1 # rdx <-- 1
	cmp al, '2' # argv[2][0] v '2'
	cmove rbx, rdx # if (argv[2][0] == '2') => random_input = true;
	jmp .parse_output
.input_from_file:
    lea rdi, .error_cli[rip] # code of the possible error
	cmp r12, 5 # argc v 5
	jb .throw_error # if (argc < 5)
	# open file
	mov rax, 2 # sys_open
	mov rdi, [r13 + 3 * 8] # filename
	mov rsi, 0
	mov rdx, 00700
	syscall
    lea rdi, .error_input[rip] # code of the possible error
	cmp rax, 0
	jl .throw_error # if (!freopen(argv[output_flag_argv_index++], "r", stdin))
	mov .instream[rip], rax
	mov rcx, 4 # rcx <-- output_flag_argv_index = 4 ~ output_flag_argv_index++

.parse_output:
	add rcx, 1 # rcx <-- output_flag_argv_index + 1
    lea rdi, .error_cli[rip] # code of the possible error
	cmp r12, rcx # argc v output_flag_argv_index + 1
	jb .throw_error # if (argc < output_flag_argv_index + 1)
	sub rcx, 1 # rcx <-- output_flag_argv_index

	mov rax, [r13 + 8 * rcx] # argv[3] or argv[4]
	mov al, [rax] # al <-- argv[output_flag_argv_index][0]
	cmp al, '1' # argv[output_flag_argv_index][0] v '1'
	je .output_to_file # if (argv[output_flag_argv_index][0] == '1') - output to file
    mov r12, 1 # r12 <-- do_write = true
    mov rdx, 0 # rdx <-- 0
	cmp al, '2' # argv[output_flag_argv_index][0] v '2'
	cmove r12, rdx # if (argv[output_flag_argv_index][0] == '2') => do_write = false;
	jmp .output_parse_complete
.output_to_file:
	add rcx, 2 # rcx <-- output_flag_argv_index + 2
    lea rdi, .error_cli[rip] # code of the possible error
	cmp r12, rcx # argc v output_flag_argv_index + 2
	jb .throw_error # if (argc < output_flag_argv_index + 2)
	sub rcx, 2 # rcx <-- output_flag_argv_index
    mov r12, 1 # r12 <-- do_write = true
	# open file
    mov rax, 2 # sys_open
	mov rdi, [r13 + rcx * 8 + 8] # filename
	mov rsi, 65
	mov rdx, 00700
	syscall
    lea rdi, .error_output[rip] # code of the possible error
	cmp rax, 0
	jl .throw_error # if (!freopen(argv[output_flag_argv_index + 1], "w", stdout))
	mov .outstream[rip], rax

.output_parse_complete:
    # bool loop = (argv[1][0] == '1'); ~ does not exist yet
    # bool random_input = false; ~ rbx
    # bool do_write = true; ~ r12

    mov rdi, rbx # rdi <-- random_input - first function argument
    call input

    mov rax, 1
    cvtsi2sd xmm1, rax # xmm1 <-- 1
    mov rax, -1
    cvtsi2sd xmm2, rax # xmm2 <-- -1

    lea rdi, .error_input_incorrect[rip] # code of the possible error
    comisd xmm0, xmm1
    ja .throw_error # if (x > 1) => input is incorrect
    comisd xmm0, xmm2
    jb .throw_error # if (x < -1) => input is incorrect

    # (loop ? 1e8 : 1) ~ (argv[1][0] == '1' ? 1e8 : 1)
    mov rbx, 1 # rbx <-- 1 ~ unsigned int loop = 1
    mov rcx, 100000000 # rcx <-- 1e8
    mov rax, [r13 + 8] # argv[1]
	mov al, [rax] # al <-- argv[1][0]
    cmp al, '1'
    cmove rbx, rcx # if (argv[1][0] == '1') loop = 1e8

    sub rsp, 40 # allocate some memory on the stack to save the value of do_write and the values of clocks
    mov [rsp + 32], r12 # save the value of r12 (do_write) on the stack to be able to use the register
	movq r12, xmm0 # save the value of x in r12 register
	
    mov rax, 228 # sys_clock_gettime
    mov rdi, 0 # system clock
    lea rsi, [rsp] # address
    syscall # (QWORD PTR [rsp], QWORD PTR [rsp + 8]) <-- (seconds, nanoseconds)

    mov r13, 0 # uint64_t i = 0
    .loop:
		movq xmm0, r12 # restore the value of x from r12
        call solve
        add r13, 1
        # comparison can be placed at the end of the loop, as it is executed at least once
        cmp r13, rbx # i v loop
        jb .loop
	movq r12, xmm0 # save the value of answer in the r12 register

    mov rax, 228 # sys_clock_gettime
    mov rdi, 0 # system clock
    lea rsi, [rsp + 16] # address
    syscall # (QWORD PTR [rsp + 16], QWORD PTR [rsp + 24]) <-- (seconds, nanoseconds)

    mov rax, [rsp] # rax <-- start.seconds
    imul rax, rax, 1000000000 # rax <-- start.seconds in nanoseconds
    add rax, [rsp + 8] # rax <-- start.nanoseconds
    
    mov r13, [rsp + 16] # r13 <-- end.seconds
    imul r13, r13, 1000000000 # r13 <-- end.seconds in nanoseconds
    add r13, [rsp + 24] # r13 <-- end.nanoseconds
    sub r13, rax # r13 <-- execution CPU time in nanoseconds

	cmp QWORD PTR [rsp + 32], 0 # do_write v 0
	je .skip_output
		movq xmm0, r12 # restore the value of answer from r12 register
		call output
	.skip_output:
    
	mov rax, 1 # sys_write
	mov rdi, .outstream[rip] # rdi <-- outstream
    lea rsi, .time_output_template_string_part_1[rip + 8] # rsi <-- address of "\nCPU time used: "
    mov rdx, .time_output_template_string_part_1[rip] # rdx <-- 16 - length of string
	syscall # call the kernel

    mov rdi, r13
    call print_integer
    
	mov rax, 1 # sys_write
	mov rdi, .outstream[rip] # rdi <-- outstream
    lea rsi, .time_output_template_string_part_2[rip + 8] # rsi <-- address of "ns"
    mov rdx, .time_output_template_string_part_2[rip] # rdx <-- 2 - length of string
	syscall # call the kernel

.main_return:
	mov rax, 3 # sys_close
	mov rdi, .instream[rip] # instream
	syscall
	mov rax, 3 # sys_close
	mov rdi, .outstream[rip] # outstream
	syscall

	leave # restore stack and frame pointers
	pop rbx # restore the value of rbx
	pop r13 # restore the value of r13
	pop r12 # restore the value of r12

	mov rax, 60 # sys_exit
	mov rdi, 0 # 0 - return value
	syscall

.throw_error:
	mov rax, 1 # sys_write
    lea rsi, [rdi + 8] # address of string
    mov rdx, [rdi] # length of string
	mov rdi, .outstream[rip] # outstream
	syscall # call the kernel
	jmp .main_return # return
