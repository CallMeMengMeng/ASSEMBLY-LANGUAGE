; There are 10 byte unsigned-figures stored in SDATA, 
; try to figure out how many figures among them cannt
; be diveded by 11 and store the count into COUNT.

; + Write a subroutine to achieve the judgement, the 
;   entry parameters should be stored in AL and the 
;   export parameters should be stored in ZF (ZF=1 means 
;   this unsigned-figure is divisible);
; + Finish the complete code segment and data segment.

DATA SEGMENT
    SDATA DB 11,22,33,4,5,6,77,87,99,121
    COUNT DB 0
DATA ENDS

STACK SEGMENT PARA STACK 'STACK'
    DB 20 DUP(0)
STACK ENDS

CODE SEGMENT
    ASSUME CS:CODE,DS:DATA
START:
    MOV AX,DATA
    MOV DS,AX
    MOV ES,AX
    LEA SI,SDATA
    MOV CX,10
    
NEXT:
    MOV AL,[SI]
    CALL DIV11
    JNZ GOON
    INC COUNT
GOON:
    INC SI
    LOOP NEXT
    HLT
    
DIV11 PROC NEAR
    MOV AH,0
    MOV BL,11
    DIV BL
    OR AH,0
    RET
DIV11 ENDP

CODE ENDS
    END START