; linuxthor
;
; sys_geteuid example
;
; assemble with:
; nasm -f elf64 -o sys_geteuid.o sys_geteuid.asm
; ld sys_geteuid.o -o sys_geteuid 

BITS 64

global _start
_start:

    mov rax, 107          ;  sys_geteuid
    syscall 

    mov rdi, rax          

    mov rax, 60           ;  sys_exit
    syscall

