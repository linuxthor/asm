; linuxthor
;
; sys_timerfd_create example
;
; assemble with:
; nasm -f elf64 -o sys_timerfd_create.o sys_timerfd_create.asm
; ld sys_timerfd_create.o -o sys_timerfd_create 

BITS 64

%define CLOCK_REALTIME	          0
%define CLOCK_MONOTONIC           1
%define CLOCK_PROCESS_CPUTIME_ID  2
%define CLOCK_THREAD_CPUTIME_ID	  3
%define CLOCK_MONOTONIC_RAW	  4
%define CLOCK_REALTIME_COARSE     5
%define CLOCK_MONOTONIC_COARSE    6
%define CLOCK_BOOTTIME            7
%define CLOCK_REALTIME_ALARM      8
%define CLOCK_BOOTTIME_ALARM      9

global _start
_start:

    mov rax, 283          ;  sys_timerfd_create
    mov rdi, CLOCK_MONOTONIC
    mov rsi, 0
    syscall 

    mov rdi, rax

    mov rax, 60           ;  sys_exit
    syscall

