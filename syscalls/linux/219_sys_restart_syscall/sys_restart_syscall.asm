; linuxthor
;
; sys_restart_syscall example
;
; see notes in manpage about (not) calling this
;
; assemble with:
; nasm -f elf64 -o sys_restart_syscall.o sys_restart_syscall.asm
; ld sys_restart_syscall.o -o sys_restart_syscall

BITS 64

global _start
_start:
    mov rax, 219          ;  sys_restart_syscall
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

