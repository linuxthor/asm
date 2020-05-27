; linuxthor
;
; sys_capset example
;
; assemble with:
; nasm -f elf64 -o sys_capset.o sys_capset.asm
; ld sys_capset.o -o sys_capset 

BITS 64

%define _LINUX_CAPABILITY_VERSION_1  0x19980330
%define _LINUX_CAPABILITY_VERSION_3  0x20080522

%define CAP_CHOWN            0
%define CAP_DAC_OVERRIDE     1
%define CAP_DAC_READ_SEARCH  2
%define CAP_FOWNER           3
%define CAP_FSETID           4
%define CAP_KILL             5
%define CAP_SETGID           6
%define CAP_SETUID           7
%define CAP_SETPCAP          8
%define CAP_LINUX_IMMUTABLE  9
%define CAP_NET_BIND_SERVICE 10
%define CAP_NET_BROADCAST    11
%define CAP_NET_ADMIN        12
%define CAP_NET_RAW          13
%define CAP_IPC_LOCK         14
%define CAP_IPC_OWNER        15
%define CAP_SYS_MODULE       16
%define CAP_SYS_RAWIO        17
%define CAP_SYS_CHROOT       18
%define CAP_SYS_PTRACE       19
%define CAP_SYS_PACCT        20
%define CAP_SYS_ADMIN        21
%define CAP_SYS_BOOT         22
%define CAP_SYS_NICE         23
%define CAP_SYS_RESOURCE     24
%define CAP_SYS_TIME         25
%define CAP_SYS_TTY_CONFIG   26
%define CAP_MKNOD            27
%define CAP_LEASE            28
%define CAP_AUDIT_WRITE      29
%define CAP_AUDIT_CONTROL    30
%define CAP_SETFCAP          31
%define CAP_MAC_OVERRIDE     32
%define CAP_MAC_ADMIN        33

%define CAP_TO_MASK(x)      (1 << ((x) & 31)) 

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
    mov dword [datap + cap_user_data_t.effective], (CAP_TO_MASK(CAP_SYS_MODULE)|CAP_TO_MASK(CAP_KILL))
    mov dword [datap + cap_user_data_t.permitted], (CAP_TO_MASK(CAP_SYS_MODULE)|CAP_TO_MASK(CAP_KILL))

    mov rax, 126          ;  sys_capset
    mov rdi, hdrp
    mov rsi, datap
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

section .bss
    hdrp  resb cap_user_header_t_size
    datap resb 2 * cap_user_data_t_size

