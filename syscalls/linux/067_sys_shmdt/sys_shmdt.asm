; linuxthor
;
; sys_shmdt example
;
; assemble with:
; nasm -f elf64 -o sys_shmdt.o sys_shmdt.asm
; ld sys_shmdt.o -o sys_shmdt

BITS 64

; sys_shmat
%define SHM_RDONLY   010000o               
%define SHM_RND      020000o             
%define SHM_REMAP    040000o               
%define SHM_EXEC     0100000o                

; sys_shmget
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

    mov rdi, rax

    mov rax, 30           ; sys_shmat
    mov rsi, 0            
    mov rdx, SHM_EXEC
    syscall

    mov rdi, rax

    mov rax, 67          ; sys_shmdt
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall
