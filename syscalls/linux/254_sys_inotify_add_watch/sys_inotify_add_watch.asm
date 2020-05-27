; linuxthor
;
; sys_inotify_add_watch example
;
; assemble with:
; nasm -f elf64 -o sys_inotify_add_watch.o sys_inotify_add_watch.asm
; ld sys_inotify_add_watch.o -o sys_inotify_add_watch 

BITS 64

%define IN_ACCESS               0x00000001
%define IN_MODIFY               0x00000002
%define IN_ATTRIB               0x00000004
%define IN_CLOSE_WRITE          0x00000008
%define IN_CLOSE_NOWRITE        0x00000010
%define IN_OPEN	                0x00000020
%define IN_MOVED_FROM           0x00000040
%define IN_MOVED_TO             0x00000080
%define IN_CREATE               0x00000100
%define IN_DELETE               0x00000200
%define IN_DELETE_SELF          0x00000400
%define IN_MOVE_SELF            0x00000800

%define IN_CLOSE		(IN_CLOSE_WRITE | IN_CLOSE_NOWRITE) 
%define IN_MOVE			(IN_MOVED_FROM | IN_MOVED_TO) 

%define IN_ONLYDIR              0x01000000
%define IN_DONT_FOLLOW          0x02000000
%define IN_EXCL_UNLINK          0x04000000
%define IN_MASK_CREATE          0x10000000
%define IN_MASK_ADD             0x20000000
%define IN_ISDIR                0x40000000
%define IN_ONESHOT              0x80000000

global _start
_start:
    mov rax, 253          ;  sys_inotify_init 
    syscall

    mov rdi, rax

    mov rax, 254          ;  sys_inotify_add_watch
    mov rsi, pathname
    mov rdx, (IN_OPEN|IN_CLOSE)
    syscall

    mov rax, 60           ;  sys_exit
    mov rdi, 0
    syscall

section .data
   pathname db '/etc/issue',0

