; linuxthor
;
; sys_dup3 example
;
; dup3 is like dup2 with an extra 'flags'
; argument where O_CLOEXEC can be set
;
; assemble with:
; nasm -f elf64 -o sys_dup3.o sys_dup3.asm
; ld sys_dup3.o -o sys_dup3 

BITS 64

%define O_CLOEXEC    0x80000

global _start
_start:

    mov rax, 292          ;  sys_dup3
    mov rdi, 0            ;  old fd
    mov rsi, 13           ;  new fd
    mov rdx, O_CLOEXEC
    syscall 

    mov rdi, rax

    mov rax, 60           ;  sys_exit
    syscall

