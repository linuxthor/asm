; linuxthor
;
; sys_syncfs example
;
; sys_syncfs is like sys_sync but takes as an 
; argument an fd and syncs the filesystem where 
; it resides
;
; assemble with:
; nasm -f elf64 -o sys_syncfs.o sys_syncfs.asm
; ld sys_syncfs.o -o sys_syncfs 

BITS 64

%define O_RDONLY 0
%define O_WRONLY 1
%define O_RDWR 2

global _start
_start:

    mov rax, 2            ;  sys_open
    mov rdi, filename
    mov rsi, O_RDONLY
    syscall 

    mov rdi, rax

    mov rax, 306          ;  sys_syncfs
    syscall

    mov rax, 60           ;  sys_exit
    syscall

section .data
    filename   db '/etc/issue',0    
