.model small
.stack 100H
.data
plain_text DB 50 DUP(?) 
cipher DB 50 DUP(?) 
cipher_text DB 50 DUP(?) 
mess1 db 0ah,0dh,07h,"Enter String: ","$"
mess2 db 0ah,0dh,07h,"Enter Cipher: ","$"
mess3 db 0ah,0dh,07h,"Ciphertext is: ","$"


.code


mov ax,@data 
mov ds,ax

lea dx, mess1
mov ah,9
int 21h

lea si, plain_text
mov ah,01
again: int 21h
mov [si], al 
inc si
cmp al, 0dh
jne again

lea dx, mess2
mov ah,9
int 21h

lea si, cipher
mov ah,01
again1: int 21h
mov [si], al 
inc si
cmp al, 0dh
jne again1


lea si, plain_text
lea bx, cipher_text
A:
lea di, cipher
B:
mov ch, [SI]
mov cl, [DI]
.if(ch >= 41H && ch <=5AH)
sub ch, 41H
.else
sub ch, 61H
.endif
.if(cl >= 41H && cl <=5AH)
sub cl, 41H
.else
sub cl, 61H
.endif
add ch, cl
add ch, 97
.if(ch > 122)
mov dl, ch
mov ch, 97
M:
inc ch
dec dl
cmp dl, 123
jne M
.endif
mov [bx], ch
inc bx
inc SI
inc DI
cmp byte ptr [si], 0dh
je G
jne P
P:cmp byte ptr [di], 0dh
jne B
je A

G:
lea dx, mess3
mov ah,9
int 21h
lea di, cipher_text
mov ah, 02H
J:MOV DL, [DI]
int 21H
inc di
cmp byte ptr [di], 0dh
jne J





EXIT: mov ax, 4c00h
int 21h
end 