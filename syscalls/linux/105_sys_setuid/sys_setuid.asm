; linuxthor
;
; sys_setuid example
;
; assemble with:
; nasm -f elf64 -o sys_setuid.o sys_setuid.asm
; ld sys_setuid.o -o sys_setuid

BITS 64

global _start
_start:
    mov rax, 105          ;  sys_setuid
    mov rdi, 65535
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall
