    .intel_syntax noprefix
	
	.section	.rodata
.read_file_mode:
	.string	"r"
.write_file_mode:
	.string	"w"
    
    .text
	.comm A, 134217728, 32  # переменная A - массив 8-байтных элементов размера 16777216 (134217728 байт)
	.comm B, 134217728, 32  # переменная B - массив 8-байтных элементов размера 16777216 (134217728 байт)
    .globl	main
main:
	push r12 # save r12 on the stack
	push r13 # save r13 on the stack
	push rbp # save frame pointer
	mov	rbp, rsp # save stack pointer
	
	mov r12, rdi # put rdi - first function argument (int argc) - into a callee-saved register r12
	mov r13, rsi # put rsi (char** argv) - second function argument - into a callee-saved register r13

# PARSE INPUT MODE
	mov rax, [r13 + 8] # argv[1]
	cmp BYTE PTR [rax], '0' # argv[1][0] v '0'
	je .input_from_console # input from console => do not need to do anything
	cmp BYTE PTR [rax], '1' # argv[1][0] v '1'
	je .input_from_file # input from file
	cmp BYTE PTR [rax], '2' # argv[1][0] v '2'
	je .input_unimplemented # for future use
.input_from_console:
	mov rcx, 2 # position of output flag - argv[2]
	jmp .input_parse_complete
.input_from_file:
	mov	rdi, [r13 + 2 * 8] # rdi <-- argv[2] - first function argument
	lea	rsi, .read_file_mode[rip] # rsi <-- "r" - second function argument
	mov	rdx, QWORD PTR stdin[rip] # rdi <-- stdin - third function argument
	call freopen@PLT # freopen(argv[2], "r", stdin);
	mov rcx, 3 # position of output flag - argv[3]
	jmp .input_parse_complete
.input_unimplemented:
	mov rcx, 2 # position of output flag - argv[2]
	jmp .input_parse_complete
.input_parse_complete:

# PARSE OUTPUT MODE
	mov rax, [r13 + 8 * rcx] # argv[2] or argv[3]
	cmp BYTE PTR [rax], '0' # output_mode = '0'
	je .output_to_console # output to console => do not need to do anything
	cmp BYTE PTR [rax], '1' # output_mode = '1'
	je .output_to_file # output to file
	cmp BYTE PTR [rax], '2' # output_mode = '2'
	je .output_unimplemented # for future use
.output_to_console:
	jmp .output_parse_complete
.output_to_file:
	mov	rdi, [r13 + rcx * 8 + 8] # rdi <-- argv[rcx + 1] - first function argument
	lea	rsi, .write_file_mode[rip] # rsi <-- "r" - second function argument
	mov	rdx, QWORD PTR stdout[rip] # rdi <-- stdout - third function argument
	call freopen@PLT # freopen(argv[?], "w", stdout);
	jmp .output_parse_complete
.output_unimplemented:
	jmp .output_parse_complete
.output_parse_complete:



	lea	rdi, A[rip] # rdi <-- address of array A - first function argument
	mov	esi, 16777214 # esi ~ rsi <-- MAX_INPUT_LENGTH - second function argument
	call input # input(A, MAX_INPUT_LENGTH)

	lea	rdi, A[rip] # rdi <-- address of array A - first function argument
	mov	rsi, rax # rsi <-- return value of input(A, MAX_INPUT_LENGTH) - second function argument
	lea	rdx, B[rip] # rdx <-- address of array B - third function argument
	call solve # solve(A, input(A, MAX_INPUT_LENGTH), B)

	lea	rdi, B[rip] # rdi <-- address of array B - first function argument
	mov	rsi, rax # rsi <-- return value of solve(...) - second function argument
	call output # output(B, solve(A, input(A, MAX_INPUT_LENGTH), B));

	mov	eax, 0 # 0 - return value
	leave # restore stack and frame pointers
	pop r13 # restore the value of r13
	pop r12 # restore the value of r12
	ret # return
