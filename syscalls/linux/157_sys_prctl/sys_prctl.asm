; linuxthor
;
; sys_prctl example
;
; prctl allows for all kinds of weird stuff
; to be done to a process.. 
;
; see man page for details
;
; assemble with:
; nasm -f elf64 -o sys_prctl.o sys_prctl.asm
; ld sys_prctl.o -o sys_prctl 

BITS 64

; set or get signal a process will get when
; it's parent dies 
%define PR_SET_PDEATHSIG  1 
%define PR_GET_PDEATHSIG  2  

; get/set current->mm->dumpable 
%define PR_GET_DUMPABLE   3
%define PR_SET_DUMPABLE   4

; get/set process name
%define PR_SET_NAME    15	
%define PR_GET_NAME    16		

; get/set process seccomp mode 
%define PR_GET_SECCOMP	21
%define PR_SET_SECCOMP	22

; get/set ability to use the timestamp counter 
; instruction 
%define PR_GET_TSC 25
%define PR_SET_TSC 26
%define PR_TSC_ENABLE	1  ; allow the use of the timestamp counter 
%define PR_TSC_SIGSEGV	2  ; throw a SIGSEGV instead of reading

; get/set 'securebits' (man 7 capabilities)
%define PR_GET_SECUREBITS 27
%define PR_SET_SECUREBITS 28

; read or change the ambient capability set
%define PR_CAP_AMBIENT			47
%define PR_CAP_AMBIENT_IS_SET		1
%define PR_CAP_AMBIENT_RAISE		2
%define PR_CAP_AMBIENT_LOWER		3
%define PR_CAP_AMBIENT_CLEAR_ALL	4

; get/set the capability bounding set 
%define PR_CAPBSET_READ 23
%define PR_CAPBSET_DROP 24

; prevent the granting of any new privilege
%define PR_SET_NO_NEW_PRIVS	38
%define PR_GET_NO_NEW_PRIVS	39

; get/set timer 'slack' (poll/select/nanosleep)
%define PR_SET_TIMERSLACK 29
%define PR_GET_TIMERSLACK 30

; enable/disable collection of perf events
%define PR_TASK_PERF_EVENTS_DISABLE  31
%define PR_TASK_PERF_EVENTS_ENABLE   32

global _start
_start:

    mov rax, 157          ;  sys_prctl
    mov rdi, PR_GET_TSC
    mov rsi, result
    syscall 

    mov rax, 157          ;  sys_prctl
    mov rdi, PR_SET_TSC
    mov rsi, PR_TSC_SIGSEGV
    syscall

    mov rax, 60           ;  sys_exit
    syscall

section .bss 
    result  resd 1
