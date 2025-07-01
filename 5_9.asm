DATA SEGMENT
	;自认为数字都是十六进制
	;低对低，高对高，内存中从低到高，所以低先加
	X DW 1,2		;因为是DW，所以一个?是一个字，16位
	Y DW 3,4
	Z DW ?,?,?,?
DATA ENDS
CODE SEGMENT
ASSUME CS:CODE,DS:DATA
START: MOV AX,DATA
	   MOV DS,AX
	   
	   ; MOV BX,X
	   ; MOV CX,Y
	   ; ADD BX,CX
	   ; MOV Z,BX
	   ; MOV AX,X+2				;因为是字，所以到低16位是+2不是+1
	   ; MOV DX,Y+2
	   ; ADC AX,DX
	   ; MOV Z+4,AX				;正确的，双操作指令两边不能都是内存单元但是一边可以是内存单元
	   
	   ; MOV BX,X
	   ; MOV CX,Y
	   ; SUB BX,CX
	   ; JNC MOVE1
	   ; NEG BX
; MOVE1:  MOV Z,BX
	   ; MOV AX,X+2
	   ; MOV DX,Y+2
	   ; SBB AX,DX
	   ; JNC MOVE2
	   ; NEG AX
; MOVE2:  MOV Z+4,AX			;小心标号不要定义一样的名字

	   MOV AX,X
	   MOV CX,Y
	   MUL CX
	   MOV Z,AX					;低对低，高对高
	   MOV Z+2,DX
	   
	   MOV AX,X
	   MOV CX,Y+2
	   MUL CX
	   ADD Z+2,AX
	   ADC DX,0					;有进位
	   MOV Z+4,DX
	   
	   MOV AX,X+2
	   MOV CX,Y
	   MUL CX
	   ADD Z+2,AX				;注意Z的位数
	   ADC DX,0					;有进位
	   MOV Z+4,DX				;注意Z的位数
	   
	   MOV AX,X+2
	   MOV CX,Y+2
	   MUL CX
	   ADD Z+4,AX
	   ADC DX,0					;有进位
	   MOV Z+6,DX	
	   
	   
	   MOV AH,4CH
	   INT 21H
CODE ENDS
END START