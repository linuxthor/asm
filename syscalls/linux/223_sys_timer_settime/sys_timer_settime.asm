; linuxthor
;
; sys_timer_settime example
;
; assemble with:
; nasm -f elf64 -o sys_timer_settime.o sys_timer_settime.asm
; ld sys_timer_settime.o -o sys_timer_settime 

BITS 64

struc sigevent
    .sigev_value resq 1
    .sigev_signo resd 1 
    .sigev_notif resd 1
    .sigev_un    resb 48
endstruc

struc itimerspec
    .it_intvl_sec  resq 1         ; <------- interval
    .it_intvl_nsec resq 1         ;  <---'
    .it_value_sec  resq 1         ; <------- initial expiration
    .it_value_nsec resq 1         ;  <---'
endstruc

; sys_timer_create
%define CLOCK_MONOTONIC	            1
%define SIGEV_NONE                  1

%define TIMER_ABSTIME               1

global _start
_start:
    mov dword [sigev + sigevent.sigev_notif], SIGEV_NONE
    mov qword [itims + itimerspec.it_intvl_sec],  1
    mov qword [itims + itimerspec.it_intvl_nsec], 80
    mov qword [itims + itimerspec.it_value_sec],  3
    mov qword [itims + itimerspec.it_value_nsec], 60

    mov rax, 222                  ;  sys_timer_create
    mov rdi, CLOCK_MONOTONIC 
    mov rsi, sigev
    mov rdx, tval
    syscall

    mov rdi, rax

    mov rax, 223                  ;  sys_timer_settime
    mov rsi, TIMER_ABSTIME
    mov rdx, itims
    mov r10, 0
    syscall

    mov rax, 60                   ;  sys_exit
    mov rdi, [tval]
    syscall

section .bss
    sigev resb sigevent_size
    itims resb itimerspec_size
    tval  resq 1

