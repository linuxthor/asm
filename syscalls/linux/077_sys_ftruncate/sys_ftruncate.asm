; linuxthor
;
; sys_ftruncate example
;
; assemble with:
; nasm -f elf64 -o sys_ftruncate.o sys_ftruncate.asm
; ld sys_ftruncate.o -o sys_ftruncate 

BITS 64

; sys_open
%define O_FLAGS   0x42

global _start
_start:
    mov rax, 2            ;  sys_open
    mov rdi, filename
    mov rsi, O_FLAGS
    mov rdx, 755o
    syscall 

    mov rdi, rax

    mov rax, 77           ;  sys_ftruncate
    mov rsi, 1024
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

section .data
    filename   db '/tmp/squawker',0    
