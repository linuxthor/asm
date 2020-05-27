; linuxthor
;
; sys_chdir example
;
; assemble with:
; nasm -f elf64 -o sys_chdir.o sys_chdir.asm
; ld sys_chdir.o -o sys_chdir 

BITS 64

global _start
_start:

    mov rax, 80            ;  sys_chdir
    mov rdi, pathname
    syscall 

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

section .data
    pathname   db '/tmp',0    
