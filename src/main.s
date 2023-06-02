/*

	banded multiplexor POC

	(c) AMK June 2023
*/

#import "./vic.asm"
#import "./zeroPage.asm"


// Macro for timing bars


.var debugging = true

.macro flash(colour)
	{
	.if (debugging){
		lda #colour
		sta $d020
	}
}

// create basic loader to run code at subroutine main

BasicUpstart2(main)

* = $900 "main"

main: {

	lda #0
	sta zeroPage.intIndex

	jsr setUp.initHardware
	jsr interrupts.init

!stop:
	nop
	jmp !stop-

}


// import some basic libraries
#import "./tables.asm"
#import "./hardwareinit.s"
#import "./interrupts.asm"