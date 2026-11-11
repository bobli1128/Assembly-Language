assume cs:codesg
 data segment
	db '1975','1976','1977','1978','1979','1980','1981','1982','1983'
	db '1984','1985','1986','1987','1988','1989','1990','1991','1992'
	db '1993','1994','1995'
	;表示21年21个字符串
	
	dd 16,22,382,1356,2390,8000,16000,24486,50065,97479,140417,197514
	dd 345980,590827,803530,1183000,1843000,2759000,3753000,4649000,5937000
	;以上表示21年公司的21个dword型数据
	
	dw 3,7,9,13,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635,8226
	dw 11542,14430,15257,17800
	;以上是表示21年公司雇员的21个word型数据
 data ends
 
 table segment
	db 21 dup ('year summ ne ?? ')
 table ends
 
 codesg segment  
    start:                          ;设置段地址  
            mov ax,data  
            mov es,ax  
            mov ax,table  
            mov ds,ax  
              
              
            mov bx,0                ;table 数据的偏移地址，决定从哪一行开始  
            mov bp,0                ;年份，收入（4字节）数据的偏移地址，每次增加4  
            mov si,0                ;雇员数（2字节）数据的偏移地址，每次增加2  
            mov cx,21               ;总共21年，循环21次  
            a:                      ;将年份（4字节）数据复制到 year 上  
                mov ax,es:[bp+0]  
                mov ds:[bx+0],ax  
                mov ax,es:[bp+2]  
                mov ds:[bx+2],ax  
                  
                                    ;将收入（4字节）数据复制到 summ 上  
                mov ax,es:[bp+54H]  
                mov ds:[bx+5],ax  
                mov ax,es:[bp+56H]  
                mov ds:[bx+7],ax  
                  
                                    ;将雇员数（2字节）数据复制到 ne 上  
                mov ax,es:[si+0A8H]  
                mov ds:[bx+10],ax  
                  
                                    ;将人均收入（2字节）数据复制到 ?? 上  
                mov ax,ds:[bx+5]  
                mov dx,ds:[bx+7]  
                div word ptr ds:[bx+10]  
                mov ds:[bx+13],ax  
                  
                                    ;累加操作  
                add si,2  
                add bp,4  
                add bx,16  
            loop a  
            mov ax,4C00H  
            int 21H  
codesg ends  
end start  
