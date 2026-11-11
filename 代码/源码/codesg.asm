assume cs:codesg
 a segment
	dw 1,2,3,4,5,6,7,8,9,0aH,0bH,0cH,0dH,0eH,0fH,0ffH
 a ends

 b segment
	dw 0,0,0,0,0,0,0,0
 b ends

 codesg segment
	
 start:
	mov ax,a
	mov ds,ax
	
	mov ax,b
	mov ss,ax
	mov sp,0010H
	mov bx,0
	mov cx,8
	
  s:push [bx]
	add bx,2
	loop s
	
	mov ax,4c00H
	int 21H
 codesg ends
end start