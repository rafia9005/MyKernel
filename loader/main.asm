[BITS 16]
[ORG 0x0000]

start:
    mov ax, 0x2000
    mov ds, ax
    mov si, welcome_msg
    call print
    ret

print:
    mov ah, 0x0E
.next_char:
    lodsb
    or al, al
    jz .done
    int 0x10
    jmp .next_char
.done:
    ret

welcome_msg db "Welcome to MyKernel!", 0
