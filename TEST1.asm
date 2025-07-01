DATA SEGMENT
	ARRAY DW 1,3,5,7,9,11,13,15,17,19
DATA ENDS
CODE SEGMENT
ASSUME CS:CODE,DS:DATA
START:
	MOV AX,DATA
	MOV DS,AX
	
	LEA SI,ARRAY
	MOV CX,10			;循环次数不需要减1，因为第一次比较只有第一个数参与
	MOV BL,2			;除2判断偶数，存放在BL而不是BX，否则除法不一样
	MOV DX,0			;暂时存放最大偶数
L1: MOV AX,DS:[SI]
	DIV BL				;除BL不涉及DX，除BX涉及DX
	CMP AH,1			;余数和1比较
	JZ L2				;余数=1是奇数
	CMP DX,DS:[SI]		
	JG L2				;当前最大偶数和当前数比较，如果当前最大偶数>当前数，继续下一次比较
	MOV DX,DS:[SI]
L2: ADD SI,2			;字型数据所以每次+2不能+1
	LOOP L1
	MOV AX,DX

CODE ENDS
END START