; EXTRACT FROM <THE PRINCIPLE OF MICROCOMPUTER> TEXTBOOK.
; JUDGE THE SIGNED NUMBER IN AL: IF IT'S NEGATIVE SET AH -1, OTHERWISE SET AH 0

CODE	SEGMENT
ASSUME	CS:CODE
START:	MOV AL,-2
		CMP	AL,0		; COMPARE AL WITH 0
		JS	NEGATIVE	; IF SIGN FLAG IS 1 WHICH MEANS AL IS NEGATIVE, JUMP TO NEGATIVE 
		MOV AH,0		; IF SIGN FLAG IS 0 THAT MEANS AL IS POSITIVE, SET AH 0
		HLT
NEGATIVE:	MOV AH,-1
CODE	ENDS
		END START