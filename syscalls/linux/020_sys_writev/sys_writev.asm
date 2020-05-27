; linuxthor
;
; sys_writev example
;
; assemble with:
; nasm -f elf64 -o sys_writev.o sys_writev.asm
; ld sys_writev.o -o sys_writev 

BITS 64

struc iovec
    .iov_base  resq 1
    .iov_len   resq 1
endstruc

global _start
_start:
    mov qword [vectors0 + iovec.iov_base], string0
    mov qword [vectors0 + iovec.iov_len], 5
    mov qword [vectors1 + iovec.iov_base], string1
    mov qword [vectors1 + iovec.iov_len], 3

    mov rax, 20           ;  sys_writev
    mov rdi, 1
    mov rsi, vectors0
    mov rdx, 2
    syscall 

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

section .data
    string0   db 'Hiya!',0
    string1   db '!',0x0d,0x0a,0    

section .bss
    vectors0  resb  iovec_size
    vectors1  resb  iovec_size
