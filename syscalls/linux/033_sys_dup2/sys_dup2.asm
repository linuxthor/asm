; linuxthor
;
; sys_dup2 example
;
; assemble with:
; nasm -f elf64 -o sys_dup2.o sys_dup2.asm
; ld sys_dup2.o -o sys_dup2 

BITS 64

global _start
_start:

    mov rax, 33           ;  sys_dup2
    mov rdi, 0            ;  old fd
    mov rsi, 13           ;  new fd
    syscall 

    mov rdi, rax

    mov rax, 60           ;  sys_exit
    syscall

