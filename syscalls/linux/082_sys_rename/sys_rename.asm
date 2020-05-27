; linuxthor
;
; sys_rename example
;
; assemble with:
; nasm -f elf64 -o sys_rename.o sys_rename.asm
; ld sys_rename.o -o sys_rename 

BITS 64

%define O_MODES 0x42      ;  O_RDWR|O_CREAT

global _start
_start:
    mov rax, 2            ;  sys_open
    mov rdi, filename1 
    mov rsi, O_MODES      
    mov rdx, 0644o
    syscall 

    mov rax, 82           ;  sys_rename
    mov rdi, filename1
    mov rsi, filename2
    syscall 

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

section .data
    filename1   db '/tmp/olleh',0    
    filename2   db '/tmp/dlrow',0
