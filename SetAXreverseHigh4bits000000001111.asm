; EXTRACT FROM <THE PRINCIPLE OF MICROCOMPUTER> TEXTBOOK.
; REVERSE AX HIGH 4 BITS, SET THE LAST 4 BITS 1, AND THE OTHER BITS 0.  

CODE	SEGMENT
ASSUME	CS:CODE
START:	MOV AX,08980H	; HEX. NUMBER SHOULD START WITH ZERO
		XOR	AX,0F000H	; SAME NUMBERS LEAD TO ZERO THAT CAN REVERSE THE FIRST 4 BITS
		AND	AX,0F00FH	; ZERO 'AND' ZERO(OR 1) EQUALS TO ZERO THAT MAKE THE MIDDLE 8 BITS 0
		MOV	AL,0FH		; MAKE THE LAST 4 BITS 1
CODE	ENDS
		END START