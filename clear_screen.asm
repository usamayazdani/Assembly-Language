[org 0x0100]
    jmp start
    ;clear screen 0741
    clearscreen:
    mov ax,0xb800
    mov es,ax       ;because we cant load it direct value
        ; es ->>[Extra segment ]
        ;di  ->>[destination index]
        ;cs 64kb block in memory 


    mov di,0
    loopi:
        ;mov word[es:di],0x0765
            ;01 --->blue
            ;02 --->green
            ;03 --->
        mov word[es:di],0x0720
            ;0x 'first two digit depend on our color
            ;07 is generral background black 
            ;          ^--> foreground white
            ;we also gave di our own choice values
        add di,2
        cmp di,4000
        jne  loopi
        ret

    start:
    call clearscreen
    mov ax,0x4c00
    int 0x21
