; linuxthor
;
; sys_timer_delete example
;
; assemble with:
; nasm -f elf64 -o sys_timer_delete.o sys_timer_delete.asm
; ld sys_timer_delete.o -o sys_timer_delete 

BITS 64

struc sigevent
    .sigev_value resq 1
    .sigev_signo resd 1 
    .sigev_notif resd 1
    .sigev_un    resb 48
endstruc

; sys_timer_create
%define CLOCK_MONOTONIC	            1
%define SIGEV_NONE                  1  

global _start
_start:
    mov dword [sigev + sigevent.sigev_notif], SIGEV_NONE

    mov rax, 222          ;  sys_timer_create
    mov rdi, CLOCK_MONOTONIC 
    mov rsi, sigev
    mov rdx, tval
    syscall

    mov rax, 226          ;  sys_timer_delete
    mov rdi, [tval]
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, [tval]
    syscall

section .bss
    sigev resb sigevent_size
    tval  resq 1
