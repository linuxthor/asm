; linuxthor
;
; sys_getpgrp example
;
; assemble with:
; nasm -f elf64 -o sys_getpgrp.o sys_getpgrp.asm
; ld sys_getpgrp.o -o sys_getpgrp 

BITS 64

global _start
_start:
    mov rax, 111          ;  sys_getpgrp
    syscall

    mov rdi, rax

    mov rax, 60           ;  sys_exit
    syscall
