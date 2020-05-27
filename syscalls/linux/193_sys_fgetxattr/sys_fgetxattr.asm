; linuxthor
;
; sys_fgetxattr example
;
; assemble with:
; nasm -f elf64 -o sys_fgetxattr.o sys_fgetxattr.asm
; ld sys_fgetxattr.o -o sys_fgetxattr 

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

    mov rax, 193          ;  sys_fgetxattr
    mov rdi, [fd]
    mov rsi, attrname
    mov rdx, result
    mov r10, 4096
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

section .data
    filename   db '/tmp/ohohohyes',0
    attrname   db 'user.easybeefy',0
    attrdata   db 'ABCDEFGH1JKLMN0PQRSTUVWXYZ'

section .bss
    fd      resb 1
    result  resb 4096
