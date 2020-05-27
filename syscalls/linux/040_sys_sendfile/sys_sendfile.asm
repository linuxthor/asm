; linuxthor
;
; sys_sendfile example
;
; copy some data between fds within the kernel
;
; assemble with:
; nasm -f elf64 -o sys_sendfile.o sys_sendfile.asm
; ld sys_sendfile.o -o sys_sendfile

BITS 64

; sys_open
%define O_RDONLY 0
%define O_WRONLY 1
%define O_RDWR   2
%define O_MODES  0x42     ; O_RDWR|O_CREAT

global _start
_start:
    mov rax, 2            ;  sys_open
    mov rdi, filename0
    mov rsi, O_RDONLY
    syscall

    mov [fd0], rax

    mov rax, 2            ;  sys_open
    mov rdi, filename1
    mov rsi, O_MODES
    mov rdx, 0666o
    syscall 

    mov [fd1], rax

    mov rax, 40           ;  sys_sendfile
    mov rdi, [fd1]
    mov rsi, [fd0]
    mov rdx, 0            ;  offset
    mov r10, 128          ;  count
    syscall

    mov rax, 60           ;  sys_exit
    syscall

section .data
    filename0   db '/etc/passwd',0    
    filename1   db '/tmp/mungoo',0

section .bss  
    fd0 resq  1
    fd1 resq  1
