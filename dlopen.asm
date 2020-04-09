; linuxthor
;
; simple dlopen example
;
; assemble with:
; nasm -f elf64 -o dlopen.o dlopen.asm
; gcc dlopen.o -no-pie -o dlopen -ldl

BITS 64

extern dlopen, dlsym

%define RTLD_LAZY 0x001
%define RTLD_NOW  0x002
%define RTLD_BINDING_MASK  0x003
%define RTLD_NOLOAD  0x004
%define RTLD_DEEPBIND 0x008
%define RTLD_GLOBAL  0x00100
%define RTLD_NODELETE 0x010000

global main
main:

    push rbp
    mov  rbp, rsp

    mov  rdi, lib
    mov  rsi, RTLD_LAZY
    call dlopen

    mov  rdi, rax
    mov  rsi, lob
    call dlsym

    mov  rdi, lub
    mov  rsi, leb
    call rax

    pop  rbp
    ret

section .data
    lib db '/lib/x86_64-linux-gnu/libc.so.6',0
    lob db 'printf',0
    lub db 'ahoy %s mateys!',0x0d,0x0a,0
    leb db 'me'
