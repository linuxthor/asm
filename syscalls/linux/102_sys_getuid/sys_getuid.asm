; linuxthor
;
; sys_getuid example
;
; assemble with:
; nasm -f elf64 -o sys_getuid.o sys_getuid.asm
; ld sys_getuid.o -o sys_getuid 

BITS 64

global _start
_start:

    mov rax, 102          ;  sys_getuid
    syscall 

    mov rdi, rax          

    mov rax, 60           ;  sys_exit
    syscall

