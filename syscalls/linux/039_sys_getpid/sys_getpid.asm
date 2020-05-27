; linuxthor
;
; sys_getpid example
;
; assemble with:
; nasm -f elf64 -o sys_getpid.o sys_getpid.asm
; ld sys_getpid.o -o sys_getpid 

BITS 64

global _start
_start:

    mov rax, 39           ;  sys_getpid
    syscall 

    mov rdi, rax

    mov rax, 60           ;  sys_exit
    syscall

