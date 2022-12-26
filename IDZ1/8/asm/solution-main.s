    .intel_syntax noprefix
	
	.section	.rodata
.read_file_mode:
	.string	"r"
.write_file_mode:
	.string	"w"
.time_output_template_string:
	.string	"\n\nCPU time used: %lluns\n"
    
    .text
	.comm A, 134217728, 32  # переменная A - массив 8-байтных элементов размера 16777216 (134217728 байт)
	.comm B, 134217728, 32  # переменная B - массив 8-байтных элементов размера 16777216 (134217728 байт)
    .globl	main
main:
	push r12 # save r12 on the stack
	push r13 # save r13 on the stack
	push rbx # save rbx on the stack
	push rbp # save frame pointer
	mov	rbp, rsp # save stack pointer
	sub rsp, 8 # align stack
	
	mov r12, rdi # put rdi - first function argument (int argc) - into a callee-saved register r12
	mov r13, rsi # put rsi (char** argv) - second function argument - into a callee-saved register r13

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
	mov	rdi, [r13 + 2 * 8] # rdi <-- argv[2] - first function argument
	lea	rsi, .read_file_mode[rip] # rsi <-- "r" - second function argument
	mov	rdx, QWORD PTR stdin[rip] # rdi <-- stdin - third function argument
	call freopen@PLT # freopen(argv[2], "r", stdin);
	# fix rcx and rdx which might have been changed by freopen
	mov rcx, 3 # rcx <-- output_flag_argv_index = 3 ~ output_flag_argv_index++
	mov rdx, 0 # rdx <-- array_read_mode = 0
	jmp .input_parse_complete
.input_random:
	mov rdx, 1 # rdx <-- array_read_mode = 1
.input_parse_complete:

# PARSE OUTPUT MODE
	mov rax, [r13 + 8 * rcx] # argv[2] or argv[3]
	mov al, BYTE PTR [rax] # al <-- argv[output_flag_argv_index][0]

	cmp al, '1' # argv[1][0] v '1'
	je .output_to_file # if (argv[output_flag_argv_index][0] == '1') - output to file
	jmp .output_parse_complete
	
.output_to_file:
	mov r12, rdx # rdx may be changed by freopen, so it has to be saved in r12, which is callee-saved and not needed anymore
	mov	rdi, [r13 + rcx * 8 + 8] # rdi <-- argv[rcx + 1] - first function argument
	lea	rsi, .write_file_mode[rip] # rsi <-- "r" - second function argument
	mov	rdx, QWORD PTR stdout[rip] # rdi <-- stdout - third function argument
	call freopen@PLT # freopen(argv[output_flag_argv_index + 1], "w", stdout);
	mov rdx, r12 # restore rdx
.output_parse_complete:

	lea	rdi, A[rip] # rdi <-- address of array A - first function argument
	mov	esi, 16777214 # esi ~ rsi <-- MAX_INPUT_LENGTH - second function argument
	# rdx - third function argument - is already in place
	call input # input(A, MAX_INPUT_LENGTH)

	mov r13, rax # save return value of input in r13
	call clock@PLT # rax <-- start = clock()
	mov r12, rax # r12 <-- start = clock()

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
	call clock@PLT # rax <-- end = clock()
	sub rax, r12 # rax <-- end - start
	# CLOCK_PER_SEC = 1000000
	imul r12, rax, 1000 # r12 <-- 1000 * (end - start) = cpu_time_used


	lea	rdi, B[rip] # rdi <-- address of array B - first function argument
	mov	rsi, r13 # rsi <-- return value of solve(...) - second function argument
	call output # output(B, solve(A, input(A, MAX_INPUT_LENGTH), B));


	lea	rdi, .time_output_template_string[rip] # rdi <-- "\n\nCPU time used: %lluns" - first function argument
	mov	rsi, r12 # rsi <-- r12 = cpu_time_used - second function argument]
	call printf@PLT


	mov	eax, 0 # 0 - return value
	leave # restore stack and frame pointers
	pop rbx # restore the value of rbx
	pop r13 # restore the value of r13
	pop r12 # restore the value of r12
	ret # return
