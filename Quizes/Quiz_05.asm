;print on screen which has value greater then three
[org 0x0100]
jmp start
array: db 5, 4, 2, 1  ,7, 6 ,8,4,9
array_len: dw 9      ;bcz the length is double due to word
;outputed:  times 50 db '$'  ;just like allocate a memory in 
outputed: db 0,0,0,0,0,0,0
outputed_len: dw 7
function:
push bp
mov bp,sp
pusha
mov si,array
mov cx,[bp+4]
mov di,0
mov bl,3
L1:
mov dl,[si]
cmp dl,bl
jnc output
loo:
inc si
loop L1
jmp display_on


output:
xor ax,ax
mov al,[si]
mov [outputed+di],al
inc di
jmp loo
;--------------------
display_on:
mov ax,0xb800
mov es,ax
;mov cx,di   ;;;geting lenght of how many di loop runs
mov cx,[outputed_len]
mov di,180
mov ah,0x07
mov si,[outputed]
l3:
mov al,[si]
mov [es:di],ax
add di,2
inc si
loop l3
;----------------

end:
popa
pop bp
ret

start:
mov ax,array
push ax
mov bx,[array_len]
push bx
call function
mov ax,0x4c00
int 0x21