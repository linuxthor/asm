; linuxthor
;
; sys_getrusage example
;
; assemble with:
; nasm -f elf64 -o sys_getrusage.o sys_getrusage.asm
; ld sys_getrusage.o -o sys_getrusage 

BITS 64

struc rusage
    .ru_utime     resq 2
    .ru_stime     resq 2
    .ru_maxrss    resq 1
    .ru_ixrss     resq 1
    .ru_idrss     resq 1
    .ru_isrss     resq 1
    .ru_minflt    resq 1
    .ru_majflt    resq 1
    .ru_nwap      resq 1
    .ru_inblock   resq 1
    .ru_oublock   resq 1
    .ru_msgsend   resq 1
    .ru_msgrcv    resq 1
    .ru_nsignals  resq 1
    .ru_nvcsw     resq 1
    .ru_nivcsw    resq 1
endstruc

%define RUSAGE_SELF      0
%define RUSAGE_CHILDREN  -1
%define RUSAGE_THREAD    1

global _start
_start: 
    mov rax, 98               ;  sys_rusage
    mov rdi, RUSAGE_SELF
    mov rsi, rusagestru
    syscall

    mov rax, 60               ;  sys_exit
    mov rdi, [rusagestru + rusage.ru_maxrss]
    syscall

section .bss
    rusagestru resb rusage_size
