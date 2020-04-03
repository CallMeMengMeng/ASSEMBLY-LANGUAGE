; IN AN ARRAY WHOSE FIRST ADDRESS IS TABLE, 100 16-BIT COMPLEMENT NUMBERS ARE STORED 
; IN ASCENDING ORDER. TRY TO WRITE A PROGRAM TO STORE THE MOST FREQUENTLY OCCURING
; NUMBER AND ITS OCCURENCE IN AX AND CX, RESPECTIVELY.

DATA	SEGMENT
TABLE	DW	50 DUP(-10),10 DUP(0),20 DUP(70),20 DUP(80)
LEN		DW	($-TABLE)/2
MAX_APP	DW	0
MAX_NUM	DW	0
DATA	ENDS

CODE	SEGMENT
ASSUME	CS:CODE,DS:DATA
START:	MOV AX,DATA
		MOV DS,AX
		LEA SI,TABLE
		MOV CX,LEN
		MOV AX,0
		MOV BX,0
    	MOV DI,SI
LOOP1:  MOV AX,[DI]
LOOP2:	CMP AX,[SI]
		JNZ NOTEQU
		INC BX
		ADD SI,2
		LOOP LOOP2
		MOV CX,LEN
NOTEQU:	CMP BX,MAX_NUM
		JNA AGAIN
		XCHG BX,MAX_NUM
		MOV MAX_APP,AX
AGAIN:	ADD DI,2 
        MOV BX,0
		DEC CX
		JNZ LOOP1
		MOV AX,MAX_APP
		MOV CX,MAX_NUM
		HLT
CODE	ENDS
		END START
		
; NOTE:
; CMP [DI],[SI] IS ILLEGAL.