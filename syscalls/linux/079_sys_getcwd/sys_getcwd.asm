; linuxthor
;
; sys_getcwd example
;
; assemble with:
; nasm -f elf64 -o sys_getcwd.o sys_getcwd.asm
; ld sys_getcwd.o -o sys_getcwd 

BITS 64

global _start
_start:
    mov rax, 79           ;  sys_getcwd
    mov rdi, string       ;  buffer to store result
    mov rsi, 4096         ;  length 
    syscall

    mov rax, 1            ;  sys_write
    mov rdi, 1
    mov rsi, string 
    mov rdx, 4096
    syscall 

    mov rax, 60           ;  sys_exit
    syscall

section .bss
    string   resb 4096    
