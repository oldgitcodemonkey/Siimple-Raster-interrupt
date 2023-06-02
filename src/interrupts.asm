// filename interups.asm

interrupts: {

	init: {

	    sei                     // turn off maskable interupts

	    lda #$7f                // kill CIA interupts
	    sta $dc0d
	    sta $dd0d

	    lda $dc0d               // read interupts to clear them
	    lda $dd0d

	    lda #$01                 // get the vic II to do raster interupts
	    sta $d01a


	    lda #$1b				// set the inturpt line
	    sta $d011

	    lda tables.intTable		// set the line to be the first in the table
	    sta raster_y

	    lda #<rasterNOP  		// this is how we set up
	    sta $fffe  				// the address of our interrupt code
	    lda #>rasterNOP
	    sta $ffff
	    
	    cli                     // turn on the interupts

	    rts
	}

	rasterNOP: {

	/* 
	
		This interrupt does nothing, its used for when the interrupt isnt needed

	*/
	pha // save registers
	stx saveX+1

	// clear the interupt signal
	lsr $d019 

	// change the border colour
	ldx zeroPage.intIndex
	lda tables.colourTable,x 
	sta borderColour

	// increase pointer
	inx
	txa
	and #$03
	sta zeroPage.intIndex
	tax

	// set next interrupt

	lda tables.intTable,x
	sta raster_y



	pla // restore registers
saveX:
	ldx #0

	rti 

	}
}