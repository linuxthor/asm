; linuxthor
;
; sys_pread64 example
;
; assemble with:
; nasm -f elf64 -o sys_pread64.o sys_pread64.asm
; ld sys_pread64.o -o sys_pread64 

BITS 64

; sys_open
%define O_RDONLY 0
%define O_WRONLY 1
%define O_RDWR   2

global _start
_start:
    mov rax, 2            ;  sys_open
    mov rdi, filename
    mov rsi, O_RDONLY
    syscall

    mov rdi, rax

    mov rax, 17           ;  sys_pread64
    mov rsi, readsb       ;  buffer
    mov rdx, 16           ;  count
    mov r10, 64           ;  offset
    syscall 

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

section .data
   filename  db '/etc/passwd',0

section .bss
    readsb    resb 16    
