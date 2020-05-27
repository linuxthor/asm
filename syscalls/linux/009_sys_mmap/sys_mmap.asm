; linuxthor
;
; sys_mmap example
;
; assemble with:
; nasm -f elf64 -o sys_mmap.o sys_mmap.asm
; ld sys_mmap.o -o sys_mmap

BITS 64

; sys_open
%define O_RDONLY 0
%define O_WRONLY 1
%define O_RDWR   2

; sys_mmap
%define PROT_READ    0x01
%define PROT_WRITE   0x02
%define PROT_EXEC    0x04
%define PROT_NONE    0x00

; must have one of..
%define MAP_SHARED   0x01
%define MAP_PRIVATE  0x02

; can OR one or more of..
%define MAP_FIXED               0x10		
%define MAP_ANONYMOUS           0x20		
%define MAP_POPULATE            0x008000	
%define MAP_NONBLOCK            0x010000	
%define MAP_STACK               0x020000	
%define MAP_HUGETLB             0x040000
%define MAP_SYNC                0x080000 
%define MAP_FIXED_NOREPLACE     0x100000

global _start
_start:
    mov rax, 2            ;  sys_open
    mov rdi, filename
    mov rsi, O_RDONLY
    syscall

    mov [fd], rax

    mov rax, 9            ;  sys_mmap
    mov rdi, 0            ;  NULL to let kernel decide 
    mov rsi, 512          ;  length
    mov rdx, PROT_READ
    mov r10, MAP_PRIVATE   
    mov r8, [fd]
    mov r9, 0             ;  offset
    syscall                   

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

section .data
    filename db '/etc/passwd',0

section .bss
    fd  resb 1
