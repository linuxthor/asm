; linuxthor
;
; sys_read example
;
; assemble with:
; nasm -f elf64 -o sys_read.o sys_read.asm
; ld sys_read.o -o sys_read 

BITS 64

global _start
_start:

    mov rax, 0            ;  sys_read
    mov rdi, 0
    mov rsi, readsb 
    mov rdx, 16
    syscall 

    mov rax, 60           ;  sys_exit
    syscall

section .bss
    readsb    resb 16    
