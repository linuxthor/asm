; linuxthor
;
; sys_ioctl example
;
; NOTE: no single standard - Arguments,  returns,  and semantics of ioctl() 
;       vary according to the device driver in question
;
; assemble with:
; nasm -f elf64 -o sys_ioctl.o sys_ioctl.asm
; ld sys_ioctl.o -o sys_ioctl 

BITS 64

; sys_open
%define	O_RDONLY    0x0000
%define	O_WRONLY    0x0001
%define	O_RDWR      0x0002	
%define	O_NONBLOCK  0x0004

; sys_ioctl (not exhaustive..)
;              for there
;                ..are.. 
;                   loads..        
%define TCGETS              0x5401
%define TCSETS              0x5402
%define TCSETSW             0x5403
%define TCSETSF             0x5404
%define TCGETA              0x5405
%define TCSETA              0x5406
%define TCSETAW             0x5407
%define TCSETAF             0x5408
%define TCSBRK              0x5409
%define TCXONC              0x540A
%define TCFLSH              0x540B
%define TIOCEXCL            0x540C
%define TIOCNXCL            0x540D
%define TIOCSCTTY           0x540E
%define TIOCGPGRP           0x540F
%define TIOCSPGRP           0x5410
%define TIOCOUTQ            0x5411
%define TIOCSTI             0x5412
%define TIOCGWINSZ          0x5413
%define TIOCSWINSZ          0x5414
%define TIOCMGET            0x5415
%define TIOCMBIS            0x5416
%define TIOCMBIC            0x5417
%define TIOCMSET            0x5418
%define TIOCGSOFTCAR        0x5419
%define TIOCSSOFTCAR        0x541A
%define FIONREAD            0x541B
%define TIOCLINUX           0x541C
%define TIOCCONS            0x541D
%define TIOCGSERIAL         0x541E
%define TIOCSSERIAL         0x541F
%define TIOCPKT             0x5420
%define FIONBIO             0x5421
%define TIOCNOTTY           0x5422
%define TIOCSETD            0x5423
%define TIOCGETD            0x5424

global _start
_start:
    mov rax, 2            ;  sys_open
    mov rdi, filename
    mov rsi, O_RDONLY
    syscall
 
    mov rdi, rax

    mov rax, 16           ;  sys_ioctl
    mov rsi, TCGETS
    mov rdx, ioreturn
    syscall

    mov rdi, [ioreturn]

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

section .data
    filename  db  '/dev/ttyS0',0

section .bss
    ioreturn resb 1
