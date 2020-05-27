; linuxthor
;
; sys_mremap example
;
; expand or shrink a memory mapping
; maybe moving it at the same time 
;
; assemble with:
; nasm -f elf64 -o sys_mremap.o sys_mremap.asm
; ld sys_mremap.o -o sys_mremap

BITS 64

%define MREMAP_MAYMOVE  1
%define MREMAP_FIXED    2

global _start
_start:

    mov rax, 12           ;  sys_brk
    mov rdi, 0
    syscall               
    
    mov [breaker], rax

    add rax, 4096         
    mov rdi, rax          
    mov rax, 12           ;  sys_brk
    syscall                 

    mov rax, 25           ;  sys_mremap
    mov rsi, 4096
    mov rdi, [breaker]
    mov rdx, 8192
    mov r10, MREMAP_MAYMOVE
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

section .bss
    breaker resq 1
