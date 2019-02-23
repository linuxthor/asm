; linuxthor
;
; simple libssh example for passwd auth - copy a file 
; to server (sftp) then execute it 
;
; assemble with:
; nasm -f elf64 -o libsshcpexec.o libsshcpexec.asm
; gcc libsshcpexec.o -no-pie -o libsshcpexec -lssh
;

BITS 64

extern ssh_options_set, ssh_new, ssh_connect, ssh_disconnect
extern sftp_init, sftp_new, sftp_open, sftp_write, sftp_free
extern sftp_close, ssh_free, ssh_userauth_password, ssh_channel_new
extern ssh_channel_open_session, ssh_channel_request_exec
extern ssh_channel_close, ssh_channel_free

%define SSH_OPTIONS_HOST 0
%define SSH_OPTIONS_USER 4
%define SSH_OK 0
%define SSH_AUTH_SUCCESS 0 
%define S_IRWXU 448

global main

main: 
    push rbp
    mov  rbp, rsp
    xor  eax, eax              
    call ssh_new

    cmp  rax, 0
    je   error

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
    mov  rdx, pwd
    xor  rax, rax
    call ssh_userauth_password

    cmp  rax, SSH_AUTH_SUCCESS
    jne  error

    mov  rdi, [ssh_sesh]
    xor  rax, rax
    call sftp_new

    cmp  rax, 0
    je   error

    mov  [sftp_sesh], rax

    mov  rdi, [sftp_sesh]
    xor  rax, rax
    call sftp_init

    cmp  rax, SSH_OK
    jne  error

    mov  rdi, [sftp_sesh]
    mov  rsi, pth
    mov  rdx, 577                       ; O_WRONLY | O_CREAT | O_TRUNC
    mov  rcx, S_IRWXU
    xor  rax, rax
    call sftp_open

    cmp  rax, 0
    je   error    

    mov  [sftp_file], rax

    mov  rdi, [sftp_file]
    mov  rsi, pload
    mov  rdx, ploadlen
    mov  rax, rax
    call sftp_write 

    cmp  rax, ploadlen
    jne  error

    mov  rdi, [sftp_file]
    xor  rax, rax
    call sftp_close

    cmp  rax, SSH_OK
    jne  error
    
    mov  rdi, [sftp_sesh]
    xor  rax, rax
    call sftp_free

    mov  rdi, [ssh_sesh]
    xor  rax, rax
    call ssh_channel_new

    cmp  rax, 0
    je   error

    mov  [ssh_chan], rax

    mov  rdi, rax
    xor  rax, rax
    call ssh_channel_open_session

    cmp  rax, SSH_OK
    jne  error

    mov  rdi, [ssh_chan]
    mov  rsi, pth
    xor  rax, rax
    call ssh_channel_request_exec

    cmp  rax, SSH_OK
    jne  error

    mov  rdi, [ssh_chan]
    call ssh_channel_close
    xor  rax, rax

    cmp  rax, SSH_OK
    jne  error

    mov  rdi, [ssh_chan]
    call ssh_channel_free
    xor  rax, rax

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
    pth db '/tmp/success',0
    pload: 
    incbin "pload"
    ploadlen equ $-pload

section .bss
    ssh_sesh resq 1
    ssh_chan resq 1
    sftp_sesh resq 1
    sftp_file resq 1
