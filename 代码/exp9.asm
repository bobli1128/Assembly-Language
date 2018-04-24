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
			  mov di,0h;控制目标段的数据
			  mov si,30h;控制b段的数据
			  
	   matrix:call m1;调用矩阵函数
			  
			  mov ax,4c00h
			  int 21h
			  
	 add_sibp:add bp,10h
			  add si,2
			  ret
			   
	   ;matrix:call m1
	          ;ret
			  
		        m1:push cx;第一重循环
				   call m1_1
				   pop cx
				   ret
			  m1_1:call m2
				   call add_sibp
			       loop m1_1
				   ret
		   
				m2:push cx;第二重循环，将每一行列的值存在es中
				   call m2_1
				   pop cx
				   ret
			  m2_1:call m3
				   mov es:[di],dx
				   inc di
				   loop m2_1
				   add di,10h
				   ret
				   
				m3:push cx;第三重循环，计算每一个位置的值
				   call m3_1
				   pop cx
				   ret
			  m3_1:mov al,ds:[bp]
				   mov bl,ds:[si]
				   mul bl
				   add dx,ax
				   add bp,2
				   add si,10h
				   loop m3_1
				   ret
	codesg ends
	end start