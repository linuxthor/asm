; linuxthor
;
; sys_exit example
;
; assemble with:
; nasm -f elf64 -o sys_exit.o sys_exit.asm
; ld sys_exit.o -o sys_exit 

BITS 64

global _start
_start:

    mov rax, 60           ;  sys_exit
    mov rdi, 666
    syscall
