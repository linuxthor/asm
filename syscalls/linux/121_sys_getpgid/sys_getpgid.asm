; linuxthor
;
; sys_getpgid example
;
; assemble with:
; nasm -f elf64 -o sys_getpgid.o sys_getpgid.asm
; ld sys_getpgid.o -o sys_getpgid 

BITS 64

global _start
_start:
    mov rax, 121          ;  sys_getpgid
    mov rdi, 0            ;  null for the calling process
    syscall               ;  or some other process.. 

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall
