; linuxthor
;
; sys_epoll_create example
;
; assemble with:
; nasm -f elf64 -o sys_epoll_create.o sys_epoll_create.asm
; ld sys_epoll_create.o -o sys_epoll_create

BITS 64

global _start
_start:
    mov rax, 213          ;  sys_epoll_create
    mov rdi, 101          ;  size (ignored-ish - cannot be 0)
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall
