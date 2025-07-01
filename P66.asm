DATA SEGMENT
	MESS DB 'COMPUTER SOFTWARE $'
DATA ENDS
EXT SEGMENT 							;附加段
	BUFF DB 19,?,19 DUP(?)
EXT ENDS
CODE SEGMENT
ASSUME CS:CODE,DS:DATA,ES:EXT
START: MOV AX,DATA
	   MOV DS,AX
	   LEA SI,MESS						;源串DS:[SI],目的串ES:[DI]
	   
	   MOV AX,EXT
	   MOV ES,AX
	   LEA DI,BUFF
	   
	   MOV CX,19
	   CLD
	   
	   REP MOVSB						;注意选择MOVSB/MOVSW
	   MOV DS,AX
	   LEA DX,BUFF
	   MOV AH,09H						;注意9号指令才是输出字符串指令，地址为DS:[DX]需要赋值
	   INT 21H
	   
	   MOV AH,4CH						;如果没有这句，程序会直接退出，没有输出
	   INT 21H
CODE ENDS
END START