; 数据段定义
DATA SEGMENT
    ARRAY DW 1,2,3,4,5,6  ; 定义6个字
DATA ENDS

; 代码段
CODE SEGMENT
    ASSUME CS:CODE, DS:DATA
	
START:
	MOV AX, DATA       ; 加载数据段地址到AX
    MOV DS, AX          ; 设置DS寄存器指向数据段

    ; (1) 直接寻址
    MOV AX, [ARRAY+8]  ; 直接通过偏移地址访问第5个字
	MOV AX, 0           ; 清零AX，为下一次操作准备

    ; (2) 使用BX的间接寻址
    LEA BX, ARRAY+8    ; 将第5个字的地址加载到BX
    MOV AX, [BX]       ; 通过BX间接寻址获取值
	MOV AX, 0           ; 清零AX，为下一次操作准备

    ; (3) 使用BX的寄存器相对寻址
    LEA BX, ARRAY      ; 加载数组基地址到BX
    MOV AX, [BX+8]     ; 基地址加偏移量8访问第5个字
	MOV AX, 0           ; 清零AX，为下一次操作准备

    ; (4) 基址变址寻址
    LEA BX, ARRAY      ; 加载数组基地址到BX
    MOV SI, 8          ; 将偏移量8存入SI
    MOV AX, [BX+SI]    ; 通过BX+SI的组合寻址获取第5个字
	
	; 退出程序
    MOV AH, 4CH
    INT 21H
CODE ENDS
END START