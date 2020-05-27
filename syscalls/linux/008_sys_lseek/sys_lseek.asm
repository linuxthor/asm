; linuxthor
;
; sys_lseek example
;
; assemble with:
; nasm -f elf64 -o sys_lseek.o sys_lseek.asm
; ld sys_lseek.o -o sys_lseek

BITS 64

; sys_open
%define O_RDONLY 0
%define O_WRONLY 1
%define O_RDWR 2

; sys_lseek
%define SEEK_SET    0     ; set to offset	
%define	SEEK_CUR    1     ; set to position + offset
%define	SEEK_END    2     ; set to EOF + offset

global _start
_start:
    mov rax, 2            ;  sys_open
    mov rdi, filename
    mov rsi, O_RDONLY
    syscall 

    mov rdi, rax

    mov rax, 8            ;  sys_lseek
    mov rsi, 100          ;  offset
    mov rdx, SEEK_SET
    syscall

    mov rdi, rax

    mov rax, 60           ;  sys_exit
    syscall

section .data
    filename   db '/etc/passwd',0    
