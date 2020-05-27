; linuxthor
;
; sys_open example
;
; assemble with:
; nasm -f elf64 -o sys_open.o sys_open.asm
; ld sys_open.o -o sys_open 

BITS 64

%define O_RDONLY 0
%define O_WRONLY 1
%define O_RDWR   2

global _start
_start:

    mov rax, 2            ;  sys_open
    mov rdi, filename
    mov rsi, O_RDWR
    syscall 

    mov rax, 60           ;  sys_exit
    syscall

section .data
    filename   db '/dev/null',0    
