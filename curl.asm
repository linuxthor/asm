; linuxthor
;
; simple libcurl example 
;
; assemble with:
; nasm -f elf64 -o curly.o curly.asm
; gcc curly.o -no-pie -o curly -lcurl
;

BITS 64

extern curl_global_init, curl_easy_init, curl_easy_perform
extern curl_easy_setopt, curl_easy_cleanup, curl_global_cleanup

%define CURLOPT_URL         10002
%define CURL_GLOBAL_DEFAULT 3

global main

main: 
    push rbp
    mov  rbp, rsp
    mov rdi, CURL_GLOBAL_DEFAULT       
    xor eax, eax              
    call curl_global_init

    call curl_easy_init

    cmp  rax, 0
    je   error

    mov  [curly], rax

    mov rdi, [curly]
    mov rsi, CURLOPT_URL               
    mov rdx, url
    xor rax, rax
    call curl_easy_setopt

    cmp  rax, 0
    jne  error

    mov  rdi, [curly]
    xor  eax, eax 
    call curl_easy_perform

    cmp rax, 0
    jne error

    mov rdi, [curly]
    xor eax, eax
    call curl_easy_cleanup

    call curl_global_cleanup

    mov rsp, rbp
    pop rbp
    xor eax, eax         
    ret 

error:
    mov rsp, rbp
    pop rbp
    mov rax, 1
    ret

section .data
    url db 'http://www.example.com/',0  

section .bss
    curly resq 1

