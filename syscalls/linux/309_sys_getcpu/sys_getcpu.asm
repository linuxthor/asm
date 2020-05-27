; linuxthor
;
; sys_getcpu example
;
; assemble with:
; nasm -f elf64 -o sys_getcpu.o sys_getcpu.asm
; ld sys_getcpu.o -o sys_getcpu

BITS 64

global _start
_start:
    mov rax, 309          ;  sys_getcpu
    mov rdi, cpui
    mov rsi, node
    mov rdx, 0            ;  now unused field
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, [cpui]
    syscall

section .bss 
    cpui  resb 1
    node  resb 1
