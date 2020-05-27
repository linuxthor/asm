; linuxthor
;
; sys_getpriority example
;
; scheduling priority of the process, process group or user
; 
; assemble with:
; nasm -f elf64 -o sys_getpriority.o sys_getpriority.asm
; ld sys_getpriority.o -o sys_getpriority 

BITS 64

%define PRIO_PROCESS  0
%define PRIO_PGRP     1
%define PRIO_USER     2

global _start
_start:

    mov rax, 140          ;  sys_getpriority
    mov rdi, PRIO_PROCESS
    mov rsi, 0            
    syscall              

    mov rdi, rax

    mov rax, 60           ;  sys_exit
    syscall

