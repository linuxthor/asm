; linuxthor
;
; sys_getppid example
;
; assemble with:
; nasm -f elf64 -o sys_getppid.o sys_getppid.asm
; ld sys_getppid.o -o sys_getppid 

BITS 64

global _start
_start:

    mov rax, 110          ;  sys_getppid
    syscall 

    mov rdi, rax

    mov rax, 60           ;  sys_exit
    syscall

