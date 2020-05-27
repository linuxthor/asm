; linuxthor
;
; sys_execve example
;
; assemble with:
; nasm -f elf64 -o sys_execve.o sys_execve.asm
; ld sys_execve.o -o sys_execve 

BITS 64

global _start
_start:

    mov rax, 59           ;  sys_execve
    mov rdi, cmd
    mov [arg], rdi        ;  argv0 cmd name
    mov rbx, av1
    mov [arg+8], rbx
    mov rsi, arg
    mov rdx, 0            ;  envp (null)
    syscall 

    mov rax, 60           ;  sys_exit
    syscall

section .data
    cmd  db  '/bin/echo',0
    av1  db  'hiya mateys',0

section .bss
    arg  resq  8
