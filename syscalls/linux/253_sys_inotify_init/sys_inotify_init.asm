; linuxthor
;
; sys_inotify_init example
;
; assemble with:
; nasm -f elf64 -o sys_inotify_init.o sys_inotify_init.asm
; ld sys_inotify_init.o -o sys_inotify_init 

BITS 64

global _start
_start:
    mov rax, 253          ;  sys_inotify_init 
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall
