EXT SEGMENT
	MESS DB '12345678$'
EXT ENDS
CODE SEGMENT
ASSUME CS:CODE,ES:EXT
START: MOV AX,EXT
	   MOV ES,AX
	   MOV AL,0
	   LEA DI,MESS
	   CLD
	   MOV CX,9
	   
	   REP STOSB
	   MOV AH,4CH
	   INT 21H
	   
CODE ENDS
END START