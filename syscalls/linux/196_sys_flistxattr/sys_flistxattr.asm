; linuxthor
;
; sys_flistxattr example
;
; assemble with:
; nasm -f elf64 -o sys_flistxattr.o sys_flistxattr.asm
; ld sys_flistxattr.o -o sys_flistxattr 

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

    mov rax, 196          ;  sys_flistxattr
    mov rdi, [fd]
    mov rsi, result
    mov rdx, 4096
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

section .data
    filename   db '/tmp/undulate',0
    attrname   db 'user.someunds',0
    attrdata   db 'ABCDEFGHIJKLMN0PQRSTUVWXYZ'

section .bss
    fd      resb 1
    result  resb 4096
