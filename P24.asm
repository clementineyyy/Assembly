DATA SEGMENT
	STRING DB 'I LOVE CHINA!$'
DATA ENDS

CODE SEGMENT
	ASSUME CS:CODE,DS:DATA

START:
	MOV AX,DATA
	MOV DS,AX
	
	MOV DX,OFFSET STRING
	MOV AH,9
	INT 21H
	
CODE ENDS
END START