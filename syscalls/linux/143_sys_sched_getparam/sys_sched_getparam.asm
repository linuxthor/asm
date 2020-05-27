; linuxthor
;
; sys_sched_getparam example
;
; assemble with:
; nasm -f elf64 -o sys_sched_getparam.o sys_sched_getparam.asm
; ld sys_sched_getparam.o -o sys_sched_getparam 

BITS 64

struc sched_param
    .sched_priority resd 1
endstruc

global _start
_start:
    mov rax, 143          ;  sys_sched_getparam
    mov rdi, 0
    mov rsi, spst
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

section .bss
    spst resb sched_param_size
