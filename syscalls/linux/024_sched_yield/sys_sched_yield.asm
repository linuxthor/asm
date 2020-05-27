; linuxthor
;
; sys_sched_yield example
;
; yield the scheduler and go the the back of the queue
;
; assemble with:
; nasm -f elf64 -o sys_sched_yield.o sys_sched_yield.asm
; ld sys_sched_yield.o -o sys_sched_yield 

BITS 64

global _start
_start:

    mov rax, 24           ;  sys_sched_yield
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall
