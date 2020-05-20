; Control 8 LEDs with 8255A's port-A according to the state of switches. 
; The port-B of 8255A connects with 2 switches K0 and K1: When K0 is 
; closed, these LEDs should light up in a left cycle, and they should 
; light up in a right cycle when K1 is closed.

; PS. 
; I assumed that whether [PB1,PB0]=[1,1] or [PB1,PB0]=[0,0], these
; LEDs would be reset to the origin state.     

CODE SEGMENT
    ASSUME CS:CODE
START:
    MOV DX,203H
    MOV AL,82H
    OUT DX,AL

ORIGIN:
    MOV DX,200H
    MOV AH,0FEH
    
WATT:
    MOV AL,AH
    OUT DX,AL
    
    CALL DELAY
    
    MOV DX,201H
    IN AL,DX
    CMP AL,02H
    JE DISP_LEFT
    CMP AL,01H
    JE DISP_RIGHT
    JMP DISP_RESET
    
DISP_LEFT:
    ROL AH,1
    MOV DX,200H
    JMP WATT
DISP_RIGHT:
    ROR AH,1
    MOV DX,200H
    JMP WATT
DISP_RESET:
    JMP ORIGIN
    
DELAY PROC NEAR
    MOV BL,10
DELAY2:
    MOV CX,10
DELAY1:
    NOP
    NOP
    LOOP DELAY1
    DEC BL
    JNZ DELAY2 
    RET
DELAY ENDP  

CODE ENDS
    END START
