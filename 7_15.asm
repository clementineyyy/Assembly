DATA SEGMENT
	ARRAY DW 5,1,1,0,1,1
DATA ENDS
CODE SEGMENT
ASSUME CS:CODE,DS:DATA
MAIN PROC FAR
MOV AX,DATA
MOV DS,AX
LEA SI,ARRAY+2		;要指向第一个元素而不是指向前一个元素,而且因为是字单元所以+2不是+1
MOV CX,ARRAY		;正确的得到字符串首元素内容的操作
LOOP2:ADD SI,2		;因为是字数组所以指针要加两次才可以指向下一个完整的元素
LOOP LOOP2
CALL FIND
CMP DI,SI
JZ DO				;如果字符串指针指向字符串后的一个位置说明没找到，退出程序
CALL REMOVE
JMP EXIT

DO:SUB DI,2
CMP ARRAY[DI],0
JNZ EXIT
DEC ARRAY[0]

EXIT:
MOV AH,4CH
INT 21H
RET
MAIN ENDP

FIND PROC NEAR
MOV ES,AX			;串扫描操作用ES:DI,而且ES和DS之间不可以直接传递
LEA DI,ARRAY+2		;用LEA不用MOV,要指向第一个元素而不是指向前一个元素,而且因为是字单元所以+2不是+1
CLD
MOV AX,0			;字操作，查找的数给AX
MOV CX,ARRAY
REPNE SCASW			;每次结束的时候DI总是指向下一个元素

RET 
FIND ENDP

REMOVE PROC NEAR
MOV SI,DI
SUB DI,2
LOOP1:MOV BX,ARRAY[SI]
MOV ARRAY[DI],BX
ADD DI,2			;因为是字数组所以指针要加两次才可以指向下一个完整的元素
ADD SI,2			;因为是字数组所以指针要加两次才可以指向下一个完整的元素
LOOP LOOP1
DEC ARRAY[0]
RET 
REMOVE ENDP


CODE ENDS
END MAIN
 