section .text
global _start

_start:
    jmp short two

one:
    pop rbx                      ; rbx = base address of strings

    ; ----------------------------
    ; Insert NULL terminators
    ; ----------------------------
    xor rax, rax
    mov byte [rbx+9], al         ; "/bin/bash"
    mov byte [rbx+12], al        ; "-c"
    mov byte [rbx+31], al        ; "echo hello; ls -la"

    ; ----------------------------
    ; Construct argv[]
    ; ----------------------------
    mov [rbx+32], rbx            ; argv[0] = "/bin/bash"
    lea rcx, [rbx+10]
    mov [rbx+40], rcx            ; argv[1] = "-c"
    lea rcx, [rbx+13]
    mov [rbx+48], rcx            ; argv[2] = command string
    mov [rbx+56], rax            ; argv[3] = NULL

    ; ----------------------------
    ; Prepare execve arguments
    ; ----------------------------
    mov rdi, rbx                 ; filename = "/bin/bash"
    lea rsi, [rbx+32]            ; argv
    xor rdx, rdx                 ; envp = NULL

    mov al, 59                   ; execve syscall
    syscall

two:
    call one
    db "/bin/bash", 0xFF
    db "-c", 0xFF
    db "echo hello; ls -la", 0xFF
    dq 0x4141414141414141         ; argv[0]
    dq 0x4242424242424242         ; argv[1]
    dq 0x4343434343434343         ; argv[2]
    dq 0x4444444444444444         ; argv[3]