# osdev-x86-32

Percorso di studio pratico per la creazione di un sistema operativo x86-32 da zero.

> **Obiettivo**: partire dal bootloader in real mode (16-bit), passare al protected mode (32-bit) e costruire un kernel minimale in C.

---

## Struttura del repo

```
osdev-x86-32/
├── src/
│   ├── boot/
│   │   └── boot.s          # Bootloader x86 (MBR, real mode → protected mode)
│   └── kernel/
│       ├── kernel.c         # Entry point del kernel in C
│       └── kernel.h         # Header condivisi del kernel
├── include/
│   └── types.h              # Tipi base (uint8_t, uint16_t, uint32_t...)
├── scripts/
│   └── setup.sh             # Script setup ambiente Debian
├── Makefile
├── linker.ld
└── README.md
```

---

## Come iniziare su una nuova macchina (Debian)

```bash
git clone https://github.com/danismeup/osdev-x86-32.git
cd osdev-x86-32
chmod +x scripts/setup.sh
./scripts/setup.sh
```

Questo script installa tutto il toolchain necessario.

## Compilare e avviare in QEMU

```bash
make        # compila tutto
make run    # avvia in QEMU
make debug  # avvia con GDB collegato
make clean  # pulisce i file compilati
```

---

## Prerequisiti (installati da setup.sh)

- `nasm` (assembler)
- `gcc` con multilib `-m32` (oppure cross-compiler `i686-elf-gcc`)
- `qemu-system-x86` (emulatore)
- `git`, `make`, `gdb`

---

## Tappe del percorso

| Tappa | Descrizione | Stato |
|-------|-------------|-------|
| 0 | Setup ambiente + toolchain | ✅ |
| 1 | Bootloader MBR: real mode, print via BIOS | 🔜 |
| 2 | Passaggio al Protected Mode (32-bit) | 🔜 |
| 3 | Kernel C: entry point, GDT, IDT | 🔜 |
| 4 | Driver VGA text mode | 🔜 |
| 5 | Gestione interrupt (PIC, IRQ) | 🔜 |
| 6 | Gestione memoria (paginazione) | 🔜 |

---

## Risorse

- [OSDev Wiki](https://wiki.osdev.org)
- [Intel Software Developer Manual Vol. 3A](https://www.intel.com/content/www/us/en/developer/articles/technical/intel-sdm.html)
- [NASM Documentation](https://nasm.us/doc/)
