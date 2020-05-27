; linuxthor
;
; sys_umask example
;
; assemble with:
; nasm -f elf64 -o sys_umask.o sys_umask.asm
; ld sys_umask.o -o sys_umask

BITS 64

global _start
_start:
    mov rax, 95           ;  sys_umask
    mov rdi, 022o
    syscall

    mov rdi, rax

    mov rax, 60           ;  sys_exit
    syscall
