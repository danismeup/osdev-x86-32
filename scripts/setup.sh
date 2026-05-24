#!/usr/bin/env bash
# =============================================================
# setup.sh - Ambiente OS-dev su Debian (host fisico o GCP VM)
# =============================================================
set -e

echo "======================================="
echo " osdev-x86-32 - Setup ambiente Debian"
echo "======================================="

echo "[1/4] Aggiornamento pacchetti..."
sudo apt-get update -y

echo "[2/4] Installazione toolchain..."
sudo apt-get install -y \
    build-essential gcc-multilib \
    nasm \
    qemu-system-x86 \
    git make gdb curl vim

echo "[3/4] Verifica cross-compiler i686-elf-gcc..."
if command -v i686-elf-gcc &>/dev/null; then
    echo "  -> i686-elf-gcc: OK"
else
    echo "  -> i686-elf-gcc non trovato: si usera' gcc -m32"
    echo "     Per il cross-compiler: https://wiki.osdev.org/GCC_Cross-Compiler"
fi

echo "[4/4] Verifica tools..."
for tool in nasm gcc make qemu-system-i386 gdb git; do
    command -v $tool &>/dev/null && echo "  -> $tool: OK" || echo "  -> $tool: NON TROVATO"
done

echo ""
echo "Ambiente pronto! Comandi:"
echo "  make        # compila"
echo "  make run    # avvia in QEMU"
echo "  make debug  # avvia con GDB"
echo "  make clean  # pulisce build/"
