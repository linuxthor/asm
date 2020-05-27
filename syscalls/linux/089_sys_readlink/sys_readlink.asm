; linuxthor
;
; sys_readlink example
;
; resolve a symbolic link 
;
; assemble with:
; nasm -f elf64 -o sys_readlink.o sys_readlink.asm
; ld sys_readlink.o -o sys_readlink 

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

    mov rax, 89           ;  sys_readlink
    mov rdi, filename2
    mov rsi, rlbuf        ;  result placed in buffer *not*
    mov rdx, 4096         ;  including terminating null byte
    syscall

    mov rdx, rax          ;  return is length of result 

    mov rax, 1            ;  sys_write
    mov rdi, 1            
    mov rsi, rlbuf 
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

section .data
    filename1   db '/tmp/caughtinalandslide',0    
    filename2   db '/tmp/noescapefrmreality',0

section .bss
    rlbuf  resb  4096
