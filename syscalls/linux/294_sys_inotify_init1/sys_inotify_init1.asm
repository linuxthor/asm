; linuxthor
;
; sys_inotify_init1 example
;
; assemble with:
; nasm -f elf64 -o sys_inotify_init1.o sys_inotify_init1.asm
; ld sys_inotify_init1.o -o sys_inotify_init1 

BITS 64

%define IN_NONBLOCK   0x80000
%define IN_CLOEXEC    0x800

global _start
_start:
    mov rax, 294          ;  sys_inotify_init1 
    mov rdi, IN_NONBLOCK
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall
