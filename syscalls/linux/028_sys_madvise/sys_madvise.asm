; linuxthor
;
; sys_madvise example
;
; assemble with:
; nasm -f elf64 -o sys_madvise.o sys_madvise.asm
; ld sys_madvise.o -o sys_madvise

BITS 64

%define MADV_NORMAL	0
%define MADV_RANDOM	1
%define MADV_SEQUENTIAL	2
%define MADV_WILLNEED	3	
%define MADV_DONTNEED	4		

; sys_open
%define O_RDONLY 0

; sys_mmap
%define PROT_READ    0x01
%define MAP_PRIVATE  0x02

global _start
_start:
    mov rax, 2            ;  sys_open
    mov rdi, filename
    mov rsi, O_RDONLY
    syscall

    mov [fd], rax

    mov rax, 9            ;  sys_mmap
    mov rdi, 0            
    mov rsi, 4096         
    mov rdx, PROT_READ
    mov r10, MAP_PRIVATE   
    mov r8, [fd]
    mov r9, 0            
    syscall                   

    mov rdi, rax

    mov rax, 28           ;  sys_madvise
    mov rsi, 4096
    mov rdx, MADV_DONTNEED
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

section .data
    filename db '/etc/passwd',0

section .bss
    fd  resb 1
