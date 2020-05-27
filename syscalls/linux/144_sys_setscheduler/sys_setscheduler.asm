; linuxthor
;
; sys_setscheduler example
;
; assemble with:
; nasm -f elf64 -o sys_setscheduler.o sys_setscheduler.asm
; ld sys_setscheduler.o -o sys_setscheduler 

BITS 64

%define SCHED_OTHER         0
%define SCHED_FIFO          1
%define SCHED_RR            2
%define SCHED_BATCH         3
%define SCHED_ISO           4
%define SCHED_IDLE          5
%define SCHED_DEADLINE      6

struc sched_param
    .sched_priority resd 1
endstruc

global _start
_start:
    mov dword [spstr + sched_param.sched_priority], 0 ; must be 0 here

    mov rax, 144          ;  sys_setscheduler
    mov rdi, 0            
    mov rsi, SCHED_BATCH
    mov rdx, spstr
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

section .bss
    spstr resb sched_param_size
