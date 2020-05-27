; linuxthor
;
; sys_timer_create example
;
; assemble with:
; nasm -f elf64 -o sys_timer_create.o sys_timer_create.asm
; ld sys_timer_create.o -o sys_timer_create 

BITS 64

struc sigevent
    .sigev_value resq 1
    .sigev_signo resd 1 
    .sigev_notif resd 1
    .sigev_un    resb 48
endstruc

%define CLOCK_REALTIME              0
%define CLOCK_MONOTONIC	            1
%define CLOCK_PROCESS_CPUTIME_ID    2
%define CLOCK_THREAD_CPUTIME_ID     3
%define CLOCK_MONOTONIC_RAW         4
%define CLOCK_REALTIME_COARSE       5
%define CLOCK_MONOTONIC_COARSE      6
%define CLOCK_BOOTTIME	            7
%define CLOCK_REALTIME_ALARM        8
%define CLOCK_BOOTTIME_ALARM        9

%define SIGEV_NONE                  1  
%define SIGEV_SIGNAL                2  
%define SIGEV_THREAD                3  

global _start
_start:
    mov dword [sigev + sigevent.sigev_notif], SIGEV_NONE

    mov rax, 222          ;  sys_timer_create
    mov rdi, CLOCK_MONOTONIC 
    mov rsi, sigev
    mov rdx, tval
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, [tval]
    syscall

section .bss
    sigev resb sigevent_size
    tval  resq 1
