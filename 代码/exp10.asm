assume cs:codesg

 data segment
	db "Beginner's All-purpose Symbolic Instruction Code.",0
 data ends
 
 stack segment
	db 16 dup(0)
 stack ends
 
 codesg segment
	start:mov ax,stack
		  mov ss,ax
		  mov sp,10h
		  
		  mov ax,data
		  mov ds,ax
		  
		  mov si,0
		  push si
		  popf;初始化标志寄存器
		  
		  call letterc
		  
	 exit:mov ax,4c00h
		  int 21h
		  
  letterc:cmp byte ptr [si],0;判断遍历字符串结束，若为0则结束，不为0则进行下一步
		  jne next
		  je exit
		  
	 next:cmp byte ptr [si],97;判断字符ASCII码是否小于a若小于则不用修改
		  jb next_1
		  jnb above
		  
   next_1:inc si
		  jmp short letterc
		  
	above:cmp byte ptr [si],122;判断字符ASCII码是否大于z，若大于则不用修改
		  ja next_2
		  jna main
		  
	next_2:inc si
		   jmp letterc
		   
	  main:and byte ptr [si],11011111B
		   inc si
		   jmp short letterc
		  		  
 codesg ends

end start