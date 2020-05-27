; linuxthor
;
; sys_ustat example
;
; a deprecated syscall.. use statfs
;
; assemble with:
; nasm -f elf64 -o sys_ustat.o sys_ustat.asm
; ld sys_ustat.o -o sys_ustat 

BITS 64

struc ubuf
    .f_tfree   resd 1
    .f_tinode  resq 1
    .f_name    resb 6
    .f_pack    resb 6
endstruc

global _start
_start:
    mov rax, 136          ;  sys_ustat
    mov rdi, 1            ;  dev_t dev
    mov rsi, ubufst
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, [ubufst + ubuf.f_tinode]
    syscall

section .bss
    ubufst resb ubuf_size

