DATA SEGMENT
	INPUT1 DB 13,10,'INPUT X = $'
	INPUT2 DB 13,10,'INPUT Y = $'
	INPUT3 DB 13,10,'INPUT Z = $'
	OUTPUT DB 13,10,'W = (X + Y) * Z = $'
	STRINGX DB 8,?,8 DUP(?),13,10,'$'
	STRINGY DB 8,?,8 DUP(?),13,10,'$'
	STRINGZ DB 8,?,8 DUP(?),13,10,'$'
DATA ENDS
CODE SEGMENT
ASSUME CS:CODE,DS:DATA
START: MOV AX,DATA
	   MOV DS,AX
	   MOV ES,AX
	   
	   LEA DX,INPUT1
	   MOV AH,09H
	   INT 21H
	   
	   LEA DX,STRINGX		;保存输入的数字字符串
	   MOV AH,0AH
	   INT 21H
	   
	   LEA DI,STRINGX+2		;注意这里赋的是偏移地址所以要用LEA
	   MOV CL,STRINGX+1		;这里用CL是因为字符串是DB，字节型
	   MOV CH,0
	   CLD
	   
	   MOV AX,0
	   MOV BX,10
LOOP1: IMUL BX
	   MOV DL,ES:[DI]
	   SBB DL,30H
	   ADC AL,DL
	   INC DI
	   LOOP LOOP1			;AX保存X
	   PUSH AX				;寄存器不够用了，先放堆栈
	   
	   
	   LEA DX,INPUT2
	   MOV AH,09H
	   INT 21H
	   
	   LEA DX,STRINGY		;保存输入的数字字符串
	   MOV AH,0AH
	   INT 21H
	   
	   LEA DI,STRINGY+2		;注意这里赋的是偏移地址所以要用LEA
	   MOV CL,STRINGY+1
	   MOV CH,0
	   CLD
	   
	   MOV AX,0
	   MOV BX,10
LOOP2: IMUL BX
	   MOV DL,ES:[DI]
	   SBB DL,30H
	   ADC AL,DL
	   INC DI
	   LOOP LOOP2			;AX保存Y
	   
	   POP BX
	   ADC BX,AX			;BX保存X+Y
	   PUSH BX				;寄存器不够用了，先放堆栈
	   
	   
	   LEA DX,INPUT3
	   MOV AH,09H
	   INT 21H
	   
	   LEA DX,STRINGZ		;保存输入的数字字符串
	   MOV AH,0AH
	   INT 21H
	   
	   LEA DI,STRINGZ+2		;注意这里赋的是偏移地址所以要用LEA
	   MOV CL,STRINGZ+1
	   MOV CH,0
	   CLD
	   
	   MOV AX,0
	   MOV BX,10
LOOP3: IMUL BX
	   MOV DL,ES:[DI]
	   SBB DL,30H
	   ADC AL,DL
	   INC DI
	   LOOP LOOP3			;AX保存Z
	   
	   POP BX				;从堆栈中拿回结果
	   IMUL BX				;AX保存结果
	   PUSH AX
	   
	   LEA DX,OUTPUT
	   MOV AH,09H
	   INT 21H
	   

	   MOV CX,8
	   CLD
	   MOV BX,10
	   POP AX
LOOP4: MOV DX,0
	   DIV BX				;AX放商，DX放余数
	   PUSH DX
	   CMP AX,1				;如果十位数没有更高一位
	   JC FINISH			;如果AX<1就退出循环
	   LOOP LOOP4
	   
	   
FINISH:SBB CX,8
	   NEG CX
LOOP5: POP DX
	   ADD DX,30H
	   MOV DH,0
	   MOV AH,2
	   INT 21H
	   LOOP LOOP5
	   
	   MOV AH,4CH
	   INT 21H
CODE ENDS
END START