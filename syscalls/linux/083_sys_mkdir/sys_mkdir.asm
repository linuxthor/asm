; linuxthor
;
; sys_mkdir example
;
; assemble with:
; nasm -f elf64 -o sys_mkdir.o sys_mkdir.asm
; ld sys_mkdir.o -o sys_mkdir 

BITS 64

global _start
_start:
    mov rax, 83            ;  sys_mkdir
    mov rdi, pathname
    mov rsi, 0777o         ;  mode (octal)  
    syscall 

    mov rax, 60           ;  sys_exit
    syscall

section .data
    pathname   db '/tmp/dlrow-olleh',0   
