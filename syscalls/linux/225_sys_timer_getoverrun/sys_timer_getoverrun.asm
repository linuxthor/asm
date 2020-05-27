; linuxthor
;
; sys_timer_getoverrun example
;
; assemble with:
; nasm -f elf64 -o sys_timer_getoverrun.o sys_timer_getoverrun.asm
; ld sys_timer_getoverrun.o -o sys_timer_getoverrun 

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

; sys_timer_settime
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

    mov [td], rax

    mov rax, 223                  ;  sys_timer_settime
    mov rsi, TIMER_ABSTIME
    mov rdi, [td]
    mov rdx, itims
    mov r10, 0
    syscall

    mov rax, 224                  ;  sys_timer_gettime
    mov rdi, [td]
    mov rsi, xtims
    syscall

    mov rax, 225                  ;  sys_timer_getoverrun
    mov rdi, [td]
    syscall

    mov rax, 60                   ;  sys_exit
    mov rdi, [tval]
    syscall

section .bss
    sigev resb sigevent_size
    itims resb itimerspec_size
    xtims resb itimerspec_size
    tval  resq 1
    td    resq 1
