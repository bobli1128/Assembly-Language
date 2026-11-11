assume cs:code
data segment
  db '1975','1976','1977','1978','1979','1980','1981','1982','1983'
  db '1984','1985','1986','1987','1988','1989','1990','1991','1992'
  db '1993','1994','1995' 
        
  dd 16,22,382,1356,2390,8000,16000,24486,50065,97479,140417,197514
  dd 345980,590827,803530,1183000,1843000,2759000,3753000,4649000,5937000      
  dw 3,7,9,13,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635,8226
  dw 11542,14430,15257,17800
data ends

table segment
 db 21 dup ('year summ ne ?? ')
table ends

code segment
start:
mov ax,table
  mov ds,ax      
  mov ax,data
  mov es,ax   
  mov di,0
  mov si,0
  mov bx,0
  mov cx,21

 s:

  mov ax,es:[di]
  mov ds:[bx+0],ax
  mov ax,es:[di+2]
  mov ds:[bx+2],ax
  
  mov ax,es:[54h+di]
  mov ds:[bx+5h],ax
  mov ax,es:[56h+di]
  mov ds:[bx+7h],ax

  mov ax,es:[0a8h+si]
  mov ds:[bx+0ah],ax
  
  mov ax,ds:[bx+5h] 
  mov bx,ds:[bx+7h]
  div word ptr ds:[bx+0ah]
  mov ds:[bx+0dh],ax
  
  add bx,10h
  add di,4
  add si,2 

  loop s
  
  mov ax,4c00h
  int 21h
code ends
end start