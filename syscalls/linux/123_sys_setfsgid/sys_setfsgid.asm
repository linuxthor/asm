; linuxthor
;
; sys_setfsgid example
;
; assemble with:
; nasm -f elf64 -o sys_setfsgid.o sys_setfsgid.asm
; ld sys_setfsgid.o -o sys_setfsgid 

BITS 64

global _start
_start:
    mov rax, 123          ;  sys_setfsgid
    mov rdi, 65535
    syscall

    mov rdi, rax          ; on success or failure it 
                          ;  returns the previous value

    mov rax, 60           ;  sys_exit
    syscall
