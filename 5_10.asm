CODE SEGMENT
ASSUME CS:CODE
START: MOV AX,2
	   MOV BX,AX			;BX保存原数据
	   MOV CX,2
	   SHL AX,2				;逻辑左移2次相当于乘4
	   ADD AX,BX			;再加一次就是乘了5次
	   
	   MOV AH,4CH
	   INT 21H

CODE ENDS
END START