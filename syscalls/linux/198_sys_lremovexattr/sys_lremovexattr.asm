; linuxthor
;
; sys_lremovexattr example
;
; remove some extended attributes on a soft link 
;
; assemble with:
; nasm -f elf64 -o sys_lremovexattr.o sys_lremovexattr.asm
; ld sys_removexattr.o -o sys_lremovexattr 

BITS 64

%define O_MODES 0x42      ;  O_RDWR|O_CREAT

global _start
_start:
    mov rax, 2            ;  sys_open
    mov rdi, filename1 
    mov rsi, O_MODES      
    mov rdx, 0644o
    syscall 

    mov rax, 88           ;  sys_symlink
    mov rdi, filename1
    mov rsi, filename2
    syscall 

    mov rax, 189          ;  sys_lsetxattr
    mov rdi, filename2
    mov rsi, xattrname 
    mov rdx, xattrvals
    mov r10, 26
    mov r8,  0
    syscall 

    mov rax, 198          ;  sys_lremovexattr
    mov rdi, filename2
    mov rsi, xattrname
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

section .data
    filename1   db '/tmp/somethingfood',0    
    filename2   db '/tmp/somethingdead',0
    xattrname   db 'security.obscurity',0          ; can't use user. with link(?)
    xattrvals   db 'abcdefghijklmnopqrstuvwxyz'
