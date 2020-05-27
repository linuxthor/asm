; linuxthor
;
; sys_close example
;
; assemble with:
; nasm -f elf64 -o sys_close.o sys_close.asm
; ld sys_close.o -o sys_close 

BITS 64

global _start
_start:

    mov rax, 3            ;  sys_close
    mov rdi, 2            ;  stderr
    syscall 

    mov rax, 60           ;  sys_exit
    syscall

