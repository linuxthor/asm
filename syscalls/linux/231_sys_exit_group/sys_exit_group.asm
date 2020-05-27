; linuxthor
;
; sys_exit_group example
;
; assemble with:
; nasm -f elf64 -o sys_exit_group.o sys_exit_group.asm
; ld sys_exit_group.o -o sys_exit_group 

BITS 64

global _start
_start:

    mov rax, 231          ;  sys_exit_group
    mov rdi, 666
    syscall
