; linuxthor
;
; sys_rmdir example
;
; assemble with:
; nasm -f elf64 -o sys_rmdir.o sys_rmdir.asm
; ld sys_rmdir.o -o sys_rmdir 

BITS 64

global _start
_start:
    mov rax, 83            ;  sys_mkdir
    mov rdi, pathname
    mov rsi, 0777o         ;  mode (octal)  
    syscall 

    mov rax, 84            ;  sys_rmdir
    mov rdi, pathname
    syscall

    mov rax, 60            ;  sys_exit
    syscall

section .data
    pathname   db '/tmp/tmptmp',0   
