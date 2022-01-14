;check the min value


[org 0x0100]
jmp start

array: db 5, 2 , 5 , 1 , 8 , 70, 5
array_len: dw 7
min: dw 0

check:
push bp
mov bp,sp
sub sp,2
mov ax,[bp+4]
mov si,array
mov cx,[bp+6]
mov al, [array]
mov word[bp-2],ax
mov dx,0
L2:
cmp al,[si]
jg swap
loopi:
inc si
loop L2
jmp end
swap:
mov dl,[si]
mov [si],al
mov al,dl
mov word[bp-2],ax
jmp loopi
end:
mov al,[bp-2]
mov [min],ax
mov sp,bp
pop bp
ret

start:

mov ax,[array_len]
push ax
mov ax,[min]
push ax


call check
mov ax,0x4c00
int 0x21