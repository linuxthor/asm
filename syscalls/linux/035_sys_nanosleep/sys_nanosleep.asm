; linuxthor
;
; sys_nanosleep example
;
; assemble with:
; nasm -f elf64 -o sys_nanosleep.o sys_nanosleep.asm
; ld sys_nanosleep.o -o sys_nanosleep 

BITS 64

struc timespec
    .tv_sec    resq 1
    .tv_nsec   resq 1
endstruc

global _start
_start:
    mov qword [timez + timespec.tv_sec], 5
    mov qword [timez + timespec.tv_nsec], 150

    mov rax, 35           ;  sys_nanosleep
    mov rdi, timez
    mov rsi, 0            ;  NULL or some timespc space
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

section .bss
    timez  resb timespec_size
