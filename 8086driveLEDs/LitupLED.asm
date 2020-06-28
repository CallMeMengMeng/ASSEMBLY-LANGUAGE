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
	      
    MOV DX,01110B      ; 8255初始化
    MOV AL,80H      ; A口输出，方式0,B OUT,MODE 0
    OUT DX,AX
          
    MOV BL,80H      ; LED0灯亮(高电平灯亮)  
    MOV AL,BL
    MOV DX,01000B
    OUT DX,AL       ;PA7灯亮       
                
    MOV AL,13H      ; 00010011B，ICW1：边沿触发，单片，要ICW4
    MOV DX,10000B   ; 8259地址
    OUT DX,AL
    MOV AL,40H      ; ICW2中断类型号为40H
    MOV DX,10010B
    OUT DX,AL
    MOV AL,01H      ; ICW4不用缓冲方式，正常中断结束，非特殊的全嵌套方式
    OUT DX,AL
             
    MOV AX,0 
    MOV DS,AX       ; 数据段清零        
          
    LEA AX,INT0     ; 写8259中断程序的入口地址
    MOV DS:[4*40H],AX   ; 把中断服务程序的入口地址偏移量送中断向量表
    MOV AX,CS
    MOV DS:[4*40H+2],AX ; 把中断服务程序的入口地址段地址送中断向量表    

    STI                 ; 开中断
; AGAIN :
;   HLT 
;   JMP  AGAIN      ; 等待
AGAIN:
    MOV DX,8000H
    MOV AL,40H
    OUT DX,AL
    JMP AGAIN
                
                
INT0 PROC NEAR      ; 8259中断服务程序   
    ROR BL,1        ; 右循环1次
    MOV AL,BL
    MOV DX,01000B   
    OUT DX,AL       ; PA口灯亮       
          
    MOV DX,10000B 
    MOV AL,20H      ; OCW2发结束命令EOI=1
    OUT DX,AL
          
    IRET
INT0 ENDP   
CODE ENDS
    END START