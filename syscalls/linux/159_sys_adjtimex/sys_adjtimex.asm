; linuxthor
;
; sys_adjtimex example
;
; "David L. Mills / RFC 5905 clock adjustment" 
; 
; assemble with:
; nasm -f elf64 -o sys_adjtimex.o sys_adjtimex.asm
; ld sys_adjtimex.o -o sys_adjtimex 

BITS 64

%define ADJ_OFFSET              0x0001
%define ADJ_FREQUENCY           0x0002
%define ADJ_MAXERROR            0x0004
%define ADJ_ESTERROR            0x0008
%define ADJ_STATUS              0x0010
%define ADJ_TIMECONST           0x0020
%define ADJ_TAI	                0x0080
%define ADJ_SETOFFSET           0x0100 
%define ADJ_MICRO               0x1000
%define ADJ_NANO                0x2000
%define ADJ_TICK                0x4000

; it's a big old structure.. 
struc timex
    .modes  resd 1
    .offset resq 1
    .freq   resq 1
    .maxerr resq 1
    .esterr resq 1
    .status resd 1
    .const  resq 1
    .precis resq 1
    .tlrnce resq 1
    .timev  resq 2
    .tick   resq 1
    .ppsfrq resq 1
    .jitter resq 1
    .shift  resd 1
    .stabil resq 1
    .jitcnt resq 1
    .calcnt resq 1
    .errcnt resq 1
    .stbcnt resq 1
    .tai    resd 1
endstruc

global _start
_start:
    mov dword [timexst + timex.modes],  ADJ_NANO

    mov rax, 159          ;  sys_adjtimex
    mov rdi, timexst
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

section .bss
    timexst resb timex_size
