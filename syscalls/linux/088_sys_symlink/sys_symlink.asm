; linuxthor
;
; sys_symlink example
;
; create a soft link 
;
; assemble with:
; nasm -f elf64 -o sys_symlink.o sys_symlink.asm
; ld sys_symlink.o -o sys_symlink 

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

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

section .data
    filename1   db '/tmp/caughtinalandslide',0    
    filename2   db '/tmp/noescapefrmreality',0
