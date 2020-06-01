; Encrypt the 5 letter content entered from the keyboard using the Caesar encryption algorithm.     
; Print the encrypted content on the screen.(16 bit EMU8086)  

; + Keyboard input;
; + Transfer of the entered content to an array in the data segment;
; + Writing the encrypted content to a separate array in the data segment;
; + Printing encrypted content on the screen.        

; The step of Caesar encryption I chose and stored in 'STEP' is 2, which means A->C, Z->B, a->c, z->b...
; Encrypt letters merely, and keep other characters unchanged.   

; Example: Z;Azy -> B;cba

DATA SEGMENT
    MESS1 DB 0DH,0AH,'PLEASE INPUT 5 LETTERS FROM YOUR KEYBOARD: $'  ; Hint of input
    MESS2 DB 0DH,0AH,'THE ENCRYPTED RESULT IS: $'                    ; Hint of output
    BUFF1 DB 5 DUP(0)                                                ; Define an array to store these 5 letters you input
    ENCRY DB 10 DUP('$')                                             ; Define another array filled with '$' so as to not only store encrypted content but also output easily
    STEP EQU 2                                                       ; Define the step of Caesar encryption
DATA ENDS

STACK SEGMENT PARA STACK 'stack'
    DB 50 DUP(0)
STACK ENDS

CODE SEGMENT
    ASSUME CS:CODE,DS:DATA
START:
    MOV AX,DATA
    MOV DS,AX
                                                                     ; Get the address of BUFF1
    LEA SI,BUFF1                                                     ; Get the address of ENCRY
    LEA DI,ENCRY                                                    
    MOV CX,5
                                                                     ; Output MESS1
    MOV AH,09H
    MOV DX,OFFSET MESS1
    INT 21H
                                                                     ; Letter input
INPUT:
    MOV AH,01H
    INT 21H                                                          ; Move letter from AL to BUFF1
    MOV [SI],AL
    INC SI
    LOOP INPUT
    
    LEA SI,BUFF1
    MOV CX,5
    
ENCRYPT:
    MOV DL,[SI]                                                      ; Compare BUFF[SI] with 'A'
    CMP DL,41H
    JL NEXT                                                          ; If it's less, jump to NEXT
    CMP DL,5AH                                                       ; Compare BUFF[SI] with 'Z'
    JLE UPPERCASE                                                    ; If it's less or equal, jump to UPPERCASE
    CMP DL,61H                                                       ; Compare BUFF[SI] with 'a'
    JL NEXT
    CMP DL,7AH                                                       ; Compare BUFF[SI] with 'z'
    JLE LOWERCASE                                                    ; Less or equal, jump to lowercase
    JMP NEXT                                                         
    
UPPERCASE:                                                           ; Caeser encryption of uppercase letter
    ADD DL,STEP                                                      ; Check if the encrypted result is beyond 'Z'
    CMP DL,5AH                                                       ; SUB 26 to make Z->B
    JA SUB_26
    JMP NEXT
    
LOWERCASE:                                                           ; Caeser encryption of lowercase letter
    ADD DL,STEP                                                      ; Check if the encrypted result is beyond 'z'
    CMP DL,7AH                                                       ; SUB 26 to make z->b
    JA SUB_26
    JMP NEXT
    
SUB_26:
    SUB DL,1AH
                                                                     ; Store encrypted result in ENCRY
NEXT:
    MOV [DI],DL
    INC DI
    INC SI
    DEC CX
    JNZ ENCRYPT
                                                                     ; Output MESS2
OUTPUT:
    MOV AH,09H
    MOV DX,OFFSET MESS2
    INT 21H                                                          ; Output encrypted content
    
    MOV DX,OFFSET ENCRY
    INT 21H
    
EXIT:
    MOV AH,4CH
    INT 21H
    
CODE ENDS
    END START
