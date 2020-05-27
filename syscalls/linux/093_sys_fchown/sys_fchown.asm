; linuxthor
;
; sys_fchown example
;
; assemble with:
; nasm -f elf64 -o sys_fchown.o sys_fchown.asm
; ld sys_fchown.o -o sys_fchown

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

    mov rdi, rax

    mov rax, 93           ;  sys_chown
    mov rsi, 65535
    mov rdx, 65535
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

section .data
    filename   db '/tmp/electricmeat',0    

