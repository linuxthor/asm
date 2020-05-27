; linuxthor
;
; sys_sched_setparam example
;
; assemble with:
; nasm -f elf64 -o sys_sched_setparam.o sys_sched_setparam.asm
; ld sys_sched_setparam.o -o sys_sched_setparam 

BITS 64

struc sched_param
    .sched_priority resd 1
endstruc

global _start
_start:
    ; ?? not much useful here ??
    mov dword [spst + sched_param.sched_priority], 0 

    mov rax, 142          ;  sys_sched_setparam
    mov rdi, 0
    mov rsi, spst
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

section .bss
    spst resb sched_param_size
