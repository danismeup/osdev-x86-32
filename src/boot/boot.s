; ============================================================
; boot.s - Bootloader x86 MBR (Tappa 1)
; ============================================================
; Caricato dal BIOS a 0x7C00. Gira in real mode (16-bit).
; Stampa un messaggio tramite BIOS int 0x10 e si ferma.
; Tappa 2: qui aggiungeremo il passaggio al Protected Mode.
; ============================================================

[BITS 16]
[ORG 0x7C00]

start:
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00

    mov si, msg_hello
    call print_string

halt:
    cli
    hlt
    jmp halt

; ---- Stampa stringa null-terminated puntata da SI ----
print_string:
    mov ah, 0x0E
.next_char:
    lodsb
    test al, al
    jz .done
    int 0x10
    jmp .next_char
.done:
    ret

; ---- Dati ----
msg_hello db 'Hello from bootloader!', 0x0D, 0x0A, 0

; ---- Padding e firma MBR ----
times 510 - ($ - $$) db 0
dw 0xAA55
