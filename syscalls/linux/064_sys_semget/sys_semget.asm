; linuxthor
;
; sys_semget example
;
; assemble with:
; nasm -f elf64 -o sys_semget.o sys_semget.asm
; ld sys_semget.o -o sys_semget 

BITS 64

%define IPC_PRIVATE   0
%define	IPC_CREAT     01000	
%define	IPC_EXCL      02000	
%define	IPC_NOWAIT    04000	

global _start
_start:
    mov rax, 64           ;  sys_semget
    mov rdi, 1056         ;  key_t key or IPC_PRIVATE 
    mov rsi, 1
    mov rdx, IPC_CREAT
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall
