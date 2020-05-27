; linuxthor
;
; sys_capget example
;
; assemble with:
; nasm -f elf64 -o sys_capget.o sys_capget.asm
; ld sys_capget.o -o sys_capget 

BITS 64

%define _LINUX_CAPABILITY_VERSION_1  0x19980330
%define _LINUX_CAPABILITY_VERSION_3  0x20080522

struc cap_user_header_t
    .version resd 1
    .pid     resd 1
endstruc

struc cap_user_data_t
    .effective    resd 1
    .permitted    resd 1
    .inheritable  resd 1
endstruc

global _start
_start:
    mov dword [hdrp + cap_user_header_t.version], _LINUX_CAPABILITY_VERSION_3

    mov rax, 125          ;  sys_capget
    mov rdi, hdrp
    mov rsi, datap
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

section .bss
    hdrp  resb cap_user_header_t_size
    datap resb 2 * cap_user_data_t_size

