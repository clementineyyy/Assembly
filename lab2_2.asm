; 数据段定义
DATA SEGMENT
    ARRAY DW 2,1,3,4,7,6
DATA ENDS

; 代码段
CODE SEGMENT
    ASSUME CS:CODE, DS:DATA
	
START:
	MOV AX, DATA        ; 加载数据段地址到AX
    MOV DS, AX          ; 设置DS寄存器指向数据段

    ; (1) 直接寻址a[0]=2
    MOV AX, [ARRAY]     ; 直接通过偏移地址访问第1个字

    ; (2) 使用BX的间接寻址a[1]=1
    LEA BX, ARRAY+2     ; 将第2个字的地址加载到BX
    SUB AX, [BX]        ; 通过BX间接寻址获取值

    ; (3) 使用BX的寄存器相对寻址a[2]=3
    LEA BX, ARRAY       ; 加载数组基地址到BX
    MOV DX, [BX+4]      ; 基地址加偏移量4访问第3个字

    ; (4) 基址变址寻址a[3]=4
    LEA BX, ARRAY       ; 加载数组基地址到BX
    MOV SI, 6           ; 将偏移量6存入SI
    ADC DX, [BX+SI]     ; 通过BX+SI的组合寻址获取第4个字
	IMUL DX
	IDIV [ARRAY+8]	    ; 直接寻址找到a[4]=5
	
	MOV [ARRAY+10], AX	; 商放在低位
CODE ENDS
END START