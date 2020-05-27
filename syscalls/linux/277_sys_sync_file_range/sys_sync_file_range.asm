; linuxthor
;
; sys_sync_file_range example
;
; DANGER! :) 
; the man page says this syscall is "extremely dangerous" to use! 
;
; assemble with:
; nasm -f elf64 -o sys_sync_file_range.o sys_sync_file_range.asm
; ld sys_sync_file_range.o -o sys_sync_file_range 

BITS 64

%define SYNC_FILE_RANGE_WAIT_BEFORE	1
%define SYNC_FILE_RANGE_WRITE		2
%define SYNC_FILE_RANGE_WAIT_AFTER	4
%define SYNC_FILE_RANGE_WRITE_AND_WAIT	(SYNC_FILE_RANGE_WRITE | \
					 SYNC_FILE_RANGE_WAIT_BEFORE | \
					 SYNC_FILE_RANGE_WAIT_AFTER)

; sys_open
%define O_MODES 0x42

global _start
_start:
    mov rax, 2            ;  sys_open
    mov rdi, filepath
    mov rsi, O_MODES
    mov rdx, 0666o 
    syscall

    mov [fd], rax

    mov rax, 1            ;  sys_write
    mov rdi, [fd]
    mov rsi, msg
    mov rdx, 26 
    syscall

    mov rax, 277          ;  sys_sync_file_range
    mov rdi, [fd]
    mov rsi, 0            ;  offset
    mov rdx, 26
    mov r10, SYNC_FILE_RANGE_WRITE
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

section .data
    filepath db '/tmp/atmpfiletmp',0
    msg      db 'abcdefghijklnopqrstuvwxyz'

section .bss
    fd resb 1
