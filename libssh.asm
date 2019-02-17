; linuxthor
;
; simple libssh example 
;
; assemble with:
; nasm -f elf64 -o libssh.o libssh.asm
; gcc libssh.o -no-pie -o libssh -lssh
;

BITS 64

extern ssh_options_set, ssh_new, ssh_connect, ssh_disconnect
extern ssh_free

%define SSH_OPTIONS_HOST 0

global main

main: 
    push rbp
    xor  eax, eax              
    call ssh_new
    pop  rbp

    mov [ssh_sesh], rax

    push rbp
    mov  rdi, [ssh_sesh]
    mov  rsi, SSH_OPTIONS_HOST
    mov  rdx, con
    xor  rax, rax
    call ssh_options_set
    pop  rbp 

    push rbp
    mov  rdi, [ssh_sesh]
    xor  rax, rax
    call ssh_connect 
    pop  rbp

    push rbp
    mov  rdi, [ssh_sesh]
    xor  rax, rax
    call ssh_disconnect 
    pop  rbp

    push rbp
    mov  rdi, [ssh_sesh]
    xor  rax, rax
    call ssh_free
    pop  rbp

    xor eax, eax         
    ret 

section .data
    con db '192.168.0.1',0  

section .bss
    ssh_sesh resq 1

