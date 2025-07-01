; 代码段
CODE SEGMENT
    ASSUME CS:CODE
	
START:
	; (1)立即寻址
	;段寄存器不接受立即数
	MOV BP, 2006H
	MOV SI, 6A00H
	MOV AX, 1200H
	
	;(2)直接寻址
	;段寄存器之间不能直接传送
	MOV DS, AX			;寄存器寻址
	MOV AX, DS:[4524H]
	
	;(3)使用BX的寄存器寻址
	MOV BX, 463DH
	MOV AX, BX
	
	;(4)使用BX的寄存器间接寻址
	MOV AX, [BX]
	
	;(5)使用BP的寄存器相对寻址,含有偏移量
	MOV AX, [BP+4524H]
	
	;(6)基址变址寻址
	MOV AX, [BX+SI]
	MOV AX, [BP+SI]
	
	;(7)相对基址变址寻址，含有偏移量
	MOV AX, [BX+SI+4524H]
	MOV AX, [BP+SI+4524H]
CODE ENDS
END START