; linuxthor
;
; sys_rt_sigaction example
;
; This one is nuts
;
; assemble with:
; nasm -f elf64 -o sys_rt_sigaction.o sys_rt_sigaction.asm
; ld sys_rt_sigaction.o -o sys_rt_sigaction

BITS 64

%define SIGHUP           1
%define SIGINT           2
%define SIGQUIT          3
%define SIGILL           4
%define SIGTRAP          5
%define SIGABRT          6
%define SIGBUS           7
%define SIGFPE           8
%define SIGUSR1	        10
%define SIGSEGV	        11
%define SIGUSR2	        12
%define SIGPIPE	        13
%define SIGALRM	        14
%define SIGTERM	        15
%define SIGSTKFLT       16
%define SIGCHLD         17
%define SIGCONT	        18
%define SIGTSTP	        20
%define SIGTTIN	        21
%define SIGTTOU	        22
%define SIGURG	        23
%define SIGXCPU	        24
%define SIGXFSZ	        25
%define SIGVTALRM       26
%define SIGPROF	        27
%define SIGWINCH        28
%define SIGIO           29

%define SIG_DFL          0
%define SIG_IGN          1
%define SIG_ERR         -1

struc sigaction
    .sa_handler  resq 1
    .sa_sigacti  resq 1
    .sa_mask     resq 1
    .sa_flag     resq 1 
    .sa_restore  resq 1
endstruc

global _start
_start:
    mov rax, 13           ;  sys_rt_sigaction
    mov rdi, SIGSEGV
    mov qword [sastr + sigaction.sa_handler], SIG_IGN
    mov rsi, sastr
    mov rdx, 0
    mov r10, 8            ;  sort of sizeof(sigset_t).. ;-)  
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

section .bss
    sastr resb sigaction_size
