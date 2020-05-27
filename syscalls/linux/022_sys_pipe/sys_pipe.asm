; linuxthor
;
; sys_pipe example
;
; assemble with:
; nasm -f elf64 -o sys_pipe.o sys_pipe.asm
; ld sys_pipe.o -o sys_pipe

BITS 64

global _start
_start:
    mov rax, 22           ;  sys_pipe
    mov rdi, pipefd0
    syscall 

    mov rax, 60           ;  sys_exit
    mov rdi, [pipefd1]
    syscall

section .bss
    pipefd0  resd 1
    pipefd1  resd 1
