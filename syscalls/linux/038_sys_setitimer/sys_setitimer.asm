; linuxthor
;
; sys_setitimer example
;
; assemble with:
; nasm -f elf64 -o sys_setitimer.o sys_setitimer.asm
; ld sys_setitimer.o -o sys_setitimer 

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
    mov qword [my_timr + it_interval], 2

    mov rax, 38           ;  sys_setitimer
    mov rdi, ITIMER_REAL
    mov rsi, my_timr
    mov rdx, 0
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

section .bss
    my_timr resb itimerval_size
