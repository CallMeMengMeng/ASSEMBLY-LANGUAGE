; HERE IS MY CODE FOR USING SHL AND ADD COMMANDS TO ACHIEVE 
; 02H*26. (AND THE RESULT IS STORED IN BL)

CODE    SEGMENT
    ASSUME  CS:CODE
    START:  MOV AL,02H
            MOV BL,AL
            MOV CL,AL
            SHL CL,1    ; 02H*2
            SHL BL,3    ; 02H*8
            ADD BL,CL   ; 02H*(2+8)
            SHL AL,4    ; 02H*16
            ADD BL,AL   ; 02H*(2+8+16)=02H*26
            
            MOV AH,4CH
            INT 21H
CODE    ENDS
    END START