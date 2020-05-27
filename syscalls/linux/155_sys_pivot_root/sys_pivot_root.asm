; linuxthor
;
; sys_pivot_root example
;
; assemble with:
; nasm -f elf64 -o sys_pivot_root.o sys_pivot_root.asm
; ld sys_pivot_root.o -o sys_pivot_root 
;
; mkdir /ramroot
; mount -n -t tmpfs -o size=500M none /ramroot
; cd /ramroot
; mkdir oldroot
;
; NOTE: ye may get EINVAL as current root cannot be on the 
; 'rootfs' (initial ramfs)

BITS 64

global _start
_start:
    mov rax, 80           ;  sys_chdir
    mov rdi, newroot
    syscall

    mov rax, 155          ;  sys_pivot_root
    mov rdi, currdur
    mov rsi, putold
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

section .data
    currdur db '.',0
    newroot db '/ramroot',0
    putold  db 'oldroot',0
