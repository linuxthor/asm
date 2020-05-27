; linuxthor
;
; sys_getgroups example
;
; assemble with:
; nasm -f elf64 -o sys_getgroups.o sys_getgroups.asm
; ld sys_getgroups.o -o sys_getgroups 

BITS 64

global _start
_start:
    mov rax, 115          ;  sys_getgroups
    mov rdi, 256
    mov rsi, supgrp
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

section .bss
    supgrp resd 256
