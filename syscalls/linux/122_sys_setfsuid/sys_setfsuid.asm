; linuxthor
;
; sys_setfsuid example
;
; assemble with:
; nasm -f elf64 -o sys_setfsuid.o sys_setfsuid.asm
; ld sys_setfsuid.o -o sys_setfsuid 

BITS 64

global _start
_start:
    mov rax, 122          ;  sys_setfsuid
    mov rdi, 65535
    syscall

    mov rdi, rax          ; on success or failure it 
                          ;  returns the previous value

    mov rax, 60           ;  sys_exit
    syscall
