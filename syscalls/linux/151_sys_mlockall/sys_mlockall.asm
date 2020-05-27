; linuxthor
;
; sys_mlockall example
;
; assemble with:
; nasm -f elf64 -o sys_mlockall.o sys_mlockall.asm
; ld sys_mlockall.o -o sys_mlockall 

BITS 64

%define MCL_CURRENT        1                
%define MCL_FUTURE         2                                                          

global _start
_start:
    mov rax, 151          ;  sys_mlockall
    mov rdi, MCL_CURRENT
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall
