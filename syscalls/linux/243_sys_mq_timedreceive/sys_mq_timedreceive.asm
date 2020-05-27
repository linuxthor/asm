; linuxthor
;
; sys_mq_timedreceive example
;
; receive a message on a POSIX mq
;
; assemble with:
; nasm -f elf64 -o sys_mq_timedreceive.o sys_mq_timedreceive.asm
; ld sys_mq_timedreceive.o -o sys_mq_timedreceive 

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
    mov r10, mqstruct                     
    syscall                               

    mov [mqd_t], rax                       ;   mqd_t handle
 
    mov rax, 242                           ;  sys_mq_timedsend
    mov rdi, [mqd_t]
    mov rsi, msg                           ;  message text
    mov rdx, 26                            ;  message length
    mov r10, 0                             
    mov r8,  tsstruct
    syscall

    mov rax, 243                           ;  sys_mq_timedreceive
    mov rdi, [mqd_t]
    mov rsi, data                          ;  buffer
    mov rdx, 4096                          ;  buffer size
    mov r10, 0
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
    mqd_t      resb 1
    data       resb 4096
    mqstruct   resd mq_attr_size
    tsstruct   resd timespec_size
