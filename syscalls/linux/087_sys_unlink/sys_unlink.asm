; linuxthor
;
; sys_unlink example
;
; unlink a file and maybe delete it
;
; assemble with:
; nasm -f elf64 -o sys_unlink.o sys_unlink.asm
; ld sys_unlink.o -o sys_unlink 

BITS 64

%define O_MODES 0x42      ;  O_RDWR|O_CREAT

global _start
_start:
    mov rax, 2            ;  sys_open
    mov rdi, filename1 
    mov rsi, O_MODES      
    mov rdx, 0644o
    syscall 

    mov rax, 86           ;  sys_link
    mov rdi, filename1
    mov rsi, filename2
    syscall 

    mov rax, 87           ;  sys_unlink
    mov rdi, filename2 
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

section .data
    filename1   db '/tmp/real-life',0    
    filename2   db '/tmp/just-fantasy',0
