; linuxthor
;
; sys_select example
;
; assemble with:
; nasm -f elf64 -o sys_select.o sys_select.asm
; ld sys_select.o -o sys_select

BITS 64

struc timeval
    .tv_sec   resq 1
    .tv_usec  resq 1
endstruc

global _start
_start:
    mov qword [timeout + timeval.tv_sec],  5
    mov qword [timeout + timeval.tv_usec], 50

    mov qword [fd_set], 1

    mov rax, 23           ;  sys_select
    mov rdi, 1
    mov rsi, fd_set
    mov rdx, 0
    mov r10, 0
    mov r8, timeout
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

section .bss
    timeout resb timeval_size
    ; the size of the fd_set is something like 64 per long
    ; https://stackoverflow.com/questions/18952564/
    ; understanding-fd-set-in-unix-sys-select-h
    fd_set  resq 1
     
