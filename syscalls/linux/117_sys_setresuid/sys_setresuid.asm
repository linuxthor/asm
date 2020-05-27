; linuxthor
;
; sys_setresuid example
;
; assemble with:
; nasm -f elf64 -o sys_setresuid.o sys_setresuid.asm
; ld sys_setresuid.o -o sys_setresuid 

BITS 64

global _start
_start:
    mov rax, 117         ;  sys_setresuid
    mov rdi, 65535
    mov rsi, 65535
    mov rdx, 65535
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall
