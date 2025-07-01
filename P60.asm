DATA SEGMENT
X DW 0004H
Y DW 0002H
Z DW 0014H
V DW 0018H
DATA ENDS
CODE SEGMENT 
ASSUME CS:CODE,DS:DATA
START: MOV AX,DATA
	   MOV DS,AX		;这样数据就在DS寄存器里面放好了，可以使用d指令查看内存中的内容
	   MOV AX, X		;从数据段的X单元读出数据送入寄存器
	   IMUL Y			;从数据段的Y单元读出数据送入寄存器,SRC不能是立即数，因为立即数的长度是不明确的
	   ;结果保存在AX中
	   ADC AX,Z
	   SBB AX,16		;带借位的减法是SBB
	   MOV BX,V
	   SBB BX,AX
	   MOV AX,BX
	   MOV DX,0			;进行字的除法，初始化DX=0保险
	   IDIV X
CODE ENDS
END START