; linuxthor
;
; sys_msync example
;
; synchronise ye file with a memory map
;
; assemble with:
; nasm -f elf64 -o sys_msync.o sys_msync.asm
; ld sys_msync.o -o sys_msync

BITS 64

%define MS_ASYNC       1                
%define MS_SYNC        4               
%define MS_INVALIDATE  2               

; sys_open
%define O_FLAGS   0x42             ;  O_RDWR|O_CREAT

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
    mov rsi, O_FLAGS
    syscall

    mov [fd], rax

    mov rax, 9            ;  sys_mmap
    mov rdi, 0            ;  NULL to let kernel decide 
    mov rsi, 512          ;  length
    mov rdx, PROT_WRITE
    mov r10, MAP_PRIVATE   
    mov r8, [fd]
    mov r9, 0             ;  offset
    syscall                   

    mov rdi, rax

    mov rax, 26           ;  sys_msync
    mov rsi, 512
    mov rdx, MS_ASYNC 
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

section .data
    filename db '/tmp/fungus',0

section .bss
    fd  resb 1
