; linuxthor
;
; sys_setgroups example
;
; assemble with:
; nasm -f elf64 -o sys_setgroups.o sys_setgroups.asm
; ld sys_setgroups.o -o sys_setgroups 

BITS 64

global _start
_start:
    mov dword [supgrp], 65535
 
    mov rax, 116          ;  sys_setgroups
    mov rdi, 1
    mov rsi, supgrp
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

section .bss
    supgrp resd 1
