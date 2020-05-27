; linuxthor
;
; sys_sync example
;
; assemble with:
; nasm -f elf64 -o sys_sync.o sys_sync.asm
; ld sys_sync.o -o sys_sync 

BITS 64

global _start
_start:
    mov rax, 162            ;  sys_sync
    syscall 

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

