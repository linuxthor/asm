; linuxthor
;
; sys_chmod example
;
; assemble with:
; nasm -f elf64 -o sys_chmod.o sys_chmod.asm
; ld sys_chmod.o -o sys_chmod 

BITS 64

%define O_MODES 0x42      ;  O_RDWR|O_CREAT

global _start
_start:
    mov rax, 2            ;  sys_open
    mov rdi, filename 
    mov rsi, O_MODES      
    mov rdx, 0644o
    syscall 

    mov rax, 90           ;  sys_chmod
    mov rdi, filename
    mov rsi, 0666o
    syscall 

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

section .data
    filename   db '/tmp/tmpfile',0    
