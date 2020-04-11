; linuxthor
;
; simple dlmopen example 
;
; dlmopen is like dlopen with the added ability
; to specify a 'linkmap' (aka a 'linker namespace')
; - either loading/resolving into the main/default 
; namespace or into a new (& separate) namespace
;
; assemble with:
; nasm -f elf64 -o dlmopen.o dlmopen.asm
; gcc dlmopen.o -no-pie -o dlmopen -ldl

BITS 64

extern dlmopen, dlsym, dlclose, printf

%define RTLD_LAZY 0x001
%define RTLD_NOW  0x002
%define RTLD_BINDING_MASK  0x003
%define RTLD_NOLOAD  0x004
%define RTLD_DEEPBIND 0x008
%define RTLD_GLOBAL  0x00100
%define RTLD_NODELETE 0x010000

%define LM_ID_BASE   0
%define LM_ID_NEWLM -1

global main
main:

    push rbp
    mov  rbp, rsp

    mov  rdi, lub
    mov  rsi, leb
    call printf    

    mov  rdi, LM_ID_NEWLM
    mov  rsi, lib
    mov  rdx, RTLD_LAZY
    call dlmopen

    mov [output], rax

    mov  rdi, [output]
    mov  rsi, lob
    call dlsym

    mov rdi, lub
    mov rsi, leb
    call rax         ; musl uses writev for stdio / so
                     ; check it's working via strace

    mov rdi, [output]
    call dlclose 

    mov rdi, lub
    mov rsi, leb
    call printf

    pop  rbp 
    ret    

section .data
    lib db '/usr/local/musl/lib/libc.so',0
    lob db 'printf',0
    lub db 'ahoy %s mateys!',0x0d,0x0a,0
    leb db 'me'

section .bss
    output resb 128
