DATA SEGMENT
	BUFF DB 10,?,10 DUP(?)
	OUTPUT DB 13,10,'NOT FOUND$'
DATA ENDS
CODE SEGMENT
ASSUME CS:CODE,DS:DATA
START: MOV AX,DATA
	   MOV DS,AX
	   MOV ES,AX
	   MOV DX,OFFSET BUFF
	   
	   MOV AH,0AH
	   INT 21H
	   
	   MOV AH,01H
	   INT 21H
	   
	   LEA DI,BUFF+2
	   CLD
	   MOV CL,DS:[BUFF+1]			;BUFF是字节存储所以给CX不是CL
	   
	   REPNE SCASB
	   JNZ NO
	   LEA DX,BUFF+2				;取地址给DX
	   SUB DI,DX
	   MOV DX,DI
	   MOV DH,0
	   ADD DL,'0'
	   MOV AH,02H
	   INT 21H
	   MOV AH,4CH					;此处终止程序不然继续执行下面另一种情况的输出
	   INT 21H
NO:    MOV DX,OFFSET OUTPUT
	   MOV AH,09H
	   INT 21H
CODE ENDS
END START