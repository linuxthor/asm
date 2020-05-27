; linuxthor
;
; sys_times example
;
; assemble with:
; nasm -f elf64 -o sys_times.o sys_times.asm
; ld sys_times.o -o sys_times

BITS 64

struc tms
    .tms_utime  resq 1
    .tms_stime  resq 1
    .tms_cutime resq 1
    .tms_cstime resq 1
endstruc

global _start
_start:
    mov rax, 100          ;  sys_times
    mov rdi, tmsstruc
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, [tmsstruc + tms.tms_utime]
    syscall

section .bss
    tmsstruc resb tms_size
