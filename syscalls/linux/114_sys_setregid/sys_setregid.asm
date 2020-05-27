; linuxthor
;
; sys_setregid example
;
; assemble with:
; nasm -f elf64 -o sys_setregid.o sys_setregid.asm
; ld sys_setregid.o -o sys_setregid 

BITS 64

global _start
_start:
    mov rax, 114         ;  sys_setregid
    mov rdi, 65535
    mov rsi, 65535
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall
