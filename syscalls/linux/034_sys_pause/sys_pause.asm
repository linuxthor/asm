; linuxthor
;
; sys_pause example
;
; pause and wait for some signal
;
; assemble with:
; nasm -f elf64 -o sys_pause.o sys_pause.asm
; ld sys_pause.o -o sys_pause

BITS 64

global _start
_start:
    mov rax, 34           ;  sys_pause
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall
