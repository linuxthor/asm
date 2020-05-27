; linuxthor
;
; sys_vhangup example
;
; simulates a hangup on the current terminal
;
; CAP_SYS_TTY_CONFIG capability is required to call
;
; assemble with:
; nasm -f elf64 -o sys_vhangup.o sys_vhangup.asm
; ld sys_vhangup.o -o sys_vhangup 

BITS 64

global _start
_start:
    mov rax, 153          ;  sys_vhangup
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall
