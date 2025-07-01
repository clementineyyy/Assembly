DATA SEGMENT
	MESS DB 'COMPUTER SOFTWARE $'
DATA ENDS
CODE SEGMENT
ASSUME CS:CODE,DS:DATA
START: MOV AX,DATA
	   MOV DS,AX					;目的串在ES:[DI]
	   MOV ES,AX
	   LEA DI,MESS
	   MOV AL,20H					;空格的ASCII码是32，变成16进制是20
	   MOV CX,19
	   CLD
	   REPNE SCASB
	   JZ FIND
	   MOV AH,02H					;DOS2号指令，输出单个字符
	   MOV DL,'N'
	   INT 21H
	   JMP FINISH
FIND: DEC DI						;注意，DI在循环找到时已经后移了一位，所以需要移回来！！！
	  MOV BYTE PTR ES:[DI],23H				;#的ASCII码是35，变成16进制是23
	  MOV AH,02H					;DOS2号指令，输出单个字符
	  MOV DL,'Y'
	  INT 21H
FINISH:MOV AH,4CH
	   INT 21H
CODE ENDS
END START