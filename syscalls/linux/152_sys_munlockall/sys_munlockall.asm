; linuxthor
;
; sys_munlockall example
;
; assemble with:
; nasm -f elf64 -o sys_munlockall.o sys_munlockall.asm
; ld sys_munlockall.o -o sys_munlockall 

BITS 64

global _start
_start:
    mov rax, 152          ;  sys_munlockall
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall
