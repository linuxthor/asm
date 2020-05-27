; linuxthor
;
; sys_chown example
;
; assemble with:
; nasm -f elf64 -o sys_chown.o sys_chown.asm
; ld sys_chown.o -o sys_chown

BITS 64

; sys_open
%define O_MODES 0x42      ; O_RDWR|O_CREAT

global _start
_start:
    mov rax, 2            ;  sys_open
    mov rdi, filename
    mov rsi, O_MODES
    mov rdx, 0666o
    syscall 

    mov rax, 92           ;  sys_chown
    mov rdi, filename
    mov rsi, 65535
    mov rdx, 65535
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

section .data
    filename   db '/tmp/somefile',0    

