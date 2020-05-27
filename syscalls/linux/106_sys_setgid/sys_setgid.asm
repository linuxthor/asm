; linuxthor
;
; sys_setgid example
;
; assemble with:
; nasm -f elf64 -o sys_setgid.o sys_setgid.asm
; ld sys_setgid.o -o sys_setgid

BITS 64

global _start
_start:
    mov rax, 106          ;  sys_setgid
    mov rdi, 65535
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall
