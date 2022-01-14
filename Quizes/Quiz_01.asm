[org 0x0100]
jmp start
msg: db "Programing Languages",0
find: db 'g'
total: dw 0
Msg_len: dw 0

calulate:
push bp
mov bp,sp
sub sp,2
mov word[bp-2],0
pusha
mov si,[bp+6]
mov cx,[bp+4]
xor ax,ax
l2:
mov al,[si]
inc si
cmp al,[find]
jz yes
on:
loop l2
jmp end

yes:
add word[bp-2],1
jmp on

end:
mov ax,[bp-2]
mov [total],ax
popa
mov sp,bp
pop bp
ret
strlen:
push bp
mov bp,sp
pusha
mov cx,0xffff
mov al,0
mov di,[bp+4]
repne scasb
mov ax,0xffff
sub ax,cx
dec ax
mov [Msg_len],ax
popa
pop bp
ret


start:
mov ax,msg
push ax
call strlen
mov ax,msg
push ax
push word[Msg_len]
call calulate
mov ax,0x4c00
int 0x21