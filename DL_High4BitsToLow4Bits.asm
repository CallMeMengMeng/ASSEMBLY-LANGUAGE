; EXTRACT FROM <THE PRINCIPLE OF MICROCOMPUTER> TEXTBOOK.
; EXCHANGE 4 HIGH BITS WITH 4 LOW BITS IN DL WITH USING AS LITTLE COMMANDS AS POSSIBLE

CODE	SEGMENT
ASSUME	CS:CODE
START:	MOV CL,4	; SET A FOUR TIMES COUNTER 'CAUSE THERE ARE 4 BITS NEED TO BE EXCHANGED
        MOV DL,69H	; SET DL 69H
        MOV DH,DL	; BACKUP DL TO DH SO AS TO MAKE A COMPARISION
		ROL	DL,CL	; ROTATE DL TO LEFT IN WITH FOUR BITS
		; ROR DL,CL
		HLT
CODE	ENDS
		END START