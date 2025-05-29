[BITS 16]
[ORG 0x0000]

start:
    mov ax, 0x3000
    mov ds, ax
    mov si, memory_msg
    call print
    jmp $

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

memory_msg db "Welcome to Memory ASM!", 0

