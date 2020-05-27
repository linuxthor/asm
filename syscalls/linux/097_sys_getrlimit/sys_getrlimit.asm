; linuxthor
;
; sys_getrlimit example
;
; assemble with:
; nasm -f elf64 -o sys_getrlimit.o sys_getrlimit.asm
; ld sys_getrlimit.o -o sys_getrlimit 

BITS 64

struc rlimit
    .rlim_cur  resq 1
    .rlim_max  resq 1
endstruc

%define RLIMIT_CPU        0
%define RLIMIT_FSIZE      1
%define RLIMIT_DATA       2
%define RLIMIT_STACK      3
%define RLIMIT_CORE       4
%define RLIMIT_RSS        5
%define RLIMIT_NPROC      6
%define RLIMIT_NOFILE     7
%define RLIMIT_MEMLOCK    8
%define RLIMIT_AS         9
%define RLIMIT_LOCKS      10
%define RLIMIT_SIGPENDING 11
%define RLIMIT_MSGQUEUE   12
%define RLIMIT_NICE       13
%define RLIMIT_RTPRIO     14
%define RLIMIT_RTTIME     15
%define RLIMIT_NLIMITS    16

global _start
_start:
    mov rax, 97           ;  sys_getrlimit
    mov rdi, RLIMIT_NOFILE 
    mov rsi, rlimstr 
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, [rlimstr + rlimit.rlim_cur]
    syscall

section .bss
    rlimstr resb rlimit_size

