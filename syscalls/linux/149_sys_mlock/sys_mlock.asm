; linuxthor
;
; sys_mlock example
;
; A syscall to lock some memory in RAM
;
; assemble with:
; nasm -f elf64 -o sys_mlock.o sys_mlock.asm
; ld sys_mlock.o -o sys_mlock

BITS 64

global _start
_start:

    mov rax, 12           ;  sys_brk
    mov rdi, 0
    syscall               ;  get current

    push rax

    add rax, 4096         ;  add 4096 bytes 
    mov rdi, rax          ;  
    mov rax, 12           ;  allocating
    syscall               ;  some memory

    mov rax, 149          ;  sys_mlock
    pop rdi
    mov rsi, 4096
    syscall               

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

