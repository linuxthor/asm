; linuxthor
;
; sys_fchdir example
;
; assemble with:
; nasm -f elf64 -o sys_fchdir.o sys_fchdir.asm
; ld sys_fchdir.o -o sys_fchdir 

BITS 64

; sys_open
%define O_RDONLY 0
%define O_WRONLY 1
%define O_RDWR   2

global _start
_start:
    mov rax, 2            ;  sys_open
    mov rdi, pathname
    mov rsi, O_RDONLY
    syscall 

    mov rdi, rax

    mov rax, 81           ;  sys_fchdir
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

section .data
    pathname   db '/tmp',0    
