[org 0x0100]
jmp start

array: db 5, 2 , 5 , 1 , 8 , 5 , 2 , 1 , 0 , 0 , 70 , 5 , 0 
array_len: dw 13
value1: dw 5

check:
push bp
mov bp,sp
sub sp,2
mov ax,[bp+4]
mov word[bp-2],ax
mov si,array
mov cx,[bp+6]
xor ax,ax
mov dx,0
L2:
mov al,[si]
inc si
cmp al,[bp-2]
jz equal
loopi:
loop L2
jmp end
equal:
add dx,1
jmp loopi
end:
mov sp,bp
pop bp
ret

start:

mov ax,[array_len]
push ax
push word[value1]


call check
mov ax,0x4c00
int 0x21