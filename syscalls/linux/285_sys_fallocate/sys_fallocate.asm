; linuxthor
;
; sys_fallocate example
;
; manipulate space allocated to a file in various ways
; useful to ensure space is available (or perhaps for 
; performance - see manpage for details) 
;
; assemble with:
; nasm -f elf64 -o sys_fallocate.o sys_fallocate.asm
; ld sys_fallocate.o -o sys_fallocate 

BITS 64

;sys_open
%define O_MODES 0x42      ;  O_RDWR|O_CREAT
;sys_fallocate
%define  FALLOC_FL_KEEP_SIZE       0x01 
%define  FALLOC_FL_PUNCH_HOLE      0x02
%define  FALLOC_FL_ZERO_RANGE      0x10
%define  FALLOC_FL_INSERT_RANGE    0x20
%define  FALLOC_FL_COLLAPSE_RANGE  0x08

global _start
_start:
    mov rax, 2             ;  sys_open
    mov rdi, filename 
    mov rsi, O_MODES      
    mov rdx, 0644o
    syscall 

    mov rdi, rax

    mov rax, 285          ;  sys_fallocate
    mov rsi, FALLOC_FL_ZERO_RANGE
    mov rdx, 0            ;  offset
    mov r10, 4096         ;  length
    syscall 

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

section data
    filename  db  '/tmp/superfile',0
