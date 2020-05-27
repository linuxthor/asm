; linuxthor
;
; sys_getresgid example
;
; assemble with:
; nasm -f elf64 -o sys_getresgid.o sys_getresgid.asm
; ld sys_getresgid.o -o sys_getresgid 

BITS 64

global _start
_start:
    mov rax, 120          ;  sys_getresgid
    mov rdi, rgid
    mov rsi, egid
    mov rdx, sgid
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

section .bss
    rgid resd 1
    egid resd 1
    sgid resd 1
