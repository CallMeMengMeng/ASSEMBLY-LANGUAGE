; A string of characters "HELLO!" with SRC_MES as the 
; offset adress in the data segment is required to be 
; transferred to the unit starting with NEW_LOC in the
; additional segment.

DATA	SEGMENT
SRC_MES	DB	'HELLO!'
DATA	ENDS

EXTRA	SEGMENT
; NEW_LOC	DB	6	DUP(?) IS ILLEGAL, EMU8086 DONT SUPPORT
NEW_LOC	DB	6	DUP(0)
EXTRA	ENDS

CODE	SEGMENT
ASSUME	DS:DATA,ES:EXTRA,CS:CODE
START:	MOV AX,DATA
		MOV	DS,AX
		MOV AX,EXTRA
		MOV	ES,AX
		LEA	SI,SRC_MES
		LEA	DI,NEW_LOC
		MOV	CX,6
		CLD
		REP	MOVSB
CODE	ENDS
		END	START