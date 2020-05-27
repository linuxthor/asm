; linuxthor
;
; sys_inotify_rm_watch example
;
; assemble with:
; nasm -f elf64 -o sys_inotify_rm_watch.o sys_inotify_rm_watch.asm
; ld sys_inotify_rm_watch.o -o sys_inotify_rm_watch 

BITS 64

; sys_inotify_add_watch
%define IN_CLOSE_WRITE          0x00000008
%define IN_CLOSE_NOWRITE        0x00000010
%define IN_OPEN	                0x00000020
%define IN_CLOSE		(IN_CLOSE_WRITE | IN_CLOSE_NOWRITE) 

global _start
_start:
    mov rax, 253          ;  sys_inotify_init 
    syscall

    mov [wd], rax

    mov rax, 254          ;  sys_inotify_add_watch
    mov rdi, [wd]
    mov rsi, pathname
    mov rdx, (IN_OPEN|IN_CLOSE)
    syscall

    mov rsi, rax
 
    mov rax, 255          ;  sys_inotify_rm_watch
    mov rdi, [wd]
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

section .data
   pathname db '/etc/issue',0

section .bss
   wd resq 1
