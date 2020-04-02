; THERE IS A STRING NAMED "ENG" ENDED WITH '$', SERCH "IS" IN THE STRING AND DISPLAY THE QUANTITY.

DATA	SEGMENT
ENG	DB	'THIS IS AN ENGLISH EXAMPLE.',0DH,0AH,'$'	; A STRING NAMED "ENG"
LEN	EQU	$-ENG					; GET THE STRING'S LENGTH
RESULT	DB	'IS: $'				; SEARCH "IS"
DATA	ENDS

CODE	SEGMENT
ASSUME	CS:CODE,DS:DATA
START:	MOV AX,DATA
		MOV DS,AX
		LEA SI,ENG				; GET THE START ADDRESS OF ENG
		MOV CX,LEN-3			; DECREASE 0DH 0AH $ WHICH ARE USED FOR DISPLAYING THEN SET A COUNTER
		MOV BX,0				; STORE THE NUMBER OF "IS"
SEARCH:	CMP [SI],'I'			; COMPARE THE FIRST CHARACTER OF ENG WITH 'I'
		JNZ NOT_MATCH			; IF NOT COMPARED, JUMP TO NOT_MATCH
		CMP [SI+1],'S'			; OTHERWISE IT IS 'I' THEN COMPARE THE SECOND CHARACTER WITH 'S'
		JNZ NOT_MATCH
MATCH:	INC BX					; MATCHED, BX INCREASE 1
		INC SI					; NOW SI IS STILL AT THE FIRST CHARACTER, SO SI INCREASE
NOT_MATCH:	INC SI				; GO TO THE NEXT CHARACTER
		CMP SI,CX
		JB	SEARCH
DISP:	MOV AH,09H
		MOV DX,OFFSET ENG		; DISPLAY THE STRING
		INT 21H 
		MOV AH,09H
		MOV DX,OFFSET RESULT	; DISPLAY THE RESULT 
		INT 21H   
		MOV AX,BX
		MOV BL,0AH				; BX IS DIVIDED BY 10 
		DIV BL
		MOV DL,AH
		ADD DL,'0'				; TURN BX TO CHARACTER NUMBER
		MOV AH,02H				; DISPLAY BX
		INT 21H  

CODE	ENDS
		END START
		
		
; MY TEXTBOOK PROVIDES ANOTHER WAY TO ACHIEVE STRING MATCH:
; DATA	SEGMENT
; ENG	DB	'THIS IS AN PROGRAM EXAMPLE$'
; N1	EQU	$-ENG
; STR	DB	'IS'
; N2	EQU	4-STR
; DATA	ENDS
; CODE	SEGMENT
; ASSUME CS:CODE,DS:DATA,ES:DATA
; START: 
;	MOV AX,DATA
;	MOV DS,AX
;	MOV ES,AX
; 	XOR DX,DX
; 	MOV CL,N1
; 	XOR CH,CH
; 	CMP CX,N2
;	JBE DISP
;	MOV AL,STR
;	LEA DI,ENG
;	CLD
; SEARCH:
;	REPNE SCASB
;	JNE DISP
;	MOV BL,STR+1
;	CMP ES:[DI],BL
;	JE  EXIST
;	JCXZ DISP
; LOP:
;	JMP SEARCH
; EXIST:
;	INC DL
;	CMP CX,1
;	JZ DISP
;	JMP LOP
; DISP:
;	OR DL,30H
;	MOV AH,2
;	INT 21H
;	MOV AH,4CH
;	INT 21H
; CODE 	ENDS
;	END START