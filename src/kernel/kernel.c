/*
 * kernel.c - Entry point del kernel x86-32 (Tappa 3)
 *
 * Scrive direttamente nel VGA text buffer (0xB8000).
 * Prerequisito: il bootloader deve aver abilitato il Protected Mode.
 */

#include "kernel.h"

#define VGA_BUFFER  ((volatile unsigned short *)0xB8000)
#define VGA_COLS    80
#define VGA_ROWS    25
#define VGA_COLOR(bg, fg)  (((bg) << 4) | (fg))
#define COLOR_BLACK  0x0
#define COLOR_GREEN  0x2
#define COLOR_WHITE  0xF

static int cursor_col = 0;
static int cursor_row = 0;

static void vga_putchar(char c, unsigned char color)
{
    if (c == '\n') { cursor_col = 0; cursor_row++; return; }
    int index = cursor_row * VGA_COLS + cursor_col;
    VGA_BUFFER[index] = (unsigned short)c | ((unsigned short)color << 8);
    if (++cursor_col >= VGA_COLS) { cursor_col = 0; cursor_row++; }
}

static void vga_print(const char *str, unsigned char color)
{
    while (*str) vga_putchar(*str++, color);
}

static void vga_clear(void)
{
    unsigned char color = VGA_COLOR(COLOR_BLACK, COLOR_WHITE);
    for (int i = 0; i < VGA_COLS * VGA_ROWS; i++)
        VGA_BUFFER[i] = (unsigned short)' ' | ((unsigned short)color << 8);
    cursor_col = cursor_row = 0;
}

void kernel_main(void)
{
    unsigned char color = VGA_COLOR(COLOR_BLACK, COLOR_GREEN);
    vga_clear();
    vga_print("Kernel x86-32 avviato!\n", color);
    vga_print("Benvenuto nel tuo primo OS.\n", color);
    vga_print("\nTappe successive:\n", color);
    vga_print("  - GDT (Global Descriptor Table)\n", color);
    vga_print("  - IDT (Interrupt Descriptor Table)\n", color);
    vga_print("  - Gestione memoria\n", color);
    for (;;) __asm__ volatile ("hlt");
}
