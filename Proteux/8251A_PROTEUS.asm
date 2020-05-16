; USE 8251A TO DISPLAY "HELLO WORLD! " WITHIN PROTEUS.

DATA SEGMENT
	BUFFER DB  'HELLO WORLD! '   
DATA ENDS

STACK SEGMENT PARA STACK 'STACK'
    DB 100 DUP(0)
STACK ENDS

CODE SEGMENT
    ASSUME CS:CODE,DS:DATA
START:
	;SET DATA SEGMENT reg
    MOV AX, DATA
    MOV DS, AX

	
    MOV    AL,4EH  
    OUT    42H,AL
    MOV    AL,37H
    OUT    42H,AL
    
    MOV    CX,13
    MOV    BX,0
NEXT:            
    MOV    AL,BUFFER[BX]
    OUT    40H,AL    
    
BUSY: 
    IN      AL,42H
    TEST    AL,01H
    JZ      BUSY    
    
    INC    BX  
    DEC    CX
    JNZ    NEXT
    
    MOV    CX,13
    MOV    BX,0
    JMP    NEXT       

CODE ENDS
    END START 
     
    