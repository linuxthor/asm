; linuxthor
;
; sys_creat example
;
; sys_creat is like open with flags set as
; O_CREAT|O_WRONLY|O_TRUNC
;
; assemble with:
; nasm -f elf64 -o sys_creat.o sys_creat.asm
; ld sys_creat.o -o sys_creat 

BITS 64

global _start
_start:
    mov rax, 85            ;  sys_creat
    mov rdi, filename
    mov rsi, 0644o         ;  mode (octal)  
    syscall 

    mov rax, 60            ;  sys_exit
    syscall

section .data
    filename   db '/tmp/something',0   
