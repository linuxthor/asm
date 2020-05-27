; linuxthor
;
; sys_truncate example
;
; assemble with:
; nasm -f elf64 -o sys_truncate.o sys_truncate.asm
; ld sys_truncate.o -o sys_truncate 

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

    mov rax, 76           ;  sys_truncate
    mov rdi, filename
    mov rsi, 1024
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

section .data
    filename   db '/tmp/squeaker',0    
