; linuxthor
;
; sys_pwrite64 example
;
; write data at some offset in a file
;
; assemble with:
; nasm -f elf64 -o sys_pwrite64.o sys_pwrite64.asm
; ld sys_pwrite64.o -o sys_pwrite64 

BITS 64

; sys_open
%define O_FLAGS   0x42    ; O_RDWR|O_CREAT

global _start
_start:
    mov rax, 2            ;  sys_open
    mov rdi, filename
    mov rsi, O_FLAGS
    syscall

    mov rdi, rax

    mov rax, 18           ;  sys_pwrite64
    mov rsi, alphabyt     ;  buffer
    mov rdx, 30           ;  count
    mov r10, 64           ;  offset
    syscall 

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

section .data
   filename  db '/tmp/atmpfil',0
   alphabyt  db 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234'

