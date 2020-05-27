; linuxthor
;
; sys_fsetxattr example
;
; assemble with:
; nasm -f elf64 -o sys_fsetxattr.o sys_fsetxattr.asm
; ld sys_fsetxattr.o -o sys_fsetxattr 

BITS 64

%define O_MODES 0x42      ;  O_RDWR|O_CREAT

global _start
_start:
    mov rax, 2            ;  sys_open
    mov rdi, filename 
    mov rsi, O_MODES      
    mov rdx, 0644o
    syscall 

    mov rdi, rax

    mov rax, 190          ;  sys_fsetxattr
    mov rsi, attrname
    mov rdx, attrdata
    mov r10, 26
    mov r8, 0
    syscall 

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

section .data
    filename   db '/tmp/underover',0
    attrname   db 'user.someattrs',0
    attrdata   db 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
