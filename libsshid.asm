; linuxthor
;
; simple libssh example for checking server identity
; 
; exits with error if server identity not verified
; via ~/.ssh/known_hosts 
;
; assemble with:
; nasm -f elf64 -o libsshid.o libsshid.asm
; gcc libsshid.o -no-pie -o libsshid -lssh
;

BITS 64

extern ssh_options_set, ssh_new, ssh_connect, ssh_disconnect
extern ssh_free, ssh_get_server_publickey, ssh_get_publickey_hash
extern ssh_key_free, ssh_is_server_known

%define SSH_OPTIONS_HOST 0
%define SSH_OK 0
%define SSH_SERVER_KNOWN_OK 1
%define SSH_SERVER_KNOWN_CHANGED 2
%define SSH_SERVER_FOUND_OTHER 3
%define SSH_SERVER_FILE_NOT_FOUND 4
%define SSH_SERVER_NOT_KNOWN 0
%define SSH_SERVER_ERROR -1

global main

main: 
    push rbp
    mov  rbp, rsp
    xor  eax, eax              
    call ssh_new

    cmp rax, 0
    je  error

    mov [ssh_sesh], rax

    mov  rdi, [ssh_sesh]
    mov  rsi, SSH_OPTIONS_HOST
    mov  rdx, con
    xor  rax, rax
    call ssh_options_set

    cmp  rax, 0
    jne  error

    mov  rdi, [ssh_sesh]
    xor  rax, rax
    call ssh_connect 

    cmp  rax, SSH_OK
    jne  error

    mov  rdi, [ssh_sesh] 
    mov  rsi, ssh_key
    xor  rax, rax
    call ssh_get_server_publickey

    cmp  rax, 0
    jl   error

    mov  rdi, [ssh_key]
    xor  rax, rax
    call ssh_key_free

    cmp  rax, 0
    jl   error

    mov  rdi, [ssh_sesh]
    xor  rax, rax
    call ssh_is_server_known

    cmp  rax, SSH_SERVER_KNOWN_OK             
    jne  error 

    mov  rdi, [ssh_sesh]
    xor  rax, rax
    call ssh_disconnect 

    mov  rdi, [ssh_sesh]
    xor  rax, rax
    call ssh_free

    xor rax, rax
    mov rsp, rbp
    pop rbp
    ret 

error:
    mov rax, 1
    mov rsp, rbp
    pop rbp
    ret

section .data
    con db '192.168.0.1',0  

section .bss
    ssh_sesh resq 1
    ssh_key  resq 1
