DATA SEGMENT
	BUFF DB 'ABCD$EFGHIJK$'
	STR1 DB 12 DUP(?)
	LEN DB ?
DATA ENDS
CODE SEGMENT
ASSUME CS:CODE,DS:DATA
START: MOV AX,DATA
	   MOV DS,AX
	   MOV ES,AX
	   
	   ; MOV CX,12
	   ; LEA DI,STR1
	   ; CLD
	   ; MOV AL,2AH
	   ; REP STOSB
	   
	   
	   ; MOV CX,12
	   ; LEA SI,BUFF
	   ; LEA DI,STR1
	   ; ADD SI,CX
	   ; ADD DI,CX
	   ; DEC SI
	   ; DEC DI
	   ; STD
	   ; REP MOVSB
	   
	   
	   
	   ; MOV CX,12
	   ; LEA SI,BUFF
	   ; LEA DI,STR1
	   ; CLD
	   
	   ; REPE CMPSB
	   ; JZ EQUAL
	   ; MOV DX,0
	   ; MOV AH,4CH
	   ; INT 21H
; EQUAL: MOV DX,1
	   ; MOV AH,4CH
	   ; INT 21H
	   
	   
	   MOV CX,12
	   MOV BX,0
	   MOV AL,'$'
	   LEA DI,BUFF
	   CLD
LOOPY: REPNE SCASB
	   JNZ FINISH
	   INC BX
	   JMP LOOPY			;找到就回去继续找，没找到就别找了，没找到的情况不需要循环
FINISH:MOV AH,4CH
	   INT 21H


CODE ENDS
END START