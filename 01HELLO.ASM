.model tiny
.code

org 100h

VIDEOSEG 	equ	 0b800h
CORNER_SYM	equ	 '+'
HOR_SYM		equ	 '-'
VER_SYM		equ	 '|'
COLOR		equ  1Ah 


Start:						
			mov ax, VIDEOSEG
			mov es, ax
			
			call Drawline

			mov bx, 726h
			mov si, offset stroka
			lodsb
			mov cx, 7

kok:		mov byte ptr es:[bx], al
			mov byte ptr es:[bx + 1], COLOR
			add bx, 2
			lodsb
			loop kok

			xor ax, ax
			int 16h

			mov ax, 4c00h
			int 21h
			
Drawline proc
			mov bx, 490h
			mov ah, CORNER_SYM
			mov al, HOR_SYM
			call PrintLine

			mov cx, 7d
ass:		add bx, 104d
			mov ah, VER_SYM
			mov al, ' '
			call PrintLine
			loop ass

			add bx, 104d
			mov ah, CORNER_SYM
			mov al, HOR_SYM
			call PrintLine

			ret
Drawline endp

PrintLine proc
			push cx
			mov byte ptr es:[bx], ah
			mov byte ptr es:[bx + 1], COLOR

			mov cx, 27d
Line:		add bx, 2
			mov byte ptr es:[bx], al
			mov byte ptr es:[bx + 1], COLOR
			loop Line

			add bx, 2
			mov byte ptr es:[bx], ah
			mov byte ptr es:[bx + 1], COLOR
			
			pop cx
			ret
PrintLine endp

stroka 		db 'PIDARAS' ;Строка для вывода	

end Start


