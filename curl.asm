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
    mov rdi, CURL_GLOBAL_DEFAULT       
    xor eax, eax              
    call curl_global_init
    pop rbp

    push rbp
    call curl_easy_init
    pop rbp

    cmp  rax, 0
    je   error

    mov  [curly], rax

    push rbp
    mov rdi, [curly]
    mov rsi, CURLOPT_URL               
    mov rdx, url
    xor rax, rax
    call curl_easy_setopt
    pop rbp    

    cmp  rax, 0
    jne  error

    push rbp
    mov  rdi, [curly]
    xor  eax, eax 
    call curl_easy_perform
    pop  rbp 

    cmp rax, 0
    jne error

    push rbp 
    mov rdi, [curly]
    xor eax, eax
    call curl_easy_cleanup
    pop rbp

    push rbp
    call curl_global_cleanup
    pop rbp

    xor eax, eax         
    ret 

error:
    mov rax, 1
    ret

section .data
    url db 'http://www.example.com/',0  

section .bss
    curly resq 1

