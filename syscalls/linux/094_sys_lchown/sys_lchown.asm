; linuxthor
;
; sys_lchown example
;
; assemble with:
; nasm -f elf64 -o sys_lchown.o sys_lchown.asm
; ld sys_lchown.o -o sys_lchown

BITS 64

; sys_open
%define O_MODES 0x42      ; O_RDWR|O_CREAT

global _start
_start:
    mov rax, 2            ;  sys_open
    mov rdi, filename1
    mov rsi, O_MODES
    mov rdx, 0666o
    syscall 

    mov rax, 88           ;  sys_symlink
    mov rdi, filename1
    mov rsi, filename2
    syscall

    mov rax, 94           ;  sys_chown
    mov rdi, filename2    
    mov rsi, 65535
    mov rdx, 65535
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

section .data
    filename1   db '/tmp/electricbeef',0    
    filename2   db '/tmp/sharporanges',0

section .bss
    fd resq 1
