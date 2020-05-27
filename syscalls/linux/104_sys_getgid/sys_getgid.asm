; linuxthor
;
; sys_getgid example
;
; assemble with:
; nasm -f elf64 -o sys_getgid.o sys_getgid.asm
; ld sys_getgid.o -o sys_getgid 

BITS 64

global _start
_start:

    mov rax, 104          ;  sys_getgid
    syscall 

    mov rdi, rax          

    mov rax, 60           ;  sys_exit
    syscall

