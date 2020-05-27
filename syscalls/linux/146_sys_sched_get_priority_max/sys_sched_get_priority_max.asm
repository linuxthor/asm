; linuxthor
;
; sys_sched_get_priority_max example
;
; assemble with:
; nasm -f elf64 -o sys_sched_get_priority_max.o sys_sched_get_priority_max.asm
; ld sys_sched_get_priority_max.o -o sys_sched_get_priority_max

BITS 64

%define SCHED_OTHER           0
%define SCHED_FIFO            1
%define SCHED_RR              2
%define SCHED_BATCH           3
%define SCHED_ISO             4
%define SCHED_IDLE            5
%define SCHED_DEADLINE        6

global _start
_start:
    mov rax, 146          ;  sys_sched_get_priority_max
    mov rdi, SCHED_DEADLINE
    syscall

    mov rdi, rax

    mov rax, 60           ;  sys_exit
    syscall

