section .text
global _start

_start:
    ; ----------------------------
    ; Push command string
    ; "echo hello; ls -la"
    ; ----------------------------
    xor rax, rax
    push rax                                ; NULL terminator (bytes 16-23)

    mov rbx, 0x2d20736c203b6f6c             ; "lo; ls -" (bytes 8-15)
    push rbx

    mov rbx, 0x6c6568206f686365             ; "echo hel" (bytes 0-7)
    push rbx

    mov word [rsp+16], 0x616c               ; fix bytes 16-17 to "la"

    mov r12, rsp                            ; r12 = command string

    ; ----------------------------
    ; Push "-c"
    ; ----------------------------
    xor rbx, rbx
    push rax                                ; NULL

    mov bl, 0x63                            ; 'c'
    shl rbx, 8
    mov bl, 0x2d                            ; '-'
    push rbx

    mov r13, rsp                            ; r13 = "-c"

    ; ----------------------------
    ; Push "/bin/bash"
    ; ----------------------------
    push rax                                ; NULL

    mov rbx, 0x7361622f6e69622f             ; "/bin/bas" (bytes 0-7)
    push rbx

    mov byte [rsp+8], 0x68                  ; byte 8 = 'h'

    mov r14, rsp                            ; r14 = "/bin/bash"

    ; ----------------------------
    ; Build argv[] array
    ; argv[3] = NULL
    ; argv[2] = cmd
    ; argv[1] = "-c"
    ; argv[0] = "/bin/bash"
    ; ----------------------------
    push rax                                ; argv[3]
    push r12                                ; argv[2]
    push r13                                ; argv[1]
    push r14                                ; argv[0]

    mov rsi, rsp                            ; argv
    mov rdi, r14                            ; filename
    xor rdx, rdx                            ; envp = NULL

    mov al, 59                              ; execve syscall
    syscall