; linuxthor
;
; sys_getscheduler example
;
; assemble with:
; nasm -f elf64 -o sys_getscheduler.o sys_getscheduler.asm
; ld sys_getscheduler.o -o sys_getscheduler 

BITS 64

global _start
_start:
    mov rax, 145          ;  sys_getscheduler
    mov rdi, 0            
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall
