; linuxthor
;
; sys_lgetxattr example
;
; get some extended attributes on a soft link 
;
; assemble with:
; nasm -f elf64 -o sys_lgetxattr.o sys_lgetxattr.asm
; ld sys_lgetxattr.o -o sys_lgetxattr 

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

    mov rax, 192          ;  sys_lgetxattr
    mov rdi, filename2
    mov rsi, xattrname
    mov rdx, result
    mov r10, 4096
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

section .data
    filename1   db '/tmp/somethingmeaty',0    
    filename2   db '/tmp/somethingsilky',0
    xattrname   db 'security.obscurity',0          ; can't use user. with link(?)
    xattrvals   db 'abcdefghijklmnopqrstuvwxyz'

section .bss
    result  resb 4096
