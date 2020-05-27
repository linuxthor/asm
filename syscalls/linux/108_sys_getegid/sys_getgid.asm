; linuxthor
;
; sys_getegid example
;
; assemble with:
; nasm -f elf64 -o sys_getegid.o sys_getegid.asm
; ld sys_getegid.o -o sys_getegid 

BITS 64

global _start
_start:

    mov rax, 108          ;  sys_getegid
    syscall 

    mov rdi, rax          

    mov rax, 60           ;  sys_exit
    syscall

