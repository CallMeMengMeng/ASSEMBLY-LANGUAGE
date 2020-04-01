; BUF CONTAINS 10 SIGNED NUMBERS: -1,3,24,94,62,72,55,0,-48,99, FIND THE AVERAGE AND MAX NUMBER IN IT.

DATA	SEGMENT
BUF	DW	-1,3,24,94,62,72,55,0,-48,99	; SET A BUFFET FOR THIS ARRAY
N	DW	($-BUF)/2						; TIMES OF COMPARISION
MAX	DW	0								; VARIABLE STORING THE MAX NUMBER 
AVE	DW	0								; VARIABLE STORING THE AVERAGE
DATA	ENDS

CODE	SEGMENT
ASSUME	CS:CODE,DS:DATA
START:	MOV AX,DATA
		MOV DS,AX
		LEA SI,BUF
		MOV CX,N
		CLC								; CLEAR CF
		MOV DX,0						; STORE SUM RESULT 
		MOV AX,[SI]						; START COMPARISION
NEXT:	ADC DX,[SI]						; SUM WITH NEXT NUMBER
		CMP AX,[SI]						; COMPARE WITH NEXT NUMBER
		JGE GOON						; IF GREAT THAN THE NEXT NUMBER JUMOP TO GOON
		XCHG AX,[SI]					; OTHERWISE EXCHANGE THEM TO MAKE SURE AX CONTAIN THE MAX NUMBER
GOON:	INC SI
		INC SI							; 'CAUSE 1 WORD=2 BYTES
		LOOP NEXT						; BACK TO NEXT
		
		MOV MAX,AX						; STORE AX IN MAX
		MOV BX,N
		MOV AX,DX
		IDIV BL							; AX=AVERAGE=SUM[BUFFET]/AL
		MOV AVE,AX						; STORE AX IN AVE
		MOV AH,4CH
		INT 21H
CODE	ENDS
		END START