; linuxthor
;
; sys_mq_timedsend example
;
; send a message on a POSIX mq
;
; assemble with:
; nasm -f elf64 -o sys_mq_timedsend.o sys_mq_timedsend.asm
; ld sys_mq_timedsend.o -o sys_mq_timedsend 

BITS 64

struc mq_attr
    .mq_flags    resq 1
    .mq_maxmsg   resq 1
    .mq_msgsize  resq 1
    .mq_curmsgs  resq 1
    .mq_reserve  resq 4
endstruc

struc timespec
    .tv_sec      resq 1
    .tv_nsec     resq 1
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

    mov rdi, rax                           ;   mqd_t handle
 
    ; A timeout can be set on messages.. 
    mov qword [tsstruct + timespec.tv_sec], 10
    mov qword [tsstruct + timespec.tv_nsec], 100

    mov rax, 242                           ;  sys_mq_timedsend
    mov rsi, msg                           ;  message text
    mov rdx, 26                            ;  message length
    mov r10, 1                             ;  message priority
    mov r8,  tsstruct
    syscall

    mov rax, 241                           ;  sys_mq_unlink
    mov rdi, filename
    syscall

    mov rax, 60                            ;  sys_exit
    mov rdi, 0
    syscall

section .data
    filename   db 'testposixmq',0    
    msg        db 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'

section .bss
    mqstruct   resd mq_attr_size
    tsstruct   resd timespec_size
