; linuxthor
;
; sys_fdatasync example
;
; synchronise a file with the storage device
; (significant changes only - e.g size change)
;
; assemble with:
; nasm -f elf64 -o sys_fdatasync.o sys_fdatasync.asm
; ld sys_fdatasync.o -o sys_fdatasync 

BITS 64

%define O_MODES 0x42      ; O_RDWR|O_CREAT

global _start
_start:

    mov rax, 2            ;  sys_open
    mov rdi, filename
    mov rsi, O_MODES
    syscall 

    mov [fd], rax

    mov rax, 1            ;  sys_write
    mov rdi, [fd]
    mov rsi, somedata
    mov rdx, 27
    syscall

    mov rax, 75           ;  sys_fdatasync
    mov rdi, [fd]
    syscall

    mov rax, 60           ;  sys_exit
    syscall

section .data
    filename   db '/tmp/alpha0',0    
    somedata   db 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0'
    
section .bss
    fd  resb 1
