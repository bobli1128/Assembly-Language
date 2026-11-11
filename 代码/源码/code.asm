assume cs:code
 code segment
	
	mov ax,cs
	mov ds,ax
	mov ax,0020H
	mov es,ax
	mov bx,0
	mov cx,23
	
      s:mov al,[bx]	
	mov es:[bx],al
	inc bx
	loop s
	
	mov ax,4c00H
	int 21H
 code ends
end