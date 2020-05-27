; linuxthor
;
; sys_shmat example
;
; assemble with:
; nasm -f elf64 -o sys_shmat.o sys_shmat.asm
; ld sys_shmat.o -o sys_shmat

BITS 64

%define SHM_RDONLY   010000               
%define SHM_RND      020000             
%define SHM_REMAP    040000               
%define SHM_EXEC     0100000                

; sys_shmget
%define IPC_PRIVATE  00000000
%define IPC_CREAT    00001000   
%define IPC_EXCL     00002000   
%define IPC_NOWAIT   00004000 

global _start
_start:
    mov rax, 29           ;  sys_shmget 
    mov rdi, IPC_PRIVATE
    mov rsi, 8192
    mov rdx, IPC_CREAT
    syscall

    mov rdi, rax

    mov rax, 30           ; sys_shmat
    mov rsi, 0            ; NULL to let system place it
    mov rdx, SHM_EXEC
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall
