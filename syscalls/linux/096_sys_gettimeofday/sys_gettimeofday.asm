; linuxthor
;
; sys_gettimeofday example
;
; assemble with:
; nasm -f elf64 -o sys_gettimeofday.o sys_gettimeofday.asm
; ld sys_gettimeofday.o -o sys_gettimeofday 

BITS 64

struc timeval
    .tv_sec   resq 1 
    .tv_usec  resq 1
endstruc

global _start
_start:
    mov rax, 96           ;  sys_gettimeofday
    mov rdi, tvstr
    mov rsi, 0            ;  obsolete timezone field
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

section .bss
    tvstr resb timeval_size
