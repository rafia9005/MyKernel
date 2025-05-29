[BITS 16]
[ORG 0x0000]

start:
    mov ax, 0x1000
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0xFFFF

    mov ax, 0x2000
    mov es, ax
    mov bx, 0x0000

    mov ah, 0x02
    mov al, 1
    mov ch, 0
    mov cl, 5
    mov dh, 0
    mov dl, 0x00

    int 0x13
    jc disk_error

    jmp 0x2000:0000

disk_error:
    mov si, error_msg
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

error_msg db "Kernel Disk Read Error!", 0
