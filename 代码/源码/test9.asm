assume cs:codesg

	a segment
		dw 1,2,3,0,0,0,0,0
		dw 4,5,6,0,0,0,0,0
		dw 7,8,9,0,0,0,0,0
	a ends;存放矩阵A
	
	b segment
		dw 9,8,7,0,0,0,0,0
		dw 6,5,4,0,0,0,0,0
		dw 3,2,1,0,0,0,0,0
	b ends;存放矩阵B
	
	c segment
		dw 8 dup(0)
		dw 8 dup(0)
		dw 8 dup(0)
	c ends;用于存放矩阵的结果
	
	stack segment
		db 16 dup(0)
	stack ends
	
	codesg segment
		start:mov ax,a
		      mov ds,ax
			  
			  mov ax,c
			  mov es,ax
			  
			  mov ax,stack
			  mov ss,ax
			  mov sp,10h
			  
			  mov cx,3
			  
			  
			  mov bx,0
			  mov ax,0
			  mov dx,0
			  
			  mov bp,0;控制a段的数据
			  mov di,0;控制目标段的数据
			  mov si,30h;控制b段的数据
			  
	   matrix:call m2;主函数
			  add bp,10h;控制a段的数据的换行，控制行的变化
			  mov si,30h;b段偏移初始化
	          loop matrix
			  
			  mov ax,4c00h
			  int 21h
			  
		   m2:push cx;将计算后的每一行的值放入目标地址，控制列的变化
			  mov cx,3
		 m2_1:call m3
		      mov es:[bp+di],dx
			  add di,2
			  mov si,30h;b段偏移初始化
			  add bx,2
			  add si,bx
			  
			  mov dx,0
			  
			  loop m2_1
			  
			  mov bx,0
			  mov di,0
			  
			  pop cx
			  
			  ret
			  
			    m3:push cx
				   push bx
				   push di
				   mov di,0
				   mov bx,0
				   mov cx,3
				   add di,bp
				   
			  m3_1:mov al,ds:[di];矩阵乘法实现
				   mov bl,ds:[si]
				   mul bl
				   add dx,ax
				   add di,2
				   add si,10h
				   loop m3_1
				   
				   pop di
				   pop bx
				   pop cx
				   
				   ret
	codesg ends
	end start