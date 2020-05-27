; linuxthor
;
; sys_connect example
;
; assemble with:
; nasm -f elf64 -o sys_connect.o sys_connect.asm
; ld sys_connect.o -o sys_connect

BITS 64

%define htons(x) ((x >> 8) & 0xFF) | ((x & 0xFF) << 8)

struc sockaddr_in
    .sin_family  resw 1
    .sin_port    resw 1   ; __be16
    .sin_addr    resd 1
    .padding     resq 1
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

    mov rdi, rax
 
    mov word  [socket2me + sockaddr_in.sin_family], AF_INET
    mov word  [socket2me + sockaddr_in.sin_port], htons(80)
    mov dword [socket2me + sockaddr_in.sin_addr], 0x0A00000A

    mov rax, 42           ;  sys_connect
    mov rsi, socket2me
    mov rdx, 16
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

section .bss
    socket2me resb sockaddr_in_size
