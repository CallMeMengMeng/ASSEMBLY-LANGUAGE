; In EMU8086, try to write a program to call the interrupt function.
; Set the interrupt code of this subroutine to 80H.

DATA SEGMENT
    SUM DW 0
DATA ENDS

STACK SEGMENT PARA STACK 'STACK'
    DB 10 DUP(0)
STACK ENDS

CODE SEGMENT        
    ASSUME CS:CODE,DS:DATA
START:
    MOV AX,DATA
    MOV DS,AX
    
    MOV AX,0
    MOV ES,AX
                                ; INIT THE INTERRUPT VECTOR TABLE
    MOV AX,OFFSET CHANGE        ; GET THE OFFSET ADDRESS
    MOV WORD PTR ES:[80H*4],AX  ; SET AS IP 
    MOV AX,SEG CHANGE           ; GET THE SEGMENT ADDRESS
    MOV WORD PTR ES:[80H*4+2],AX; SET AS CS   
    
    CALL SUMFIVEODDNUMBERS  
    
    INT 80H                     
    HLT
    
SUMFIVEODDNUMBERS PROC NEAR
    MOV CX,5
    MOV AX,0
    MOV BX,1
AGAIN:
    ADD AX,BX
    ADD BX,2
    LOOP AGAIN
    RET
ENDP

CHANGE PROC NEAR
    PUSH AX
    
    MOV AX,2233H
    MOV SUM,AX
    
    POP AX
    IRET
ENDP

CODE ENDS
    END START
    
    