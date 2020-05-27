; linuxthor
;
; sys_alarm example
;
; assemble with:
; nasm -f elf64 -o sys_alarm.o sys_alarm.asm
; ld sys_alarm.o -o sys_alarm

BITS 64

global _start
_start:
    mov rax, 37           ;  sys_alarm 
    mov rdi, 3
    syscall

    mov rax, 34           ;  sys_pause
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall
