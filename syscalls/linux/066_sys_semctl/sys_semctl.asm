; linuxthor
;
; sys_semctl example
;
; assemble with:
; nasm -f elf64 -o sys_semctl.o sys_semctl.asm
; ld sys_semctl.o -o sys_semctl 

BITS 64

%define IPC_RMID      0                
%define IPC_SET       1               
%define IPC_STAT      2                
%define IPC_INFO      3                

; sys_semget
%define IPC_PRIVATE   0
%define	IPC_CREAT     01000	
%define	IPC_EXCL      02000	
%define	IPC_NOWAIT    04000	

global _start
_start:
    mov rax, 64           ;  sys_semget
    mov rdi, 1076         
    mov rsi, 4
    mov rdx, IPC_CREAT
    syscall

    mov rdi, rax

    mov rax, 66           ;  sys_semctl
    mov rsi, IPC_RMID
    mov rdx, 0
    syscall     

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall
