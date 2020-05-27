; linuxthor
;
; sys_sched_getaffinity example
;
; assemble with:
; nasm -f elf64 -o sys_sched_getaffinity.o sys_sched_getaffinity.asm
; ld sys_sched_getaffinity.o -o sys_sched_getaffinity

BITS 64

global _start
_start:
    mov rax, 204          ;  sys_sched_getaffinity
    mov rdi, 0            ;  some pid or 0 for calling thread
    mov rsi, 128
    mov rdx, cpu_set_t
    syscall

    mov rdi, rax

    mov rax, 60           ;  sys_exit
    syscall

section .bss
    cpu_set_t resb 128
