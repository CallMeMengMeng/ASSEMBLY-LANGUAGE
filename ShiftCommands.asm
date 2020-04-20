; A PROGRAM PRESENTS THE RESULTS OF 'SHR','SAR','ROR','RCR',RESPECTIVELY, TO HELP
; US MAKE THE PROGRESSES AND DIFFERENCES AMONG THESE COMMANDS UNDERSTOOD.

DATA SEGMENT
    BUFF DB 4 DUP(0)        
    NUMB DB 9DH   
    MES0 DB 0DH,0AH,'THE RESULT OF COMMAND <SHR AL,2>: $'
    MES1 DB 0DH,0AH,'THE RESULT OF COMMAND <SAR AL,2>: $'
    MES2 DB 0DH,0AH,'THE RESULT OF COMMAND <ROR AL,2>: $'
    MES3 DB 0DH,0AH,'THE RESULT OF COMMAND <RCR AL,2>: $'   
    MES4 DB 0DH,0AH,'CF: 0 $'
DATA ENDS      

STACK SEGMENT PARA STACK 'STACK'
    DB 10 DUP(0)
STACK ENDS

CODE SEGMENT
    ASSUME CS:CODE,DS:DATA
START:
    MOV AX,DATA
    MOV DS,AX
    LEA SI,BUFF 
    MOV CL,2        ; SHIFT/ROTATE 9DH 2 BITS TO RIGHT
    MOV AL,NUMB   
    
    PUSH AX
    PUSH AX
    PUSH AX 
    PUSH AX
           
    POP AX 
    SHR AL,CL      ; THE RESULT OF 'SHR'
    MOV [SI],AL
    INC SI
    
    POP AX
    SAR AL,CL     ; THE RESULT OF 'SAR'
    MOV [SI],AL  
    INC SI     

    POP AX
    ROR AL,CL     ; THE RESULT OF 'ROR'                 
    MOV [SI],AL  
    INC SI 
    
    POP AX
    RCR AL,CL     ; THE RESULT OF 'RCR'
    MOV [SI],AL  
  
NEXT:
    LEA SI,BUFF   ; CALL THE 'DISP' SUBROUTINE TO DISPLAY EVERY BIT OF [SI]
    
    MOV AH,09H
    MOV DX,OFFSET MES4
    INT 21H
    
    MOV AH,09H
    MOV DX,OFFSET MES0
    INT 21H
    CALL DISP 
    INC SI
  
    MOV AH,09H
    MOV DX,OFFSET MES1
    INT 21H  
    CALL DISP
    INC SI

    MOV AH,09H 
    MOV DX,OFFSET MES2
    INT 21H
    CALL DISP 
    INC SI   
    
    MOV AH,09H
    MOV DX,OFFSET MES3
    INT 21H
    CALL DISP       
    
QUIT:
    MOV AH,4CH
    INT 21H
           
DISP PROC NEAR  
    MOV DH,[SI] 
    MOV CX,08H
    MOV AH,02H
AGAIN: 
    MOV DL,DH
    AND DL,80H 
    PUSH CX 
    MOV CL,07H
    SHR DL,CL 
    ADD DL,30H 
    POP CX
    INT 21H 
    SHL DH,1
    LOOP AGAIN
    RET
DISP ENDP
 
CODE ENDS
    END START
    
