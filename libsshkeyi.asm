; linuxthor
;
; simple libssh example for keyboard interactive auth
;
; (slightly more complex than passwd auth but may be 
; supported where passwd auth is disallowed by config)
;
; assemble with:
; nasm -f elf64 -o libsshkeyi.o libsshkeyi.asm
; gcc libsshkeyi.o -no-pie -o libsshkeyi -lssh
;

BITS 64

extern ssh_options_set, ssh_new, ssh_connect, ssh_disconnect
extern ssh_free, ssh_userauth_kbdint, ssh_userauth_kbdint_setanswer

%define SSH_OPTIONS_HOST 0
%define SSH_OPTIONS_USER 4
%define SSH_OK 0
%define SSH_AUTH_SUCCESS 0
%define SSH_AUTH_DENIED  1
%define SSH_AUTH_PARTIAL 2
%define SSH_AUTH_INFO    3
%define SSH_AUTH_ERROR  -1

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
    mov  rsi, SSH_OPTIONS_USER       
    mov  rdx, usr                    
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
    mov  rsi, 0
    mov  rdx, 0
    xor  rax, rax
    call ssh_userauth_kbdint

    cmp  rax, SSH_AUTH_INFO               ; if the server isn't asking for 
    jne  error                            ; more info we're scuppered...

kbi:
    mov  rdi, [ssh_sesh]
    mov  rsi, 0                           ; FIXME we cheat and assume 1st 
    mov  rdx, pwd                          
    xor  rax, rax
    call ssh_userauth_kbdint_setanswer   

    cmp  rax, 0                           
    jl   error    

    mov  rdi, [ssh_sesh]
    mov  rsi, 0
    mov  rdx, 0
    xor  rax, rax
    call ssh_userauth_kbdint

    cmp  rax, SSH_AUTH_INFO               ; Server needs more info
    je   kbi                              ; or maybe same info again... 
                                          ; kbi == keep bloody inputting!
    cmp  rax, SSH_AUTH_SUCCESS
    jne  error

    mov  rdi, [ssh_sesh]
    xor  rax, rax
    call ssh_disconnect 

    mov  rdi, [ssh_sesh]
    xor  rax, rax
    call ssh_free

    pop rbp
    xor eax, eax         
    ret 

error:
    pop rbp
    mov rax, 1
    ret

section .data
    con db '192.168.0.1',0  
    usr db 'username',0
    pwd db '!passwd!',0

section .bss
    ssh_sesh resq 1
