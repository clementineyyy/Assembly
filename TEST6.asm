DATA SEGMENT
	ARRAY DB 10,?,7 DUP(?)		;注意一开始预留的内存要大一点，因为输入的时候考虑到输入enter键
DATA ENDS
CODE SEGMENT
ASSUME CS:CODE,DS:DATA
START: MOV AX,DATA
	   MOV DS,AX
	   
	   LEA DX,ARRAY
	   MOV AH,0AH
	   INT 21H
	   
	   MOV SI,OFFSET ARRAY+2
	   MOV CL,7
	   MOV AL,0
	   MOV DL,2
	   
L1:	   MUL DL
	   MOV BL,DS:[SI]
	   SUB BL,'0'
	   ADD AL,BL
	   INC SI
	   LOOP L1
	   
	   MOV DL,AL
	   MOV AH,02H
	   INT 21H
	   
	   MOV AH,4CH
	   INT 21H
CODE ENDS
END START