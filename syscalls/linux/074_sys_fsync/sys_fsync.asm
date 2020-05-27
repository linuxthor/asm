; linuxthor
;
; sys_fsync example
;
; synchronise a file with the storage device
;
; assemble with:
; nasm -f elf64 -o sys_fsync.o sys_fsync.asm
; ld sys_fsync.o -o sys_fsync 

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
    mov rdx, 26
    syscall

    mov rax, 74           ;  sys_fsync
    mov rdi, [fd]
    syscall

    mov rax, 60           ;  sys_exit
    syscall

section .data
    filename   db '/tmp/tebahpla',0    
    somedata   db 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    
section .bss
    fd  resb 1
