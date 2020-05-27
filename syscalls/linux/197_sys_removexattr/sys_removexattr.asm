; linuxthor
;
; sys_removexattr example
;
; remove some extended attribute
;
; assemble with:
; nasm -f elf64 -o sys_removexattr.o sys_removexattr.asm
; ld sys_removexattr.o -o sys_removexattr 

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
 
    mov rax, 197          ;  sys_removexattr
    mov rdi, filename
    mov rsi, attrname
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

section .data
    filename   db '/tmp/somefilez',0   
    attrname   db 'user.somesome1',0 
    valueatt   db 'abcdefghijklmnopqrstuvwxyz'
