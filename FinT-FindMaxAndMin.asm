; There are 10 8-bit unsigned numbers stored in DATA, now try to compare them 
; and find the max number and the min number, then store them in MAX and MIN,
; respectively.

DATAS SEGMENT
    DATA DB 98,50,23,1,56,76,100,99,98,0
    LEN DB $-DATA
    MAX DB 0
    MIN DB 0
DATAS ENDS

CODE SEGMENT
    ASSUME CS:CODE,DS:DATAS
START:
    MOV AX,DATAS
    MOV DS,AX
    
; Initial program: set DATA[0] as the max number
    LEA SI,DATA
    MOV AL,[SI]
    MOV MAX,AL
    MOV CX,LEN-1	; Compare MAX that equals to DATA[0] and DATA[SI+1], which means comparisions' times is one less than the length of DATA
    INC SI
FIND_MAX:			; Find the max number
    MOV AL,[SI]
    CMP MAX,AL
    JGE NEXT
    MOV MAX,AL
NEXT:
    INC SI
    LOOP FIND_MAX
    
; Initial program: set DATA[0] as the min number
    LEA SI,DATA
    MOV AL,[SI]
    MOV MIN,AL
    MOV CX,LEN-1
    INC SI
FIND_MIN:			; Find the min number
    MOV AL,[SI]
    CMP MIN,AL
    JLE GOON
    MOV MIN,AL
GOON:
    INC SI
    LOOP FIND_MIN
    HLT
CODE ENDS
    END START
    
