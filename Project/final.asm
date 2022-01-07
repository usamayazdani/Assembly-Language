[org 0x0100]

jmp start

name: db 'Caesar Cipher'
pointLength: dw 13

Members: db "Group Members Are: ",0
M_len: dw 18
Member1: db "Usama Yazdani (P20-0598): ",0
M_len1: dw 26
Member2: db "Subhan Khalid (P20-0086): ",0
M_len2: dw 26
welcome: db "*Welcome To Caesar Cipher* ",0
welcome_len: dw 28
Enter_txt: db "Text Which Have Entered: ",0
Enter_txt_len: dw 24

text: db "Enter the text: ",0
len_text: dw 15


text_2: db '=>Encrypted text is this: ',0
len_text2: dw 26
text_3: db '=>Decrypted text is this: ',0
len_text3: dw 26
label1: db "Press Enter Key To Continue........."
l_len: dw 36
message: times 1000 db '$'
message_len: dw 0

key: dw 3

encript_text: times 1000 db '$'

decrypted_text: times 1000 db '$'


;this function all data print on screen
;which get three parameter 
; 1: di value,  2: cx value how many time 3 :si value which label you want  
printscreen:
    push bp
    mov bp,sp    
    push ax
    push bx
    push cx
    push si
    mov ax,0xb800           ;load es value
    mov es,ax
    xor di,di           ;empty xor value
    mov si,[bp+6]
    mov cx,[bp+4]
    mov ah,0x07
    mov di,[bp+8]
    l1:
    mov al,[si]
    mov [es:di],ax
    inc si
    add di,2
    loop l1
    
    pop si
    pop cx
    pop bx
    pop ax
    pop bp
    ret 



;input function get input from users
input_function:
    mov bx,0
    
    L1:
    mov ah,1            ;interupt call for input store value in al
    int 21h
    cmp al,13           ;when user press enter it will end
    je programend
    mov [message+bx],al             ;pointing to label memory
    
    add bx,1            ;incremt bx to point to next location    
    jmp L1      
    programend:
    mov al,0            ;in the end just insert 0 bcz to get rid off garbages values
    mov [message+bx],al
    ret
printmessage:
    mov si,message          ;si pointing to our input label
    mov ax,0xb800
    mov es,ax
    mov di,484            ;seting di value to 
    mov cx,bx
    mov ah,0x05
    L2:                              ;print input on screen
    mov al,[si]
    mov [es:di],ax
    add si,1
    add di,2
    loop L2
    ret

 ;clear screen code
clrscr:
    push es
    push ax
    push cx
    push di

    mov  ax, 0xb800
    mov  es, ax
    xor  di, di
    mov  ax, 0x0720
    mov  cx, 2000

    cld                 ; auto-increment mode 
    rep stosw           ; rep cx times, store words 
                    
    pop  di
    pop  cx
    pop  ax
    pop  es
    ret

;taking two paramete first memory location and second lenght
Encrypt_data:
    push bp
    mov  bp, sp
    push ax
    push cx 
    push si 
    push bx
    mov bx,0         ;for index
    mov si,[bp+6]   ;our msg
    mov cx,[bp+4]   ;
    xor di,di
    mov dl,[key]        ;there is key value which we set 
    
    E_Nextchar:
        mov al,[si]
        ;now encrypting
        xor al,dl
        ;putting back in same message character location
        mov [encript_text+bx],al
        inc bx
        add si, 1
       
        xor al,al

        loop E_Nextchar 
        mov al,0x0  ;end
        mov [encript_text+bx],al        ;point last index index to zero

    pop bx
    pop si 
    pop cx 
    pop ax  
    pop bp 
    ret 4 


;decrpyted text
Decrypt_data:
    push bp
    mov  bp, sp
    push ax
    push cx 
    push si
    push bx 
    mov si,[bp+6]
    mov cx,[bp+4]
    xor di,di
    mov dl,[key]
    mov bx,0
    D_Nextchar:
        mov al,[si]
        ;now encrypting

        xor al,dl

        ;putting back in same message character location

        mov [decrypted_text+bx],al
        inc bx
        add si, 1

     
        loop D_Nextchar 
        mov al,0x0
        mov [decrypted_text+bx],al          ;point last index index to zero
    pop bx
    pop si 
    pop cx 
    pop ax  
    pop bp 
    ret 4 



