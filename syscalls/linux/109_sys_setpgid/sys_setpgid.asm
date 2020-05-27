; linuxthor
;
; sys_setpgid example
;
; assemble with:
; nasm -f elf64 -o sys_setpgid.o sys_setpgid.asm
; ld sys_setpgid.o -o sys_setpgid 

BITS 64

global _start
_start:
    mov rax, 109          ;  sys_setpgid 
    mov rdi, 0
    mov rsi, 0
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall
