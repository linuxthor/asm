; linuxthor
;
; sys_readahead example
;
; readahead triggers reading on a file in an attempt
; to make subsequent reads be satisfied from the cache
;
; assemble with:
; nasm -f elf64 -o sys_readahead.o sys_readahead.asm
; ld sys_readahead.o -o sys_readahead 

BITS 64

; sys_open
%define O_RDONLY 0
%define O_WRONLY 1
%define O_RDWR   2

global _start
_start:

    mov rax, 2            ;  sys_open
    mov rdi, filename
    mov rsi, O_RDONLY
    syscall 

    mov rdi, rax

    mov rax, 187          ; sys_readahead
    mov rsi, 0            ; offset
    mov rdx, 4096         ; count
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

section .data
    filename   db '/etc/passwd',0    
