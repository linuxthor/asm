; linuxthor
;
; sys_write example
;
; assemble with:
; nasm -f elf64 -o sys_write.o sys_write.asm
; ld sys_write.o -o sys_write 

BITS 64

global _start
_start:

    mov rax, 1            ;  sys_write
    mov rdi, 1
    mov rsi, string 
    mov rdx, 6
    syscall 

    mov rax, 60           ;  sys_exit
    syscall

section .data
    string   db 'Hiya',0x0d,0x0a,0    
