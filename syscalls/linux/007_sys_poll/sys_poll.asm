; linuxthor
;
; sys_poll example
;
; assemble with:
; nasm -f elf64 -o sys_poll.o sys_poll.asm
; ld sys_poll.o -o sys_poll 

BITS 64

%define POLLIN		0x001
%define POLLPRI		0x002
%define POLLOUT		0x004
%define POLLMSG	        0x400
%define POLLREMOVE      0x1000
%define POLLRDHUP       0x2000
%define POLLERR	        0x008	
%define POLLHUP	        0x010		
%define POLLNVAL        0x020		

struc pollfd
    .fd      resd 1
    .events  resw 1
    .revent  resw 1
endstruc

global _start
_start:
    mov dword [pollst + pollfd.fd], 0
    mov word  [pollst + pollfd.events], POLLIN

again:
    mov rax, 7            ;  sys_poll
    mov rdi, pollst
    mov rsi, 1            ;  number of fd
    mov rdx, 666          ;  timeout in ms
    syscall

    cmp rax, 0            ;  TIMEOUT
    je again

    mov rdi, rax

    mov rax, 60           ;  sys_exit
    syscall

section .bss
    pollst  resb pollfd_size
