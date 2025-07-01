DATA SEGMENT
	STATUS DB 3
DATA ENDS
CODE SEGMENT
ASSUME CS:CODE,DS:DATA
START: MOV AX,DATA
	   MOV DS,AX
	   
	   MOV AL,STATUS		;变量类型是字节，所以寄存器不能是AX
	   MOV AH,0
	   MOV BX,1
	   MOV CX,5
	   MOV DX,0
	   
P1:    TEST AX,BX			;这里用TEST而不是AND防止修改寄存器的值
	   JZ P2
	   INC DX
P2:	   SHL BX,1				;记得移位
	   LOOP P1

	   CMP DX,3
	   JZ L1
	   CMP DX,2
	   JZ L2
	   CMP DX,1
	   JZ L3
	   CMP DX,0
	   JZ L4
	   
L1:
 MOV AH,4CH
	   INT 21H
L2:
 MOV AH,4CH
	   INT 21H
L3:MOV AH,4CH
	   INT 21H
L4:MOV AH,4CH
	   INT 21H
	  


CODE ENDS
END START