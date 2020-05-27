; linuxthor
;
; sys_tgkill example
;
; assemble with:
; nasm -f elf64 -o sys_tgkill.o sys_tgkill.asm
; ld sys_tgkill.o -o sys_tgkill

BITS 64

global _start
_start:
    mov rax, 200          ;  sys_tkill
    mov rdi, 1234          
    mov rsi, 1
    mov rdx, 9
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall
