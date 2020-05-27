; linuxthor
;
; sys_rt_sigreturn example
;
; don't call it.. will probably segfault etc.. see manpage 
;
; assemble with:
; nasm -f elf64 -o sys_rt_signreturn.o sys_rt_sigreturn.asm
; ld sys_rt_sigreturn.o -o sys_rt_sigreturn

BITS 64

global _start
_start:
    mov rax, 15           ;  sys_rt_sigreturn
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

