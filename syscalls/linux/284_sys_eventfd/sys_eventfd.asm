; linuxthor
;
; sys_eventfd example
;
; assemble with:
; nasm -f elf64 -o sys_eventfd.o sys_eventfd.asm
; ld sys_eventfd.o -o sys_eventfd 

BITS 64

global _start
_start:
    mov rax, 284          ;  sys_eventfd
    mov rdi, 0xcafebeef
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall
