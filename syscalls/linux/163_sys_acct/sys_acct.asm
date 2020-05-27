; linuxthor
;
; sys_acct example
;
; enable process accounting and store information
; in a previously created file
;
; assemble with:
; nasm -f elf64 -o sys_acct.o sys_acct.asm
; ld sys_acct.o -o sys_acct 

BITS 64

; sys_open
%define O_MODES 0x42

global _start
_start:
    mov rax, 2            ;  sys_open
    mov rdi, filename
    mov rsi, O_MODES
    mov rdx, 666o
    syscall 

    mov rax, 163          ;  sys_acct
    mov rdi, filename     ;  switch on
    syscall

    mov rax, 163          ;  sys_acct
    mov rdi, 0            ;  switch off
    syscall

    mov rax, 60           ;  sys_exit
    syscall

section .data
    filename   db '/tmp/accts',0    
