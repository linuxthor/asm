; linuxthor
;
; sys_kill example
;
; assemble with:
; nasm -f elf64 -o sys_kill.o sys_kill.asm
; ld sys_kill.o -o sys_kill

BITS 64

global _start
_start:
    mov rax, 62           ;  sys_kill
    mov rdi, 1234          
    mov rsi, 9
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall
