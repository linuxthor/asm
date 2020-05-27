; linuxthor
;
; sys_listen example
;
; assemble with:
; nasm -f elf64 -o sys_listen.o sys_listen.asm
; ld sys_listen.o -o sys_listen

BITS 64

%define htons(x) ((x >> 8) & 0xFF) | ((x & 0xFF) << 8)

%define INADDR_ANY 0

struc sockaddr_in
    .sin_family resw 1
    .sin_port   resw 1
    .sin_addr   resd 1
    .padding    resq 1
endstruc

; sys_socket
%define AF_INET         2
%define SOCK_STREAM	1

global _start
_start:
    mov rax, 41           ;  sys_socket
    mov rdi, AF_INET
    mov rsi, SOCK_STREAM
    mov rdx, 0
    syscall 

    mov [sfd], rax

    mov word  [socket2me + sockaddr_in.sin_family], AF_INET
    mov word  [socket2me + sockaddr_in.sin_port], htons(8888)
    mov dword [socket2me + sockaddr_in.sin_addr], INADDR_ANY

    mov rax, 49           ;  sys_bind
    mov rdi, [sfd]
    mov rsi, socket2me
    mov rdx, 16
    syscall

    mov rax, 50           ;  sys_listen
    mov rdi, [sfd]
    mov rsi, 10
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

section .bss
    sfd resq 1
    socket2me resb sockaddr_in_size
