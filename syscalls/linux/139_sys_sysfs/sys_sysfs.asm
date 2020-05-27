; linuxthor
;
; sys_sysfs example
;
; (deprecated syscall)
;
; assemble with:
; nasm -f elf64 -o sys_exit.o sys_sysfs.asm
; ld sys_sysfs.o -o sys_sysfs 

BITS 64

global _start
_start:
    mov rax, 139          ;  sys_sysfs
    mov rdi, 3            ;  option
    mov rsi, 0            ; <------- in other modes
    mov rdx, 0            ;  <-'   these may be used
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall
