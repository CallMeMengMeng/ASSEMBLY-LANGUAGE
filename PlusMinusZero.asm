; THERE ARE 12 SIGN NUMBER IN TABLE, COUNT THE NUMBER OF PLUS MINUS 0,RESPECTIVELY

DATA	SEGMENT
TABLE	DB	23h,78h,56h,0abh,00h,0cdh,59h,00h,23h,0efh,00h,0c0h
PLUS	DB	(0)
MINUS	DB	(0)
ZERO	DB	(0)
DATA	ENDS

CODE	SEGMENT
ASSUME	DS:DATA,CS:CODE
START:	MOV AX,DATA
		MOV DS,AX
		LEA	SI,TABLE
		MOV CX,12
AGAIN:  CMP	TABLE[SI],0
		JL	P1
		JZ	P2
		JG	P3  
		
P1:		INC	MINUS
		INC	SI
		DEC CX
		JNZ	AGAIN 
		JZ  DONE
		;JMP	END         THIS COMMAND IS ILLEGAL IN EMU8086
		
P2:		INC	ZERO
		INC SI
		DEC CX
		JNZ AGAIN   
		JZ  DONE
		;JMP	END
		
P3:		INC	PLUS
		INC	SI
		DEC	CX
		JNZ	AGAIN   
		JZ  DONE
		;JMP	END  
		
DONE:   MOV AH,4CH
		INT 21H
CODE	ENDS
		END	START
		
; Note:                
;
; In the first version, I input a '98h' among these TABLE numbers,  
;
; then I got "PLUS:4, MINUS:5, ZERO:3" which meant the 98h was negative.
;      
; WTF...WAITTT...That's true. Given that the scale of signed numbers
;
; presented by 1 byte is from -128 to 127, 98h equals to -104 or 152
;
; (overflowing), consequently, 98h is negative. After replacing 98h 
; 
; with 23h, the result is correct.  