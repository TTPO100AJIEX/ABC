section .data
   helloworld db 'Hello, World!'
   helloworld_length dd $-helloworld
   
section .text
global _start
_start:
   mov rax, 1
   mov rdi, 1
   mov rsi, helloworld
   mov rdx, 0
   mov edx, dword[helloworld_length]
   syscall

   mov rax, 60
   mov rdi, 0
   syscall