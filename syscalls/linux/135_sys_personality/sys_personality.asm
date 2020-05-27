; linuxthor
;
; sys_personality example
;
; linux has limited support for binaries for other unix-like
; operating systems via the personality mechanism (see man
; page for full details)
;
; this syscall is used to ask for various workarounds to be
; applied. some personas have no effect at all.  
;
; (sys_personality can be called with the value 0xffffffff
;   to retrieve the current persona without changing it)
;
; assemble with:
; nasm -f elf64 -o sys_personality.o sys_personality.asm
; ld sys_personality.o -o sys_personality 

BITS 64

%define personadef       0xffffffff  
%define PER_LINUX_32BIT  0x00800000
%define PER_SVR4         0x04100001
%define PER_SVR3         0x05000002
%define PER_SCOSVR3      0x07000003
%define PER_OSR5         0x06000003
%define PER_WYSEV386     0x05000004
%define PER_ISCR4        0x04000005
%define PER_BSD          0x00000006
%define PER_SUNOS        0x04000006
%define PER_XENIX        0x05000007
%define PER_LINUX32      0x00000008
%define PER_LINUX32_3GB  0x08000008
%define PER_IRIX32       0x04000009
%define PER_IRIXN32      0x0400000a
%define PER_IRIX64       0x0400000b
%define PER_RISCOS       0x0000000c
%define PER_SOLARIS      0x0400000d
%define PER_UW7          0x0410000e
%define PER_OSF4         0x0000000f
%define PER_HPUX         0x00000010

global _start
_start:
    mov rax, 135          ; sys_personality
    mov rdi, personadef   ; query it without changing it
    syscall

    mov rax, 135          ; sys_personality
    mov rdi, PER_LINUX32_3GB   
    syscall               ; return value may be 
                          ;    the *previous* persona on
                          ;        success or -1 on error.. 

    mov rax, 135          ; sys_personality
    mov rdi, personadef   ; query it
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall
