; linuxthor
;
; sys_sigaltstack example
;
; assemble with:
; nasm -f elf64 -o sys_sigaltstack.o sys_sigaltstack.asm
; ld sys_sigaltstack.o -o sys_sigaltstack 

BITS 64

%define SIGSTKSZ 131072

struc stack_t
    .ss_sp     resq 1
    .ss_flags  resq 1
    .ss_size   resq 1
endstruc

global _start
_start:
    mov rax, 12           ;  sys_brk
    mov rdi, 0
    syscall

    mov [addr], rax

    add rax, SIGSTKSZ
    mov rdi, rax
    mov rax, 12          ;  sys_brk
    syscall

    mov rbx, [addr]
    mov [stacka + stack_t.ss_sp], rbx
    mov dword [stacka + stack_t.ss_flags], 0
    mov qword [stacka + stack_t.ss_size],  SIGSTKSZ

    mov rax, 131          ;  sys_sigaltstack
    mov rdi, stacka
    mov rsi, 0
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

section .bss
    stacka resb stack_t_size
    addr resq 1