strlen:
    push bp
    mov  bp,sp
    push es
    push cx
    push di

    les  di, [bp+4]     ; load DI from BP+4 and ES from BP+6
    mov  cx, 0xffff     ; maximum possible length 
    
    xor  al, al         ; value to find 
    repne scasb         ; repeat until scan does not become NE to AL 
                        ; decrement CX each time 

    mov  ax, 0xffff     
    sub  ax, cx         ; find how many times CX was decremented 

    dec  ax             ; exclude null from the length 

    pop  di
    pop  cx
    pop  es
    pop  bp
    ret  4
;Printing of # on screen 



Hash_Printing:
    push bp
    mov  bp, sp
    push es
    push ax
    push cx 
    push si 
    push di 

    mov ax, 0xb800 
    mov es, ax 
    mov di, 0            

    mov ah, 0x09
    mov al, '#'
    nextloc1:
    cmp di, 120
    mov  word [es:di], ax
    add  di, 2
    cmp  di, 160
    jne  nextloc1

     mov  di, 3680

    bottomloc:
        mov  word [es:di], ax
        add  di, 2
        cmp  di, 3840
        jne  bottomloc

        mov di, 160
        mov cx, 22
    vertical_LOC:

        mov [es:di], ax 
        add di, 158
        mov [es:di], ax 
        add di, 2
        loop vertical_LOC

    mov di, 3900
    mov si, name
    mov cx, [pointLength]
    mov ah, 0x02 

    print1: 
        mov al, [si]
        mov [es:di], ax 
        add di, 2 
        add si, 1 
        

        loop print1



    pop di 
    pop si 
    pop cx 
    pop ax 
    pop es 
    pop bp 


ret




start:
    call clrscr 
    mov di,360
    mov ax,Members
    mov cx,[M_len]
    push di
    push ax
    push cx
    call printscreen
   
    ; mov ah, 0x1        ; input char is 0x1 in ah 
    ; int 0x21 

;   For member1

    mov di,680
    mov ax,Member1
    mov cx,[M_len1]
    push di
    push ax
    push cx
    call printscreen        ; input char is 0x1 in ah 
    ; mov ah, 0x1 
    ; int 0x21 

    ;---------------
    ;For member2
    
    mov di,840
    mov ax,Member2
    mov cx,[M_len2]
    push di
    push ax
    push cx
    ; mov si, NewLine
    call printscreen        ; input char is 0x1 in ah 

    mov di,1280
    mov ax,label1   ;press enter to continue
    mov cx,[l_len]
    push di
    push ax
    push cx
    call printscreen

    mov ah, 0x1 
    int 0x21 

    ;-----------print first label 
    call clrscr 
    ;welcome writing
    mov di,202
    mov ax,welcome         ;enter the text
    mov cx,[welcome_len]
    push di
    push ax
    push cx
    ; mov si, NewLine
    call printscreen
    ;--------------
    mov di,480
    mov ax,text         ;enter the text
    mov cx,[len_text]
    push di
    push ax
    push cx
    ; mov si, NewLine
    call printscreen

    ;Taking input from users
    call input_function

    call clrscr 
    call Hash_Printing
    mov di,324
    mov ax,Enter_txt         ;enter the text
    mov cx,[Enter_txt_len]
    push di
    push ax
    push cx
    ; mov si, NewLine
    call printscreen

    ; ;mov di,480
    ; ;mov ax,message         
    ; ;mov cx,[message_len]
    ; push di
    ; push ax
    ; push cx
    ; mov si, NewLine
    call printmessage

    ;-------print second label
    mov di,1000
    mov ax,text_2   ;Encrypt_data
    mov cx,[len_text2]
    push di                
    push ax
    push cx
    call printscreen
    ;-------------calculate len of user input from user
    push ds
    mov  ax, message
    push ax
    call strlen
    mov [message_len],ax



   ;------> ;For Encrypt_data
    

    mov ax, message 
    push ax 
    push word [message_len]
    call Encrypt_data

 
    ;=--------      print on screen encryption data
    mov di,1160
    mov ax,encript_text
    mov cx,[message_len]
    push di
    push ax
    push cx
    call printscreen
    ;--------------------
 
;-------------------------------------------

    ;------> ;For Decrypt_data
 
;---------------------decrypted label 
    mov di,1800
    mov ax,text_3
    mov cx,[len_text3]
    push di                
    push ax
    push cx
    call printscreen
;------------               decryption label
    mov ax, encript_text
    push ax 
    push word [message_len]
    call Decrypt_data
   
    ;----------------printing on decrpyted label
    mov di,1960
    mov ax,decrypted_text
    mov cx,[message_len]
    push di
    push ax
    push cx
    call printscreen
    ;--------------------
    



    ;It is used for  waiting 

    mov ah, 0x1 ;wait for key press
    int 0x21 

    mov ax,0x4c00
    int 0x21
