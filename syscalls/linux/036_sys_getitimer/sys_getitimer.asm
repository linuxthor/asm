; linuxthor
;
; sys_getitimer example
;
; assemble with:
; nasm -f elf64 -o sys_getitimer.o sys_getitimer.asm
; ld sys_getitimer.o -o sys_getitimer 

BITS 64

struc itimerval 
    it_interval  resq 2
    it_value     resq 2	
endstruc

%define	ITIMER_REAL       0
%define	ITIMER_VIRTUAL    1
%define	ITIMER_PROF       2

global _start
_start:
    mov rax, 36           ;  sys_getitimer
    mov rdi, ITIMER_REAL
    mov rsi, curr_timr
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

section .bss
    curr_timr resb itimerval_size
