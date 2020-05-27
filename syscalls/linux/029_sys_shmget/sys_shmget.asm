; linuxthor
;
; sys_shmget example
;
; assemble with:
; nasm -f elf64 -o sys_shmget.o sys_shmget.asm
; ld sys_shmget.o -o sys_shmget

BITS 64

%define IPC_PRIVATE  00000000o
%define IPC_CREAT    00001000o   
%define IPC_EXCL     00002000o   
%define IPC_NOWAIT   00004000o 

global _start
_start:
    mov rax, 29           ;  sys_shmget 
    mov rdi, IPC_PRIVATE
    mov rsi, 8192
    mov rdx, IPC_CREAT|0666o
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall
