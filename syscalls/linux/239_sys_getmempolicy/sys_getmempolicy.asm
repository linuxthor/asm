; linuxthor
;
; sys_getmempolicy example
;
; assemble with:
; nasm -f elf64 -o sys_getmempolicy.o sys_getmempolicy.asm
; ld sys_getmempolicy.o -o sys_getmempolicy 

BITS 64

global _start
_start:
    mov rax, 239          ;  sys_getmempolicy
    mov rdi, mode
    mov rsi, nmask
    mov rdx, 1            ; rounded to sizeof(unsigned long)*8
    mov r10, 0
    mov r8,  0
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

section .bss
    mode resd 1
   nmask resq 1
