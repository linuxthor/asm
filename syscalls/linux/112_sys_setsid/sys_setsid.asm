; linuxthor
;
; sys_setsid example
;
; assemble with:
; nasm -f elf64 -o sys_setsid.o sys_setsid.asm
; ld sys_setsid.o -o sys_setsid 

BITS 64

global _start
_start:
    mov rax, 112          ; sys_setsid
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 666
    syscall
