; linuxthor
;
; sys_settimeofday example
;
; assemble with:
; nasm -f elf64 -o sys_settimeofday.o sys_settimeofday.asm
; ld sys_settimeofday.o -o sys_settimeofday 

BITS 64

struc timeval
    .tv_sec   resq 1 
    .tv_usec  resq 1
endstruc

global _start
_start:
    mov rax, 96           ;  sys_gettimeofday
    mov rdi, tvstr
    mov rsi, 0            
    syscall

    mov rax, 164          ;  sys_settimeofday
    mov rdi, tvstr
    mov rsi, 0
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

section .bss
    tvstr resb timeval_size
