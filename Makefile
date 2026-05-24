# ============================================================
# Makefile - osdev-x86-32
# ============================================================
# Richiede:
#   - nasm (assembler)
#   - i686-elf-gcc (cross-compiler) oppure gcc con -m32
#   - qemu-system-i386
# ============================================================

ASM       = nasm
CC        = i686-elf-gcc
LD        = i686-elf-ld

# Fallback: usa gcc -m32 se il cross-compiler non e' disponibile
ifeq (,$(shell which $(CC) 2>/dev/null))
  CC           = gcc
  LD           = ld
  CFLAGS_EXTRA = -m32
  LDFLAGS_ARCH = -m elf_i386
else
  CFLAGS_EXTRA =
  LDFLAGS_ARCH =
endif

QEMU      = qemu-system-i386

SRC_BOOT  = src/boot/boot.s
SRC_KERN  = src/kernel/kernel.c

OBJ_DIR   = build
IMG       = $(OBJ_DIR)/os.img
KERNEL    = $(OBJ_DIR)/kernel.bin
BOOT_BIN  = $(OBJ_DIR)/boot.bin

CFLAGS    = -ffreestanding -fno-builtin -fno-stack-protector \
             -nostdinc -nostdlib -Wall -Wextra -O0 -g \
             $(CFLAGS_EXTRA)

LDFLAGS   = -T linker.ld --oformat binary -nostdlib $(LDFLAGS_ARCH)

.PHONY: all run debug clean

all: $(IMG)

$(BOOT_BIN): $(SRC_BOOT) | $(OBJ_DIR)
	$(ASM) -f bin $< -o $@

$(OBJ_DIR)/kernel.o: $(SRC_KERN) | $(OBJ_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

$(KERNEL): $(OBJ_DIR)/kernel.o
	$(LD) $(LDFLAGS) $< -o $@

$(IMG): $(BOOT_BIN) $(KERNEL)
	cat $(BOOT_BIN) $(KERNEL) > $@

run: $(IMG)
	$(QEMU) -drive format=raw,file=$(IMG) -no-reboot -no-shutdown

debug: $(IMG)
	$(QEMU) -drive format=raw,file=$(IMG) -s -S -no-reboot -no-shutdown &
	gdb -ex "target remote :1234" -ex "symbol-file $(KERNEL)"

clean:
	rm -rf $(OBJ_DIR)

$(OBJ_DIR):
	mkdir -p $(OBJ_DIR)
