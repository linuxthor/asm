; linuxthor
;
; sys_brk example
;
; A memory allocation syscall
;
; assemble with:
; nasm -f elf64 -o sys_brk.o sys_brk.asm
; ld sys_brk.o -o sys_brk 

BITS 64

global _start
_start:

    mov rax, 12           ;  sys_brk
    mov rdi, 0
    syscall               ;  get current

    add rax, 4096         ;  add 4096 bytes 
    mov rdi, rax          ;  

    mov rax, 12           ;  allocating
    syscall               ;  some memory

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

