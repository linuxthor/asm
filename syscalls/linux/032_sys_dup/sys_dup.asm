; linuxthor
;
; sys_dup example
;
; assemble with:
; nasm -f elf64 -o sys_dup.o sys_dup.asm
; ld sys_dup.o -o sys_dup 

BITS 64

global _start
_start:

    mov rax, 32           ;  sys_dup
    mov rdi, 0            ;  old fd
    syscall 

    mov rdi, rax          

    mov rax, 60           ;  sys_exit
    syscall

