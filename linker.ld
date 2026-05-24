/*
 * linker.ld - Script del linker per il kernel x86-32
 *
 * Il kernel viene caricato dal bootloader a 0x1000.
 * L'entry point e' kernel_main (definito in kernel.c).
 */

ENTRY(kernel_main)

SECTIONS
{
    . = 0x1000;

    .text   : { *(.text*)   }
    .rodata : { *(.rodata*) }
    .data   : { *(.data*)   }
    .bss    : { *(COMMON) *(.bss*) }
}
