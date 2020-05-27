; linuxthor
;
; sys_getdents example
;
; fills a buffer with a number of the struct linux_dirent.. 
;
;   struct linux_dirent {
;       unsigned long  d_ino;     /* Inode number */
;       unsigned long  d_off;     /* Offset to next linux_dirent */
;       unsigned short d_reclen;  /* Length of this linux_dirent */
;       char           d_name[];  /* Filename (null-terminated) */
;			 /* length is actually (d_reclen - 2 -
;			    offsetof(struct linux_dirent, d_name)) */
;       /*
;       char           pad;       // Zero padding byte
;       char           d_type;    // File type (only since Linux
;				 // 2.6.4); offset is (d_reclen - 1)
;       */
;   }
;
; assemble with:
; nasm -f elf64 -o sys_getdents.o sys_getdents.asm
; ld sys_getdents.o -o sys_getdents

BITS 64

; sys_open
%define O_RDONLY 0

global _start
_start:
    mov rax, 2            ;  sys_open
    mov rdi, dir
    mov rsi, O_RDONLY
    syscall

    mov rdi, rax

    mov rax, 78           ;  sys_getdents
    mov rsi, dirents
    mov rdx, 4096
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

section .data
    dir db '/usr/bin',0

section .bss
    dirents resb 4096   
