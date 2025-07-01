DATA SEGMENT
	INPUT DB 'PLEASE INPUT THE NUMBER:$'
	NUMBER DB 5,?,4 DUP(?),13,10,'$'
	SPACE DB 13,10,'$'
DATA ENDS
CODE SEGMENT
ASSUME CS:CODE,DS:DATA
START: MOV AX,DATA
	   MOV DS,AX
	   LEA DX,INPUT
	   MOV AH,09			;调用9号功能输出DS:DX指向字符串
	   INT 21H
	   
	   LEA DX,NUMBER
	   MOV AH,0AH			;调用0A号功能输入字符串到DS:DX,看到这里不需要+2，直接使用变量名就好，因为DOS功能自动把前面两个位置留给字符串长度信息
	   INT 21H
	   
	   LEA DX,SPACE
	   MOV AH,09H
	   INT 21H
	   
	   LEA SI,NUMBER+2
	   MOV CL,4
	   CLD
	   MOV AX,0
	   MOV BX,16
LOOP1: IMUL BX
	   MOV DL,DS:[SI]		;字符是字节类型所以要存到DL而不是DX
	   SBB DL,48			;减去十六进制的30,就是十进制的48
	   CMP DL,10
	   JL NUM				;小于10是数字就转移
	   SUB DL,7				;再减十进制7
NUM:   ADD AL,DL
	   INC SI
	   LOOP LOOP1
	   MOV BX,AX
	   
	   MOV CX,16
	   MOV DH,4
SHIFT: ROL BX,1				;循环左移，移出位数放入CF
	   MOV AL,'0'
	   ADC AL,0				;和CF相加
	   MOV DL,AL			;2号功能输出DL寄存器中的字符
	   MOV AH,02
	   INT 21H
	   DEC DH
	   JNZ NO
	   
	   MOV DL,' '
	   MOV AH,02
	   INT 21H
	   MOV DH,4
NO:	   LOOP SHIFT
	   MOV AH,4CH
	   INT 21H
CODE ENDS
END START