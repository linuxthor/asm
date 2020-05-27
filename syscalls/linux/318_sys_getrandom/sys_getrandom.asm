; linuxthor
;
; sys_getrandom example
;
; assemble with:
; nasm -f elf64 -o sys_getrandom.o sys_getrandom.asm
; ld sys_getrandom.o -o sys_getrandom 

BITS 64

%define GRND_NONBLOCK 0x01
%define GRND_RANDOM   0x02

global _start
_start:
    mov rax, 318          ;  sys_getrandom
    mov rdi, buf
    mov rsi, len
    mov rdx, GRND_NONBLOCK
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

section .bss
    buf resb 1024
    len equ $- buf 
