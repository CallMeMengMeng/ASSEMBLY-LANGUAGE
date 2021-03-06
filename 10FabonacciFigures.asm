; CALCULATE THE FIRST 10 FABONACCI FIGURES

DATA	SEGMENT
FABONA	DB	1,1,8DUP(0)		; DEFINE AN ARRAY WITH 10 ELEMENTS TO STORE FABONACCI FIGURES
DATA	ENDS

CODE	SEGMENT
ASSUME	CS:CODE,DS:DATA
START:	MOV AX,DATA
		MOV DS,AX
		MOV CX,9   			; SET A 9 TIMES COUNTER
		MOV BX,0  
		MOV AX,0
		LEA SI,FABONA		; OBTAIN THE START ADDRESS OF FABONACCI ARRAY
		INC SI				; MOVE THE POINTER TO THE NEXT FIGURES
AGAIN:	MOV BL,[SI-1]		; BL=FABONA[0]
		MOV AL,[SI]			; AL=FABONA[1]
		ADD AL,BL			; AL=FABONA[0]+FABONA[1]
		INC SI
		MOV [SI],AL  		; STORE AL IN FABONA[2]
		LOOPNZ AGAIN		; LOOP 9 TIMES
		HLT
CODE	ENDS
		END START
		

; THE FOLLOWING PROGRAM WAS GIVEN BY MY TEACHER

; DATA	SEGMENT
; SUM	DB	10 DUP(1)
; DATA	ENDS
; CODE	SEGMENT
; ASSUME CS:CODE,DS:DATA
; START:	MOV AX,DATA
;		MOV DS,AX
;		MOV SI,2
;		MOV CX,10
;		MOV AX,0
; NEXT:		MOV AL,SUM[SI-2]
;		ADD AL.SUM[SI-1]
;		MOV SUM[SI],AL
;		INC SI
;		DEC CX
;		JNE NEXT
;		HLT
; CODE	ENDS
;	END START
