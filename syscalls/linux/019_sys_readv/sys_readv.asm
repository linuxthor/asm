; linuxthor
;
; sys_readv example
;
; assemble with:
; nasm -f elf64 -o sys_readv.o sys_readv.asm
; ld sys_readv.o -o sys_readv 

BITS 64

; sys_open
%define O_RDONLY 0
%define O_WRONLY 1
%define O_RDWR   2 

struc iovec
    .iov_base  resq 1
    .iov_len   resq 1
endstruc

global _start
_start:
    mov qword [vectors0 + iovec.iov_base], data0
    mov qword [vectors0 + iovec.iov_len],  32
    mov qword [vectors1 + iovec.iov_base], data1
    mov qword [vectors1 + iovec.iov_len],  32

    mov rax, 2            ;  sys_open
    mov rdi, filename
    mov rsi, O_RDONLY
    syscall

    mov rdi, rax 

    mov rax, 19           ;  sys_readv
    mov rsi, vectors0
    mov rdx, 2
    syscall 

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

section .data
    filename  db '/etc/passwd',0

section .bss
    vectors0  resb  iovec_size
    vectors1  resb  iovec_size
    data0     resb  32
    data1     resb  32
