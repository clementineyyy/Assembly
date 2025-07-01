DATA SEGMENT
	HINT DB 'PLEASE INPUT THE NUMBER:$'
	INPUT DB 8,?,4 DUP(?),13,10,'$'
	SPACE DB 13,10,'$'
DATA ENDS
CODE SEGMENT
ASSUME CS:CODE,DS:DATA
	MAIN PROC FAR
	   MOV AX,DATA
	   MOV DS,AX
	   
	   CALL CHAR2DATA
	   CALL OUTPUT
	   
	   MOV AH,4CH			;要有这个退出的DOS指令才能退出的干净
	   INT 21H
	   
	   RET
	   MAIN ENDP
	   
	   ;子程序：输入字符串并转换成数据
	   CHAR2DATA PROC NEAR
	   LEA DX,HINT			;调用9号功能输出DS:DX指向字符串,注意这里是LEA不是MOV
	   MOV AH,9
	   INT 21H
	   
	   LEA DX,INPUT			;调用0A号功能输入字符串到DS:DX,看到这里不需要+2，直接使用变量名就好，因为DOS功能自动把前面两个位置留给字符串长度信息
	   MOV AH,0AH
	   INT 21H
	   
	   LEA DX,SPACE
	   MOV AH,9H
	   INT 21H
	   
	   LEA SI,INPUT+2
	   MOV CL,4
	   
	   MOV DX,0
	   MOV BX,16			;因为是转成十六进制所以乘16不乘10
	   MOV AX,0
LOOP1: MUL BX				;只要乘3次而不是4次因为最后的个位不用乘
	   MOV DL,DS:[SI]		;把当前EI指向的字符ASCII码给DL，因为字符串是字节类型所以用DL不用DX
	   INC SI				;SI要手动增加不然不会自己增加，这不是字符串循环操作指令
	   SUB DL,30H			;减去十六进制的30,就是十进制的48，得到数字
	   CMP DL,9
	   JNA CONVERT			;小于10是数字就转移
	   SUB DL,7				;再减十进制7
	   CMP DL,15
	   JA EXIT 				;大于就退出
CONVERT:ADD AX,DX			;数据保存在AX中
	    LOOP LOOP1
EXIT:  RET
	   CHAR2DATA ENDP
	   
	   ;子程序：把数据变成十进制并输出
	   OUTPUT PROC NEAR
	   MOV BX,10
	   MOV CX,5
	   
LOOP2: MOV DX,0				;这里DX要先初始化为0，不然DX里面的数据会干扰DIV指令导致死循环
	   DIV BX				;字除法商保存在AX，余数保存在DX
	   PUSH DX				;余数压栈稍后输出
	   LOOP LOOP2
	   MOV CX,5				;记得CX重新赋值
LOOP3: POP DX				;余数出栈开始输出
	   ADD DX,30H
	   MOV AH,2				;DOS2号功能，输出DL中的字符
	   INT 21H
	   LOOP LOOP3
	   RET
	   OUTPUT ENDP

CODE ENDS
END MAIN