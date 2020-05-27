; linuxthor
;
; sys_add_key example
;
; add keyrings or keys to the kernel key management facility
;
; assemble with:
; nasm -f elf64 -o sys_add_key.o sys_add_key.asm
; ld sys_add_key.o -o sys_add_key 

BITS 64

%define KEY_SPEC_THREAD_KEYRING	        -1
%define KEY_SPEC_PROCESS_KEYRING        -2	
%define KEY_SPEC_SESSION_KEYRING        -3	
%define KEY_SPEC_USER_KEYRING           -4	
%define KEY_SPEC_USER_SESSION_KEYRING   -5	
%define KEY_SPEC_GROUP_KEYRING          -6	
%define KEY_SPEC_REQKEY_AUTH_KEY        -7	
%define KEY_SPEC_REQUESTOR_KEYRING      -8	

global _start
_start:
    mov rax, 248          ;  sys_add_key
    mov rdi, usr
    mov rsi, desc
    mov rdx, val
    mov r10, len
    mov r8,  KEY_SPEC_PROCESS_KEYRING
    syscall

    mov rdi, rax

    mov rax, 60           ;  sys_exit
    syscall

section .data
    usr   db 'user',0
    desc  db 'a description',0
    val   db 'the payload is this - some data',0
    len   equ $-val 

