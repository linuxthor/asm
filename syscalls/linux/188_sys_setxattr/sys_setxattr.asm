; linuxthor
;
; sys_setxattr example
;
; set some extended attribute
;
; assemble with:
; nasm -f elf64 -o sys_setxattr.o sys_setxattr.asm
; ld sys_setxattr.o -o sys_setxattr 

BITS 64

%define XATTR_CREATE 0x1
%define XATTR_REPLACE 0x2 

%define O_MODES 0x42      ;  O_RDWR|O_CREAT

global _start
_start:
    mov rax, 2            ;  sys_open
    mov rdi, filename 
    mov rsi, O_MODES      
    mov rdx, 0644o
    syscall 

    mov rax, 188          ;  sys_setxattr
    mov rdi, filename
    mov rsi, attrname
    mov rdx, valueatt
    mov r10, 26
    mov r8,  0
    syscall 

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

section .data
    filename   db '/tmp/somefilen',0   
    attrname   db 'user.something',0 
    valueatt   db 'abcdefghijklmnopqrstuvwxyz'
