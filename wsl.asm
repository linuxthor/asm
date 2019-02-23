; linuxthor
;
; detect windows subsystem for linux via
; /proc/version
;
; assemble with:
; nasm -f elf64 -o wsl.o wsl.asm
; gcc wsl.o -o wsl 
;

BITS 64

global main

main: 
    mov  rax, 257                   ; sys_openat
    mov  rdi, 0
    mov  rsi, prv
    mov  rdx, 0x0000
    mov  r10, 0
    syscall 

    mov  rdi, rax
    xor  rax, rax
    mov  rsi, vers
    mov  rdx, 256
    syscall

    mov  rbx, rax                    
    mov  rsi, [mic]
loop:
    mov  rdi, [vers+r14]
    cmp  rsi, rdi
    je   wsl                         ; wsl
    inc  r14
    dec  rbx
    cmp  rbx, 0
    jg   loop

    mov  rdx, rax
    mov  rax, 1
    mov  rdi, 1
    mov  rsi, vers
    syscall

    xor eax, eax         
    ret 

wsl:
    mov rax, 1
    mov rdi, 1
    mov rsi, con
    mov rdx, conl
    syscall

    mov rax, 1
    ret

section .data
    prv db '/proc/version',0
    mic db 'Microsoft'
    con db 'WSL',0x0a,0  
    conl equ $-con

section .bss
    vers resb 256

