; linuxthor
;
; sys_fchmod example
;
; assemble with:
; nasm -f elf64 -o sys_fchmod.o sys_fchmod.asm
; ld sys_fchmod.o -o sys_fchmod 

BITS 64

%define O_MODES 0x42      ;  O_RDWR|O_CREAT

global _start
_start:
    mov rax, 2            ;  sys_open
    mov rdi, filename 
    mov rsi, O_MODES      
    mov rdx, 0644o
    syscall 

    mov rdi, rax

    mov rax, 91           ;  sys_fchmod
    mov rsi, 0666o
    syscall 

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

section .data
    filename   db '/tmp/filetmp',0    
