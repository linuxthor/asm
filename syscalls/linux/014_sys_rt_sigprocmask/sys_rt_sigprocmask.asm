; linuxthor
;
; sys_rt_sigprocmask example
;
; assemble with:
; nasm -f elf64 -o sys_rt_sigprocmask.o sys_rt_sigprocmask.asm
; ld sys_rt_sigprocmask.o -o sys_rt_sigprocmask 

BITS 64

%define SIG_BLOCK    0
%define SIG_UNBLOCK  1
%define SIG_SETMASK  2

global _start
_start:
    mov rax, 14           ;  sys_rt_sigprocmask
    mov rdi, SIG_SETMASK
    mov rsi, 0
    mov rdx, oldset
    mov r10, 8
    mov r8, 8
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, oldset
    syscall

section .bss
    oldset resq 1
