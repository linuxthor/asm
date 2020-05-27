; linuxthor
;
; sys_statfs example
;
; assemble with:
; nasm -f elf64 -o sys_statfs.o sys_statfs.asm
; ld sys_statfs.o -o sys_statfs 

BITS 64

struc statfs
    .f_type      resq 1
    .f_bsize     resq 1
    .f_blocks    resq 1
    .f_bfree     resq 1
    .f_bavail    resq 1
    .f_files     resq 1
    .f_ffree     resq 1
    .f_fsid      resq 1
    .f_namelen   resq 1
    .f_frsize    resq 1
    .f_flags     resq 1
    .f_spare     resq 4
endstruc

global _start
_start:

    mov rax, 137          ;  sys_statfs
    mov rdi, pathname
    mov rsi, statstruc
    syscall 

    mov rdi, [statstruc + statfs.f_frsize]

    mov rax, 60           ;  sys_exit
    syscall

section .data
    pathname db '/etc/issue',0

section .bss
    statstruc  resb  statfs_size
