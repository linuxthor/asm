; linuxthor
;
; sys_munlock example
;
; A syscall to unlock some previously locked memory
; from RAM so it can be swapped out again
;
; assemble with:
; nasm -f elf64 -o sys_munlock.o sys_munlock.asm
; ld sys_munlock.o -o sys_munlock

BITS 64

global _start
_start:

    mov rax, 12           ;  sys_brk
    mov rdi, 0
    syscall               ;  get current

    mov [savbrk], rax

    add rax, 4096         ;  add 4096 bytes 
    mov rdi, rax          ;  
    mov rax, 12           ;  allocating
    syscall               ;  some memory

    mov rax, 149          ;  sys_mlock
    mov rdi, [savbrk]
    mov rsi, 4096         ;  lock this in RAM to prevent
    syscall               ;  swapping 
                          
    mov rax, 150          ;  sys_munlock
    mov rdi, [savbrk]     ;  unlock it once finished
    mov rsi, 4096
    syscall              

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

section .bss
    savbrk  resd    1
