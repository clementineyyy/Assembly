DATA SEGMENT
	BUFFER1 DB 15,?,15 DUP(?),13,10,'$'
	BUFFER2 DB 15,?,15 DUP(?),13,10,'$'
	INPUTS1 DB 13,10,'INPUT STRING1:$'
	INPUTS2 DB 13,10,'INPUT STRING2:$'
	GETC DB 13,10,'INPUT CHAR:$'
	NEWLINE DB 13,10,'$'            ; 换行符
DATA ENDS

CODE SEGMENT
	ASSUME CS:CODE,DS:DATA,ES:DATA
START:
	MOV AX,DATA
	MOV DS,AX
	MOV ES,AX					;ES也指向DATA段
	
	MOV DX,OFFSET INPUTS1		;指向缓冲区，直接寻址方式
	MOV AH,9					;DOS9号功能，显示DS:DX的字符串
	INT 21H
	
	LEA DX,BUFFER1				;DOS0A号功能，键盘输入到缓冲区
	MOV AH,0AH
	INT 21H
	
	
	MOV DX,OFFSET INPUTS2		;指向缓冲区，直接寻址方式
	MOV AH,9					;DOS9号功能，显示DS:DX的字符串
	INT 21H
	
	LEA DX,BUFFER2				;DOS0A号功能，键盘输入到缓冲区
	MOV AH,0AH
	INT 21H
	
    MOV DX, OFFSET NEWLINE		; 换行
    MOV AH, 09H
    INT 21H
	
	
	LEA SI,BUFFER1+2			;目的串地址为ES[DI]----BUFFER2,源串地址为DS:[SI]----BUFFER1
	LEA DI,BUFFER2+2			;缓冲区第一个字节是缓冲区大小，第二个字节是实际输入的字节数，第三个字节开始存放输入内容
	
	MOV CL, BUFFER1 + 1         ; 获取实际输入长度
    MOV CH, 0
	CLD
	
LOOPY:
	CMPSB
	JE SKIP			                ; 相同则跳过
	; 不同，显示第二个字符串的该字符
    MOV DL, ES:[DI-1]                ; DI已递增，需-1
    MOV AH, 2H
    INT 21H
SKIP:
	LOOP LOOPY
	
	
	MOV AH,9					;DOS9号功能，显示DS:DX的字符串
	MOV DX,OFFSET GETC			;指向缓冲区，直接寻址方式
	INT 21H
	
	MOV AH,1					;DOS1号功能，键盘输入单个字符并回显，值送入AL寄存器
	INT 21H
	
	MOV DX, OFFSET NEWLINE		; 换行
    MOV AH, 09H
    INT 21H
	
	;再初始化一次
	LEA DI,BUFFER1+2			;缓冲区第一个字节是缓冲区大小，第二个字节是实际输入的字节数，第三个字节开始存放输入内容
	MOV CL, BUFFER1 + 1         ; 获取实际输入长度
    MOV CH, 0
	CLD
	MOV BL,0
	
LOOP2:
	SCASB						;SCASB隐式使用ES:[DI]
	JNZ JUMP					;找到不相同字符
	INC BL
JUMP:
	LOOP LOOP2
	
	ADC BL,30H
	MOV DL,BL
	MOV AH,2
	INT 21H
	
	MOV AH,4CH
	INT 21H
	
CODE ENDS
END START
	
	
	
	