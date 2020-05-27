; linuxthor
;
; sys_listxattr example
;
; list extended attributes
;
; assemble with:
; nasm -f elf64 -o sys_listxattr.o sys_listxattr.asm
; ld sys_listxattr.o -o sys_listxattr 

BITS 64

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
    mov rsi, xattrname 
    mov rdx, xattrvals
    mov r10, 26
    mov r8,  0
    syscall 

    mov rax, 194          ;  sys_listxattr
    mov rdi, filename
    mov rsi, result
    mov rdx, 4096
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

section .data
    filename    db '/tmp/somesomesome',0    
    xattrname   db 'user.bumgarden',0          
    xattrvals   db 'abcdefghijklmnopqrstuvwxyz'

section .bss
    result  resb 4096
