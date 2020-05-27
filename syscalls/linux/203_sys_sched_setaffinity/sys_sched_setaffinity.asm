; linuxthor
;
; sys_sched_setaffinity example
;
; assemble with:
; nasm -f elf64 -o sys_sched_setaffinity.o sys_sched_setaffinity.asm
; ld sys_sched_setaffinity.o -o sys_sched_setaffinity

BITS 64

global _start
_start:
    mov qword [cpu_set_t], 1

    mov rax, 203          ;  sys_sched_getaffinity
    mov rdi, 0            ;  some pid or 0 for calling thread
    mov rsi, 1
    mov rdx, cpu_set_t
    syscall

    mov rdi, rax

    mov rax, 60           ;  sys_exit
    syscall

section .bss
    cpu_set_t resb 128
