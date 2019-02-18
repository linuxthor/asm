; linuxthor
;
; simple libssh example for passwd auth 
; and shell command execution via channel
;
; assemble with:
; nasm -f elf64 -o libsshexec.o libsshexec.asm
; gcc libsshexec.o -no-pie -o libsshexec -lssh
;

BITS 64

extern ssh_options_set, ssh_new, ssh_connect, ssh_disconnect
extern ssh_free, ssh_userauth_password, ssh_channel_new
extern ssh_channel_open_session, ssh_channel_request_exec
extern ssh_channel_close, ssh_channel_free

%define SSH_OPTIONS_HOST 0
%define SSH_OPTIONS_USER 4
%define SSH_OK 0
%define SSH_AUTH_SUCCESS 0 

global main

main: 
    push rbp
    xor  eax, eax              
    call ssh_new
    pop  rbp

    cmp  rax, 0
    je   error

    mov [ssh_sesh], rax

    push rbp
    mov  rdi, [ssh_sesh]
    mov  rsi, SSH_OPTIONS_HOST
    mov  rdx, con
    xor  rax, rax
    call ssh_options_set
    pop  rbp 

    cmp  rax, 0
    jne  error

    push rbp
    mov  rdi, [ssh_sesh]
    mov  rsi, SSH_OPTIONS_USER       
    mov  rdx, usr                    
    xor  rax, rax
    call ssh_options_set
    pop  rbp 

    cmp  rax, 0
    jne  error

    push rbp
    mov  rdi, [ssh_sesh]
    xor  rax, rax
    call ssh_connect 
    pop  rbp

    cmp  rax, SSH_OK
    jne  error

    push rbp
    mov  rdi, [ssh_sesh]
    mov  rsi, 0
    mov  rdx, pwd
    xor  rax, rax
    call ssh_userauth_password
    pop  rbp

    cmp  rax, SSH_AUTH_SUCCESS
    jne  error

    push rbp
    mov  rdi, [ssh_sesh]
    xor  rax, rax
    call ssh_channel_new
    pop  rbp

    cmp  rax, 0
    je   error

    mov  [ssh_chan], rax

    push rbp
    mov  rdi, rax
    xor  rax, rax
    call ssh_channel_open_session
    pop  rbp

    cmp  rax, SSH_OK
    jne  error

    push rbp
    mov  rdi, [ssh_chan]
    mov  rsi, cmd
    xor  rax, rax
    call ssh_channel_request_exec
    pop  rbp

    cmp  rax, SSH_OK
    jne  error

    push rbp
    mov  rdi, [ssh_chan]
    call ssh_channel_close
    xor  rax, rax
    pop  rbp

    cmp  rax, SSH_OK
    jne  error

    push rbp
    mov  rdi, [ssh_chan]
    call ssh_channel_free
    xor  rax, rax
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

error:
    mov rax, 1
    ret

section .data
    con db '192.168.0.1',0  
    usr db 'username',0
    pwd db '!passwd!',0
    cmd db 'touch /tmp/success',0

section .bss
    ssh_sesh resq 1
    ssh_chan resq 1

