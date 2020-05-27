; linuxthor
;
; sys_msgget example
;
; assemble with:
; nasm -f elf64 -o sys_msgget.o sys_msgget.asm
; ld sys_msgget.o -o sys_msgget 

BITS 64

%define IPC_PRIVATE 0

%define	IPC_CREAT       01000o
%define	IPC_EXCL        02000o
%define	IPC_NOWAIT      04000o

global _start
_start:
    mov rax, 68           ;  sys_msgget
    mov rdi, IPC_PRIVATE
    mov rsi, (IPC_CREAT|0666o)
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall
