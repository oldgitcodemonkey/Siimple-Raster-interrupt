// filename tables.asm

tables:{


	// The lines on which to fire the interrupts

	intTable:
    .byte 60
    .byte 90
    .byte 120
    .byte 150


    // the colours to change to
    colourTable:
    .byte 0
    .byte 1
    .byte 8
    .byte 4
}