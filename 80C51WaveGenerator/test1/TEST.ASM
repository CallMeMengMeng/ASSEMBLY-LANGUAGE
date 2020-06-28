;TABLE:
;	DB 080h,083h,086h,089h,08ch,090h,093h,096h,099h,09ch,09fh,0a2h,0a5h,0a8h,0abh,0aeh
;	DB 0b1h,0b3h,0b6h,0b9h,0bch,0bfh,0c1h,0c4h,0c7h,0c9h,0cch,0ceh,0d1h,0d3h,0d5h,0d8h
;	DB 0dah,0dch,0deh,0e0h,0e2h,0e4h,0e6h,0e8h,0eah,0ebh,0edh,0efh,0f0h,0f1h,0f3h,0f4h
;	DB 0f5h,0f6h,0f8h,0f9h,0fah,0fah,0fbh,0fch,0fdh,0fdh,0feh,0feh,0feh,0ffh,0ffh,0ffh
;	DB 0ffh,0ffh,0ffh,0ffh,0feh,0feh,0feh,0fdh,0fdh,0fch,0fbh,0fah,0fah,0f9h,0f8h,0f6h
;	DB 0f5h,0f4h,0f3h,0f1h,0f0h,0efh,0edh,0ebh,0eah,0e8h,0e6h,0e4h,0e2h,0e0h,0deh,0dch
;	DB 0dah,0d8h,0d5h,0d3h,0d1h,0ceh,0cch,0c9h,0c7h,0c4h,0c1h,0bfh,0bch,0b9h,0b6h,0b3h
;	DB 0b1h,0aeh,0abh,0a8h,0a5h,0a2h,09fh,09ch,099h,096h,093h,090h,08ch,089h,086h,083h
;	DB 080h,07dh,07ah,077h,074h,070h,06dh,06ah,067h,064h,061h,05eh,05bh,058h,055h,052h
;	DB 04fh,04dh,04ah,047h,044h,041h,03fh,03ch,039h,037h,034h,032h,02fh,02dh,02bh,028h
;	DB 026h,024h,022h,020h,01eh,01ch,01ah,018h,016h,015h,013h,011h,010h,00fh,00dh,00ch
;	DB 00bh,00ah,008h,007h,006h,006h,005h,004h,003h,003h,002h,002h,002h,001h,001h,000h
;	DB 000h,000h,001h,001h,002h,002h,002h,003h,003h,004h,005h,006h,006h,007h,008h,00ah
;	DB 00bh,00ch,00dh,00fh,010h,011h,013h,015h,016h,018h,01ah,01ch,01eh,020h,022h,024h
;	DB 026h,028h,02bh,02dh,02fh,032h,034h,037h,039h,03ch,03fh,041h,044h,047h,04ah,04dh
;	DB 04fh,052h,055h,058h,05bh,05eh,061h,064h,067h,06ah,06dh,070h,074h,077h,07ah,07dh
	

	ORG 0000H
	LJMP MAIN
	ORG 0003H
	LJMP INT00
	ORG 0040H
MAIN: 
	MOV SP,60H
	SETB IT0
	SETB EA
	SETB EX0
INT00:
	CLR EA
	PUSH PSW
	PUSH Acc
	SETB EA
	JNB P1.0,IR0
	JNB P1.1,IR1
	JNB P1.2,IR2
INTIR:
	CLR EA
	POP Acc
	POP PSW
	SETB EA
	RETI

IR0:
	MOV R0,#0FDH
	MOV A,#00H
UP0:
	MOVX @R0,A
	JB P1.0,INTIR
	INC A
	JNZ UP0
DOWN0:
	DEC A
	MOVX @R0,A
	JB P1.0,INTIR
	JNZ DOWN0
	SJMP UP0
	LJMP INTIR

IR1:
	MOV R0,#0FEH
UP1:
	MOV A,#00H
	MOVX @R0,A
	LCALL DELAY
	JB P1.1,INTIR
DOWN1:
	MOV A,#0FFH
	MOVX @R0,A
	LCALL DELAY
	JB P1.1,INTIR
	SJMP UP1
	LJMP INTIR

IR2:
	MOV R0,#0FEH
	MOV R1,#00H
	MOV A,#00H
	MOV DPTR,#00H

SEARCH:
	MOV A,R1
	LCALL VALUE_SEARCH
	MOVX @R0,A
	JB P1.2,INTIR
	INC R1
	SJMP SEARCH
	LJMP INTIR


VALUE_SEARCH:
	MOV DPTR,#TABLE
	MOVC A,@A+DPTR
	RET

DELAY:
	MOV R7,#25
D1:
	MOV R6,#10
D2:
	DJNZ R6,D2
	DJNZ R7,D1
	RET

TABLE:
	DB 080h,083h,086h,089h,08ch,090h,093h,096h,099h,09ch,09fh,0a2h,0a5h,0a8h,0abh,0aeh
	DB 0b1h,0b3h,0b6h,0b9h,0bch,0bfh,0c1h,0c4h,0c7h,0c9h,0cch,0ceh,0d1h,0d3h,0d5h,0d8h
	DB 0dah,0dch,0deh,0e0h,0e2h,0e4h,0e6h,0e8h,0eah,0ebh,0edh,0efh,0f0h,0f1h,0f3h,0f4h
	DB 0f5h,0f6h,0f8h,0f9h,0fah,0fah,0fbh,0fch,0fdh,0fdh,0feh,0feh,0feh,0ffh,0ffh,0ffh
	DB 0ffh,0ffh,0ffh,0ffh,0feh,0feh,0feh,0fdh,0fdh,0fch,0fbh,0fah,0fah,0f9h,0f8h,0f6h
	DB 0f5h,0f4h,0f3h,0f1h,0f0h,0efh,0edh,0ebh,0eah,0e8h,0e6h,0e4h,0e2h,0e0h,0deh,0dch
	DB 0dah,0d8h,0d5h,0d3h,0d1h,0ceh,0cch,0c9h,0c7h,0c4h,0c1h,0bfh,0bch,0b9h,0b6h,0b3h
	DB 0b1h,0aeh,0abh,0a8h,0a5h,0a2h,09fh,09ch,099h,096h,093h,090h,08ch,089h,086h,083h
	DB 080h,07dh,07ah,077h,074h,070h,06dh,06ah,067h,064h,061h,05eh,05bh,058h,055h,052h
	DB 04fh,04dh,04ah,047h,044h,041h,03fh,03ch,039h,037h,034h,032h,02fh,02dh,02bh,028h
	DB 026h,024h,022h,020h,01eh,01ch,01ah,018h,016h,015h,013h,011h,010h,00fh,00dh,00ch
	DB 00bh,00ah,008h,007h,006h,006h,005h,004h,003h,003h,002h,002h,002h,001h,001h,000h
	DB 000h,000h,001h,001h,002h,002h,002h,003h,003h,004h,005h,006h,006h,007h,008h,00ah
	DB 00bh,00ch,00dh,00fh,010h,011h,013h,015h,016h,018h,01ah,01ch,01eh,020h,022h,024h
	DB 026h,028h,02bh,02dh,02fh,032h,034h,037h,039h,03ch,03fh,041h,044h,047h,04ah,04dh
	DB 04fh,052h,055h,058h,05bh,05eh,061h,064h,067h,06ah,06dh,070h,074h,077h,07ah,07dh

	END
