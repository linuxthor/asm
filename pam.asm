; linuxthor
;
; simple libpam example 
;
; assemble with:
; nasm -f elf64 -o pam.o pam.asm
; gcc pam.o -no-pie -o pam -lpam -lpam_misc
;

BITS 64

STRUC pamconv
  .fp:    RESQ 1
  .ep:    RESB 1
ENDSTRUC

extern pam_start, pam_authenticate, pam_acct_mgmt, pam_end
extern misc_conv

%define PAM_SUCCESS 0

global main

main: 
    push rbp
    mov  rbp, rsp

    mov rbx, misc_conv
    mov [conv + pamconv.fp], rbx

    mov rdi, chku
    mov rsi, pamu
    mov rdx, conv
    mov rcx, pamh
    xor rax, rax
    call pam_start

    cmp rax, PAM_SUCCESS
    jne error

    mov rdi, [pamh]
    mov rsi, 0
    call pam_authenticate 

    cmp rax, PAM_SUCCESS
    jne error
  
    mov rdi, [pamh]
    mov rsi, 0
    call pam_acct_mgmt

    cmp rax, PAM_SUCCESS
    jne error

    mov rdi, [pamh]
    mov rsi, rax
    call pam_end

    pop rbp
    ret 

error:
    pop rbp
    mov rax, 1
    ret

section .data
    pamu db 'weirduncle',0  
    chku db 'check_user',0

section .bss
    pamh resq 1
    conv resb pamconv_size
