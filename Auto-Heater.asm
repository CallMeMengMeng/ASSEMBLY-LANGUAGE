; Use 'LED_Display.exe' and 'Thermometer.exe' in EMU8086 to 
; design a simple auto-heater to boil water. Stop heating 
; water when the temperature is above 100¡æ, while below 95¡æ 
; reboot the heater.

; + LED_Display: 
;   - port 199    
; + Thermometer: 
;   - Data port 125
;   - Control port 127

DATA SEGMENT
    TEM DB 0
DATA ENDS

STACK SEGMENT PARA STACK 'STACK'
    DB 10 DUP(0)
STACK ENDS

CODE SEGMENT
    ASSUME CS:CODE,DS:DATA
START:
    MOV AX,DATA
    MOV DS,AX   
    
HEATER_ON:
    IN AX,125       ; Read from the Data port 125
    OUT 199,AX      ; Write in the port 199 to display present temporature on LED
    
    CMP AX,100      ; Compare with 100¡æ
    JG HEATER_OFF   ; If larger, swith off the heater
    MOV AX,1        ; Otherwise, swith on it. (1->on, 0->off)
    OUT 127,AX
    JMP HEATER_ON
    
HEATER_OFF:
    MOV AX,0
    OUT 127,AX
    
    IN AX,125       ; Display present temporature
    OUT 199,AX
    CMP AX,95       ; Compare with 95¡æ
    JL HEATER_ON    ; If less, switch on the heater
    JMP HEATER_OFF  ; Otherwise, keep off.
    
QUIT:
    MOV AH,4CH
    INT 21H
CODE ENDS
    END START