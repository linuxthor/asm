; linuxthor
;
; sys_getresuid example
;
; assemble with:
; nasm -f elf64 -o sys_getresuid.o sys_getresuid.asm
; ld sys_getresuid.o -o sys_getresuid 

BITS 64

global _start
_start:
    mov rax, 118          ;  sys_getresuid
    mov rdi, ruid
    mov rsi, euid
    mov rdx, suid
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

section .bss
    ruid resd 1
    euid resd 1
    suid resd 1
