; linuxthor
;
; sys_socket example
;
; assemble with:
; nasm -f elf64 -o sys_socket.o sys_socket.asm
; ld sys_socket.o -o sys_socket 

BITS 64

%define AF_UNIX         1	
%define AF_LOCAL        AF_UNIX
%define AF_INET         2
%define AF_INET6        10
%define AF_NETLINK      16
%define AF_PACKET       17
%define AF_BLUETOOTH    31

%define SOCK_STREAM	1
%define SOCK_DGRAM	2
%define SOCK_RAW	3
%define SOCK_RDM	4	
%define SOCK_SEQPACKET	5	
%define SOCK_PACKET	10

global _start
_start:
    mov rax, 41           ;  sys_socket
    mov rdi, AF_INET
    mov rsi, SOCK_STREAM
    mov rdx, 0
    syscall 

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

