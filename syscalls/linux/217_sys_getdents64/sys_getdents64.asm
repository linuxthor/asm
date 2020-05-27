; linuxthor
;
; sys_getdents64 example
;
; fills a buffer with a number of the struct linux_dirent64.. 
;
;   struct linux_dirent64 {
;       ino64_t        d_ino;    /* 64-bit inode number */
;       off64_t        d_off;    /* 64-bit offset to next structure */
;       unsigned short d_reclen; /* Size of this dirent */
;       unsigned char  d_type;   /* File type */
;       char           d_name[]; /* Filename (null-terminated) */
;   };
;
; assemble with:
; nasm -f elf64 -o sys_getdents64.o sys_getdents64.asm
; ld sys_getdents64.o -o sys_getdents64 

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

    mov rax, 217          ;  sys_getdents64
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
