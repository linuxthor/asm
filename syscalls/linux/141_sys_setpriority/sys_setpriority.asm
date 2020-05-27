; linuxthor
;
; sys_setpriority example
;
; assemble with:
; nasm -f elf64 -o sys_setpriority.o sys_setpriority.asm
; ld sys_setpriority.o -o sys_setpriority 

BITS 64

%define PRIO_PROCESS  0
%define PRIO_PGRP     1
%define PRIO_USER     2

global _start
_start:

    mov rax, 141          ;  sys_setpriority
    mov rdi, PRIO_PROCESS
    mov rsi, 0           
    mov rdx, 19 
    syscall              

    mov rax, 60           ;  sys_exit
    syscall

