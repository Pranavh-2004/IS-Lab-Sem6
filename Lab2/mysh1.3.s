section .text
global _start

_start:
    xor eax, eax

    ; -------------------------
    ; "ls -la"
    ; -------------------------
    push eax
    sub esp, 6
    mov byte [esp],     0x6c    ; l
    mov byte [esp+1],   0x73    ; s
    mov byte [esp+2],   0x20    ; space
    mov byte [esp+3],   0x2d    ; -
    mov byte [esp+4],   0x6c    ; l
    mov byte [esp+5],   0x61    ; a
    mov esi, esp

    ; -------------------------
    ; "-c"
    ; -------------------------
    push eax
    sub esp, 2
    mov byte [esp],     0x2d    ; -
    mov byte [esp+1],   0x63    ; c
    mov edi, esp

    ; -------------------------
    ; "/bin/sh"
    ; -------------------------
    push eax
    push 0x68732f2f     ; //sh
    push 0x6e69622f     ; /bin
    mov ebx, esp

    ; -------------------------
    ; argv[] construction
    ; -------------------------
    push eax            ; argv[3] = 0
    push esi            ; argv[2] = "ls -la"
    push edi            ; argv[1] = "-c"
    push ebx            ; argv[0] = "/bin/sh"
    mov ecx, esp

    ; -------------------------
    ; execve
    ; -------------------------
    xor edx, edx
    mov al, 0x0b
    int 0x80