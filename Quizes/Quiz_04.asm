[org 0x0100]
jmp start
hourly_worked: dw 80
hourly_rate: dw 200
result dw 0
function:
push bp
mov bp,sp
sub sp,2
mov bx,[hourly_rate]
mov word[bp-2],bx

mov ax,[bp+4]
mul word[bp-2]
mov [result],ax
mov sp,bp
pop bp 
ret



start:
mov ax,[hourly_worked]
push ax
call function
mov ax,0x4c00
int 0x21