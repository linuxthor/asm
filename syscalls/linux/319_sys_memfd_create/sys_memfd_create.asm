; linuxthor
;
; sys_memfd_create example
;
; assemble with:
; nasm -f elf64 -o sys_memfd_create.o sys_memfd_create.asm
; ld sys_memfd_create.o -o sys_memfd_create 

BITS 64

%define MFD_CLOEXEC		0x0001
%define MFD_ALLOW_SEALING	0x0002
%define MFD_HUGETLB		0x0004

global _start
_start:
    mov rax, 319          ;  sys_memfd_create
    mov rdi, name
    mov rsi, MFD_CLOEXEC
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

section .data
    name db 'amemoryfd',0
