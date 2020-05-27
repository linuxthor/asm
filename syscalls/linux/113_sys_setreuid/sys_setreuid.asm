; linuxthor
;
; sys_setreuid example
;
; assemble with:
; nasm -f elf64 -o sys_setreuid.o sys_setreuid.asm
; ld sys_setreuid.o -o sys_setreuid 

BITS 64

global _start
_start:
    mov rax, 113         ;  sys_setreuid
    mov rdi, 65535
    mov rsi, 65535
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall
