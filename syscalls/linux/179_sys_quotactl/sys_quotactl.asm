; linuxthor
;
; sys_quotactl example
;
; many weird things can be done with this one
;
; assemble with:
; nasm -f elf64 -o sys_quotactl.o sys_quotactl.asm
; ld sys_quotactl.o -o sys_quotactl 

%define SUBCMDMASK   0x00ff
%define SUBCMDSHIFT  8
%define QCMD(cmd, type)  (((cmd) << SUBCMDSHIFT) | ((type) & SUBCMDMASK))

%define MAXQUOTAS    2
%define GRPQUOTA     1    
%define USRQUOTA     0               

%define Q_SYNC       0x800001        
%define Q_QUOTAON    0x800002        
%define Q_QUOTAOFF   0x800003        
%define Q_GETFMT     0x800004        
%define Q_GETINFO    0x800005        
%define Q_SETINFO    0x800006        
%define Q_GETQUOTA   0x800007        
%define Q_SETQUOTA   0x800008        

BITS 64

global _start
_start:
    mov rax, 179          ;  sys_quotactl
    mov rdi, QCMD(Q_QUOTAOFF,USRQUOTA)
    mov rsi, dev
    mov rdx, 0
    syscall
    
    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

section .data
    dev db '/dev/mapper/devmachine--vg-root',0      ; a block device
