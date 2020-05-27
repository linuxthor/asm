; linuxthor
;
; sys_msgsnd example
;
; assemble with:
; nasm -f elf64 -o sys_msgsnd.o sys_msgsnd.asm
; ld sys_msgsnd.o -o sys_msgsnd

BITS 64

%define IPC_NOWAIT     04000o

struc msgbuf
    .mtype resq 1
    .mtext resb 128     ; which is to say msgsz
endstruc

; sys_msgget
%define IPC_PRIVATE     0
%define	IPC_CREAT       01000o

global _start
_start:
    mov rax, 68           ;  sys_msgget
    mov rdi, IPC_PRIVATE
    mov rsi, (IPC_CREAT|0666o)
    syscall

    mov [qid], rax

    mov qword [msgs + msgbuf.mtype], 1
    mov rbx, msgs + msgbuf.mtext
    mov rcx, msg
gain:
    mov rax, [rcx]
    mov [rbx], rax
    add rax, 8
    add rbx, 8
    add rcx, 8
    cmp rbx, msgs + msgbuf.mtext + len 
    jl  gain 
 
    mov rax, 69           ;  sys_msgsnd
    mov rdi, [qid]
    mov rsi, msgs
    mov rdx, len
    mov r10, IPC_NOWAIT
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

section .data
    msg db 'abcdefghijklmnopqrstuvwxyz'
    len equ $-msg

section .bss
    msgs resb msgbuf_size
    qid resq 1
