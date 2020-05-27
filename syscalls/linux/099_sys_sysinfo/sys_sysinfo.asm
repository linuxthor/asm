; linuxthor
;
; sys_sysinfo example
;
; assemble with:
; nasm -f elf64 -o sys_sysinfo.o sys_sysinfo.asm
; ld sys_sysinfo.o -o sys_sysinfo 

BITS 64

struc sysinfo
    .uptime    resq  1
    .loads     resq  3
    .totalram  resq  1
    .freeram   resq  1
    .shareram  resq  1
    .buffram   resq  1
    .totswap   resq  1
    .freeswap  resq  1
    .procs     resw  1
    .totlhigh  resq  1
    .freehigh  resq  1
    .memunit   resw  1
endstruc

global _start
_start:

    mov rax, 99           ;  sys_sysinfo
    mov rdi, sysstruc
    syscall 

    mov rdi, [sysstruc + sysinfo.procs]
 
    mov rax, 60           ;  sys_exit
    syscall

section .bss
    sysstruc  resb  sysinfo_size
