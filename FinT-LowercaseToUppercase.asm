; Input from your keyboard, and convert the lowercase character to uppercase character.

DATA SEGMENT
    MES DB 0DH,0AH,'PLEASE INPUT A CHARACTER: $'
DATA ENDS

CODE SEGMENT
    ASSUME CS:CODE,DS:DATA
START:
    MOV AX,DATA
    MOV DS,AX 
    MOV CX,10
    
    MOV AH,09H
    MOV DX,OFFSET MES
    INT 21H
AGAIN:
    MOV AH,01H
    INT 21H
    CMP AL,61H
    JL SKIP
    CMP AL,7AH
    JG SKIP
    SUB AL,20H
    MOV AH,02H
    MOV DL,AL
    INT 21H
SKIP:
    LOOP AGAIN
    HLT
CODE ENDS
    END START