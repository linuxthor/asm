; linuxthor
;
; sys_mknod example
;
; assemble with:
; nasm -f elf64 -o sys_mknod.o sys_mknod.asm
; ld sys_mknod.o -o sys_mknod 

BITS 64

%define S_IFSOCK 0140000o
%define S_IFLNK	 0120000o
%define S_IFREG  0100000o
%define S_IFBLK  0060000o
%define S_IFDIR  0040000o
%define S_IFCHR  0020000o
%define S_IFIFO  0010000o
%define S_ISUID  0004000o
%define S_ISGID  0002000o
%define S_ISVTX  0001000o

global _start
_start:
    mov rax, 133          ;  sys_mknod
    mov rdi, filename
    mov rsi, (S_IFIFO|0666o)
    mov rdx, 0
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

section .data
    filename db '/tmp/iamasupernod',0
