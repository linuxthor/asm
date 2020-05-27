; linuxthor
;
; sys_arch_prctl example
;
; allows for some architecture specific stuff on
; x86-64
;
; assemble with:
; nasm -f elf64 -o sys_arch_prctl.o sys_arch_prctl.asm
; ld sys_arch_prctl.o -o sys_arch_prctl 

BITS 64

%define ARCH_SET_GS    0x1001
%define ARCH_SET_FS    0x1002
%define ARCH_GET_FS    0x1003
%define ARCH_GET_GS    0x1004

global _start
_start:

    mov rax, 158          ;  sys_arch_prctl
    mov rdi, ARCH_SET_FS
    mov rsi, 8008
    syscall

    mov rax, 158          ;  sys_arch_prctl
    mov rdi, ARCH_GET_FS
    mov rsi, result
    syscall 

    mov rdi, [result]

    mov rax, 60           ;  sys_exit
    syscall

section .bss
    result  resq 1
