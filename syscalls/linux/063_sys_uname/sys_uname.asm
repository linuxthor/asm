; linuxthor
;
; sys_uname example
;
; assemble with:
; nasm -f elf64 -o sys_uname.o sys_uname.asm
; ld sys_uname.o -o sys_uname 

BITS 64

; read the man page for some stuff about this
; structure.. 65 bytes is the Linux version
; but other operating systems may size this 
; differently.. 
struc utsname
    .sysname    resb 65
    .nodename   resb 65
    .release    resb 65
    .version    resb 65
    .machine    resb 65
    .domainn    resb 65	
endstruc

global _start
_start:
    mov rax, 63           ;  sys_uname
    mov rdi, utsstruct
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

section .bss 
    utsstruct resb utsname_size
