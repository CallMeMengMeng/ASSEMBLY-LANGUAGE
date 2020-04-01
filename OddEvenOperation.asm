; THERE ARE TWO 16-BIT FIGURES A AND B:
; IF THERE IS ONE ODD FIGURE BETWEEN THEM, STORE IT IN A AND THE EVEN ONE IN B 
; IF THEY ARE ALL ODD DECREASE THEM AND STORE BACK
; IF THEY ARE ALL EVEN KEEP THEM UNCHANGED

DATA	SEGMENT
A	DW	01118H			; A=01118H EVEN
B	DW	01117H			; B=01117H ODD
DATA	ENDS

CODE	SEGMENT
ASSUME	CS:CODE,DS:DATA
START:	MOV AX,DATA
		MOV DS,AX
		MOV AX,A
		MOV BX,B
		XOR AX,BX		; KEEP THOSE DIFFERENT BITS IN AX
		TEST AX,0001H	; IF THE RESULT IS ZERO, IT MEANS A=B
		JZ	NEXT
		TEST BX,0001H	; OTHERWISE A IS DIFFERENT FROM B, B IS EVEN WHILE A IS ODD 
		JZ	EXIT
		XCHG BX,A		; IF A IS EVEN WHILE B IS ODD, JUST EXCHAANGE THEM
		MOV B,BX
		JMP EXIT
NEXT:	TEST BX,0001H	; IF BX'S LAST BIT IS ZERO, THEY ARE ALL EVEN FIGURES
		JZ	EXIT
		DEC A			; OTHERWISE THEY ARE ODD FIGURES, A-1,B-1
		DEC B
		JMP EXIT
EXIT:	HLT 
CODE    ENDS
        END START