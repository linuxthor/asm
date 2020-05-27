; linuxthor
;
; sys_time example
;
; assemble with:
; nasm -f elf64 -o sys_time.o sys_time.asm
; ld sys_time.o -o sys_time 

BITS 64

global _start
_start:

    mov rax, 201          ;  sys_time
    mov rdi, time         ;  if argument is non
    syscall               ;  null it's stored there
                          ;  and is also the
    mov rdi, rax          ;  return value

    mov rax, 60           ;  sys_exit
    syscall

section .bss
    time  resq 1
