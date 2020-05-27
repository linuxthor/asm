; linuxthor
;
; sys_utimes example
;
; set to some values or null for current time
;
; assemble with:
; nasm -f elf64 -o sys_utimes.o sys_utimes.asm
; ld sys_utimes.o -o sys_utimes 

BITS 64

struc utimes
    .tv_sec0   resd 1       ; access time
    .tv_usec0  resd 1       ; <---'
    .tv_sec1   resd 1       ; modification time
    .tv_usec1  resd 1       ; <---'
endstruc

; sys_open
%define O_MODES 0x42

global _start
_start:
    mov rax, 2            ;  sys_open
    mov rdi, filename
    mov rsi, O_MODES
    mov rdx, 0666o
    syscall 

    mov rax, 235          ;  sys_utimes
    mov rdi, filename
    mov rsi, utims
    syscall 

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

section .data
    filename   db '/tmp/timesr',0    

section .bss
    utims resb utimes_size

