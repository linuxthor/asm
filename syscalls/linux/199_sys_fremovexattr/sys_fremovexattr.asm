; linuxthor
;
; sys_fremovexattr example
;
; assemble with:
; nasm -f elf64 -o sys_fremovexattr.o sys_fremovexattr.asm
; ld sys_fremovexattr.o -o sys_fremovexattr 

BITS 64

%define O_MODES 0x42      ;  O_RDWR|O_CREAT

global _start
_start:
    mov rax, 2            ;  sys_open
    mov rdi, filename 
    mov rsi, O_MODES      
    mov rdx, 0644o
    syscall 

    mov [fd], rax

    mov rax, 190          ;  sys_fsetxattr
    mov rdi, [fd]
    mov rsi, attrname
    mov rdx, attrdata
    mov r10, 26
    mov r8, 0
    syscall 

    mov rax, 199          ;  sys_fremovexattr
    mov rdi, [fd]
    mov rsi, attrname
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

section .data
    filename   db '/tmp/mmmmmbeef',0
    attrname   db 'user.beefyface',0
    attrdata   db 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'

section .bss
    fd  resb 1
