; linuxthor
;
; sys_mincore example
;
; see if some page is currently resident in memory
;
; assemble with:
; nasm -f elf64 -o sys_mincore.o sys_mincore.asm
; ld sys_mincore.o -o sys_mincore

BITS 64

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
    mov rsi, 512          
    mov rdx, PROT_READ
    mov r10, MAP_PRIVATE   
    mov r8, [fd]
    mov r9, 0            
    syscall                   

    mov rdi, rax

    mov rax, 27           ;  sys_mincore
    mov rsi, 512
    mov rdx, vector
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

section .data
    filename db '/etc/passwd',0

section .bss
    fd     resb 1 
    ; at least (len + PAGE_SIZE-1) / PAGE_SIZE bytes:
    vector resq 1
