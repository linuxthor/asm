; linuxthor
;
; sys_semop example
;
; assemble with:
; nasm -f elf64 -o sys_semop.o sys_semop.asm
; ld sys_semop.o -o sys_semop 

BITS 64

struc sembuf
    .sem_num  resw 1
    .sem_op   resw 1
    .sem_flg  resw 1
endstruc

; sys_semget
%define IPC_PRIVATE   0
%define	IPC_CREAT     01000	
%define	IPC_EXCL      02000	
%define	IPC_NOWAIT    04000	

global _start
_start:
    mov rax, 64           ;  sys_semget
    mov rdi, 1066         
    mov rsi, 3
    mov rdx, IPC_CREAT
    syscall

    mov rdi, rax

    mov word [semzops + sembuf.sem_num], 2
    mov word [semzops + sembuf.sem_op], 0
    mov word [semzops + sembuf.sem_flg], 0

    mov rax, 65           ;  sys_semop
    mov rsi, semzops
    mov rdx, 1
    syscall 

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

section .bss
    semzops resb sembuf_size
