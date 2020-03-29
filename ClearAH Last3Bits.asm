; EXTRACT FROM <THE PRINCIPLE OF MICROCOMPUTER> TEXTBOOK.
; CLEAR THE LAST 3 BITS IN AH

CODE	SEGMENT
ASSUME	CS:CODE
START:	MOV AH,8FH
		MOV CL,3	; SET A 3 TIMES COUNTER
		SHR	AH,CL	; SHIFT 3 BITS TO RIGHT TO CLEAR THE LAST 3 BITS
		SHL AH,CL	; SHIFT 3 BITS TO LEFT TO MAKE THE LAST 3 BITS ZERO
CODE	ENDS
		END	START