; linuxthor
;
; sys_epoll_ctl example
;
; assemble with:
; nasm -f elf64 -o sys_epoll_ctl.o sys_epoll_ctl.asm
; ld sys_epoll_ctl.o -o sys_epoll_ctl

BITS 64

struc epoll_event
    .events resd 1
    .data   resd 3
endstruc

%define EPOLL_CTL_ADD 1        
%define EPOLL_CTL_DEL 2        
%define EPOLL_CTL_MOD 3        

%define EPOLLIN  0x001
%define EPOLLPRI 0x002
%define EPOLLOUT 0x004

global _start
_start:
    mov rax, 213          ;  sys_epoll_create
    syscall

    mov rdi, rax
 
    mov rax, 233          ;  sys_epoll_ctl
    mov rsi, EPOLL_CTL_ADD
    mov rdx, 0
    mov dword [epollevt + epoll_event.events], EPOLLIN
    mov r10, epollevt
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

section .bss
    epollevt resb epoll_event_size
