; linuxthor
;
; sys_gettid example
;
; gettid returns the callers thread ID 
;
; assemble with:
; nasm -f elf64 -o sys_gettid.o sys_gettid.asm
; ld sys_gettid.o -o sys_gettid 

BITS 64

global _start
_start:

    mov rax, 186          ;  sys_gettid
    syscall 

    mov rdi, rax

    mov rax, 60           ;  sys_exit
    syscall

