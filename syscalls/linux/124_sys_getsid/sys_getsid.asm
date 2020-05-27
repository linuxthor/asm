; linuxthor
;
; sys_getsid example
;
; get the session ID of the calling process
; (or some other process)
;
; assemble with:
; nasm -f elf64 -o sys_getsid.o sys_getsid.asm
; ld sys_getsid.o -o sys_getsid 

BITS 64

global _start
_start:
    mov rax, 124          ; sys_getsid
    mov rdi, 0            ; 0 for the calling process
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall
