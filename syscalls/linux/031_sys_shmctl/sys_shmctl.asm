; linuxthor
;
; sys_shmctl example
;
; assemble with:
; nasm -f elf64 -o sys_shmctl.o sys_shmctl.asm
; ld sys_shmctl.o -o sys_shmctl

BITS 64

struc shmid_ds
    .shm_perm   resb 48    ; struct ipc_perm..
    .shm_segsz  resq 1
    .shm_atime  resq 1
    .shm_dtime  resq 1
    .shm_ctime  resq 1
    .shm_cpid   resd 1
    .shm_lpid   resd 1
    .shm_natt   resq 1
endstruc

%define IPC_RMID 0 
%define IPC_SET  1  
%define IPC_STAT 2    
%define IPC_INFO 3     

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

    mov rax, 31           ;  sys_shmctl
    mov rsi, IPC_INFO
    mov rdx, shmidii
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

section .bss
    shmidii resb shmid_ds_size
