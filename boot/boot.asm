[BITS 16]
[ORG 0x7C00]

start:
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00

    mov ax, 0x1000       
    mov es, ax
    mov bx, 0x0000       

    mov ah, 0x02         
    mov al, 3            
    mov ch, 0            
    mov cl, 2            
    mov dh, 0            
    mov dl, 0x00         

    int 0x13
    jc disk_error

    jmp 0x1000:0000      

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

error_msg db "Disk Read Error!", 0

times 510-($-$$) db 0
db 0x55
db 0xAA

