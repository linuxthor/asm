; linuxthor
;
; sys_tkill example
;
; assemble with:
; nasm -f elf64 -o sys_tkill.o sys_tkill.asm
; ld sys_tkill.o -o sys_tkill

BITS 64

global _start
_start:
    mov rax, 200          ;  sys_tkill
    mov rdi, 1234          
    mov rsi, 9
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall
