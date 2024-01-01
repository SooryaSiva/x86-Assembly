.model small
.stack 100H
.data
mess1 db 0ah,0dh,07h,'This program is an attempt at paint $'
mess2 db 0ah,0dh,07h,'To move left use D, right A, up W and down S $'
messA db 0ah,0dh,07h,'To print a pixel press space $'
mess3 db 0ah,0dh,07h,'To change the color use the scheme given below $'
messP db 0ah,0dh,07h,'$'
mess4 db '1 $'
mess5 db '2 $'
mess6 db '3 $'
mess7 db '4 $'
mess8 db '5 $'
mess9 db '6 $'
messG db '7 $'
messB db '8 $'
messC db '9 $'
messH db 'G $'
messE db 'B $'
messF db 'C $'
messI db 'H $'
messJ db 'E $'
messK db 'F $'
messQ db 0ah,0dh,07h,'To delete a pixel press Q $'
messW db 0ah,0dh,07h,'USE ONLY CAPITAL LETTERS $'
messD db 0ah,0dh,07h,'To exit press any other key $'

row dw 100
col dw 100
lastrow dw 0170
lastcol dw 0300

pixel0 db 00H
pixel1 db 01H
pixel2 db 02H
pixel3 db 03H
pixel4 db 04H
pixel5 db 05H
pixel6 db 06H
pixel7 db 07H
pixel8 db 08H
pixel9 db 09H
pixelG db 0AH
pixelB db 0BH
pixelC db 0CH
pixelH db 0DH
pixelE db 0EH
pixelF db 0FH
pixel DB 20 DUP(?)
mode db 00h
pg db 00h

Display Macro Disp
	lea dx, disp
	mov ah,09h
	int 21h
	endm

Putpix Macro pixel
	mov ah, 0ch
	mov al, pixel
	int 10h
	endm

Printf Macro mess,col
	mov ah, 09h
	mov bh, 00h
	mov bl, col
	mov cx, 01H
	lea dx, mess
	int 10h
	int 21H
	endm

exchg Macro pixeln
	lea si, pixeln
	lea di, pixel
	mov bl, [si]
	mov [di], bl
	endm


.code
.startup

	display mess1
	display mess2
	display messA
	display mess3
	display messP
	printf mess4,01H
	printf mess5,02H
	printf mess6,03H
	printf mess7,04H
	printf mess8,05H
	printf mess9,06H
	printf messG,07H
	printf messB,08H
	printf messC,09H
	printf messH,0AH
	printf messE,0BH
	printf messF,0CH
	printf messI,0DH
	printf messJ,0EH
	printf messK,0FH
	display messD
	display messQ
	display messW

A:	mov ah,01h
	int 21h
	.if(al==0dh)
	mov ah,0fh
	int 10h
	mov mode, al
	mov pg, bh

	mov ah,00h
	mov al,0Eh
	mov bh,00h
	int 10h

	mov cx, col
	mov dx, row
	exchg pixel3
B:	mov ah,07h
	int 21h
	.if(al==20H)
	putpix pixel
	inc cx
	jmp B
	.else
	.if(al==53H)
	inc dx
	dec cx
	jmp B
	.else
	.if(al==0DH)
	jmp D
	.else
	.if(al==41H)
	dec cx
	dec cx
	jmp B
	.else
	.if(al==57H)
	dec dx
	dec cx
	jmp B
	.else
	.if(al==44H)
	inc cx
	jmp B
	.else
	.if(al==50H)
	dec cx
	putpix pixel0
	jmp B
	.else
	jmp E
	.endif
	.endif
	.endif
	.endif
	.endif
	.endif
	.endif


E:	.if(al==31H)
	exchg pixel1
	jmp B
	.else
	.if(al==32H)
	exchg pixel2
	jmp B
	.else
	.if(al==33H)
	exchg pixel3
	jmp B
	.else
	.if(al==34H)
	exchg pixel4
	jmp B
	.else
	.if(al==35H)
	exchg pixel5
	jmp B
	.else
	.if(al==36H)
	exchg pixel6
	jmp B
	.else
	.if(al==37H)
	exchg pixel7
	jmp B
	.else
	.if(al==38H)
	exchg pixel8
	jmp B
	.else
	.if(al==39H)
	exchg pixel9
	jmp B
	.else
	.if(al==47H)
	exchg pixelG
	jmp B
	.else
	.if(al==42H)
	exchg pixelB
	jmp B
	.else
	.if(al==43H)
	exchg pixelC
	jmp B
	.else
	.if(al==48H)
	exchg pixelH
	jmp B
	.else
	.if(al==45H)
	exchg pixelE
	jmp B
	.else
	.if(al==46H)
	exchg pixelF
	jmp B
	.else
	.if(al==30H)
	exchg pixel0
	jmp B
	.else
	jmp B
	.endif
	.endif
	.endif
	.endif
	.endif
	.endif
	.endif
	.endif
	.endif
	.endif
	.endif
	.endif
	.endif
	.endif
	.endif
	.endif


D:	mov ah,01h
	int 21h
	mov ah,00h
	mov al, mode
	mov bh, pg
	int 10h
	jmp EXT
	
	.else
	jmp A
.endif

EXT: .EXIT
END

