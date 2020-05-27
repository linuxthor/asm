; linuxthor
;
; sys_access example
;
; assemble with:
; nasm -f elf64 -o sys_access.o sys_access.asm
; ld sys_access.o -o sys_access 

BITS 64

; check if file exists..
%define	F_OK    0

; or for certain permissions..	
%define	X_OK    0x01	
%define	W_OK    0x02	
%define	R_OK    0x04	

global _start
_start:

    mov rax, 21           ;  sys_access
    mov rdi, filename
    mov rsi, F_OK
    syscall 

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

section .data
    filename   db '/bin/bash',0    
