; linuxthor
;
; sys_unshare example
;
; assemble with:
; nasm -f elf64 -o sys_unshare.o sys_unshare.asm
; ld sys_unshare.o -o sys_unshare 

BITS 64

%define CLONE_NEWUTS            0x04000000
%define CLONE_NEWIPC            0x08000000
%define CLONE_NEWUSER           0x10000000
%define CLONE_NEWPID            0x20000000
%define CLONE_NEWNET            0x40000000

global _start
_start:
    mov rax, 272          ;  sys_unshare
    mov rdi, CLONE_NEWPID
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall
