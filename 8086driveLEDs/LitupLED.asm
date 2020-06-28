DATA SEGMENT 
DATA ENDS

STACK SEGMENT STACK
    ST DB 10 DUP(0)
STACK ENDS

CODE SEGMENT
    ASSUME CS:CODE,DS:DATA,SS:STACK
START: 
    MOV AX,DATA
    MOV DS,AX
    MOV DX,100110B    ;8253 INIT
	MOV AL,00010110B  ;COUNTER0,MODE3,BINARY-DIGITS
	OUT DX,AL
	      
	MOV DX,100000B    ; COUNTER0
	MOV AL,64H      ; 100
	OUT DX,AL
	      
	MOV DX,100110B    ;8253 INIT
	MOV AL,01010110B  ;COUNTER1,MODE3,BINARY-DIGITS
	OUT DX,AL
	      
	MOV DX,100010B    ; COUNTER1
	MOV AL,64H      ; 100
	OUT DX,AL      
	      
    MOV DX,01110B      ; 8255��ʼ��
    MOV AL,80H      ; A���������ʽ0,B OUT,MODE 0
    OUT DX,AX
          
    MOV BL,80H      ; LED0����(�ߵ�ƽ����)  
    MOV AL,BL
    MOV DX,01000B
    OUT DX,AL       ;PA7����       
                
    MOV AL,13H      ; 00010011B��ICW1�����ش�������Ƭ��ҪICW4
    MOV DX,10000B   ; 8259��ַ
    OUT DX,AL
    MOV AL,40H      ; ICW2�ж����ͺ�Ϊ40H
    MOV DX,10010B
    OUT DX,AL
    MOV AL,01H      ; ICW4���û��巽ʽ�������жϽ������������ȫǶ�׷�ʽ
    OUT DX,AL
             
    MOV AX,0 
    MOV DS,AX       ; ���ݶ�����        
          
    LEA AX,INT0     ; д8259�жϳ������ڵ�ַ
    MOV DS:[4*40H],AX   ; ���жϷ���������ڵ�ַƫ�������ж�������
    MOV AX,CS
    MOV DS:[4*40H+2],AX ; ���жϷ���������ڵ�ַ�ε�ַ���ж�������    

    STI                 ; ���ж�
; AGAIN :
;   HLT 
;   JMP  AGAIN      ; �ȴ�
AGAIN:
    MOV DX,8000H
    MOV AL,40H
    OUT DX,AL
    JMP AGAIN
                
                
INT0 PROC NEAR      ; 8259�жϷ������   
    ROR BL,1        ; ��ѭ��1��
    MOV AL,BL
    MOV DX,01000B   
    OUT DX,AL       ; PA�ڵ���       
          
    MOV DX,10000B 
    MOV AL,20H      ; OCW2����������EOI=1
    OUT DX,AL
          
    IRET
INT0 ENDP   
CODE ENDS
    END START