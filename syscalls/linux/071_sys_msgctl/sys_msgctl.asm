; linuxthor
;
; sys_msgctl example
;
; assemble with:
; nasm -f elf64 -o sys_msgctl.o sys_msgctl.asm
; ld sys_msgctl.o -o sys_msgctl

BITS 64

%define IPC_NOWAIT     04000o
%define IPC_RMID       0
%define IPC_SET        1                
%define IPC_STAT       2                
%define IPC_INFO       3                

struc msqid_ds
    .msg_perm   resb 48
    .msg_stime  resq 1
    .msg_rtime  resq 1
    .msg_ctime  resq 1
    .msg_cbytes resq 1
    .msg_qnum   resq 1
    .msg_qbytes resq 1
    .msg_lspid  resd 1
    .msg_lrpid  resd 1
endstruc

; sys_msgget
%define IPC_PRIVATE     0
%define	IPC_CREAT       01000o

global _start
_start:
    mov rax, 68           ;  sys_msgget
    mov rdi, IPC_PRIVATE
    mov rsi, (IPC_CREAT|0666o)
    syscall

    mov rdi, rax

    mov rax, 71           ;  sys_msgctl
    mov rsi, IPC_STAT
    mov rdx, msqd
    syscall 

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

section .bss
    msqd resb msqid_ds_size
