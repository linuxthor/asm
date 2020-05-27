; linuxthor
;
; sys_mq_open example
;
; open (and maybe create) a new POSIX mq
;
; assemble with:
; nasm -f elf64 -o sys_mq_open.o sys_mq_open.asm
; ld sys_mq_open.o -o sys_mq_open 

BITS 64

struc mq_attr
    .mq_flags    resq 1
    .mq_maxmsg   resq 1
    .mq_msgsize  resq 1
    .mq_curmsgs  resq 1
    .mq_reserve  resq 4
endstruc

%define O_FLAGS 0x42  ; O_RDWR|O_CREAT

global _start
_start:
    mov rax, 240                           ;  sys_mq_open
    mov rdi, filename
    mov rsi, O_FLAGS
    mov rdx, 0644o
    mov qword [mqstruct + mq_attr.mq_maxmsg],  10
    mov qword [mqstruct + mq_attr.mq_msgsize], 4096
    mov r10, mqstruct                      ;   other fields ignored     
    syscall                                ;   for mq_open

    mov rax, 60                            ;  sys_exit
    mov rdi, 0
    syscall

section .data
    filename   db 'something',0    

section .bss
    mqstruct   resd mq_attr_size
