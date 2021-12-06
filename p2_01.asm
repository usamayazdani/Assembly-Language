[org 0x0100]
jmp start
n: dw 3
fac: dw 0
result: dw 0
final: dw 0
    ;;;---------------------Factorial --
    factorial:
        push bp   ; bp push
        mov bp,sp  ;gettin same loction sp bp valus
        sub sp,2        ;local variabels
        mov word[bp-2],di       ;making local vaible        
        cmp word[bp-2],1        ;when it reach 1 so it's time to home
        jne L4
        mov ax,1        ;like return 1 
        jmp end 
        L4:
        cmp word[bp-2],0        ;base casee
        jne L6
        mov ax,1         ;like return 1   
        jmp end
        L6:
        mov ax,word[bp-2]       
        sub ax,1            
        mov di,ax           ;in every call di with first 5 then 4 then 3 2....
        call factorial      ;recursion
        mul word[bp-2]      ;when mov back it will multiply all value like 5*4*3*2*1
        end:
        leave  ;move sp value to bp and pop old bp value
        ret 
    ;;;;=-------------------calculatiing power
    power:
    
        push bp     ;pushing bp values
        mov bp,sp    ;location bp value 

        push bx             
        push cx
        push dx
        
        mov cx,[bp+4]       ;geting a value of that variable
        mov bx,0            

        mov ax,-1           ;-1 is hard value so we write it
        again:
        mov dx,-1
        cmp cx,1            ;firt case
        jz end_it
              
        mul dx          
        cmp cx,0        ;base case if it 0 goto end..it is basically for first loop whn cx 0
                        ;to get rid offf as 
        jz end_it
        add bx, 1
        
        cmp cx,bx
        jnc again
        end_it:
        pop dx 
        pop cx
        pop bx
        pop bp
        ret         ;returning ax value in power 
     ;------------------Main -----   
    summation:
        push bp                 ;as usual
        mov bp,sp               ; ^--^
        mov cx,0                ;our main loop
        iteration:              
        push cx
        call power              ;finding power of number
        mov [result],ax         ;for later use we power value
                                ;^ to store in result    
        pop cx                  ;geting agin our main loop value after power fun
        
        ;----fac fun-----       ;Damn fac fun!!<>          
        mov ax,cx       ;(2k+1)! mean tha mul ax with cx' value
        mov dx,2
        mul dx          ;if c is 1 mul with (2(1)) 
        add ax,1        ;(2K +1) ...after addition    
        
        push bp             ;here we push bp value because factorial will  work on it 
        mov bp,sp           ;as Usual
        sub  sp ,2           ;local varaible for first function
        mov word[bp-2],ax       ;assigning value
        mov ax,[bp-2]           ;same 
        mov di ,ax              ;geting value in di when we move back we will multipliy with
        call factorial      
        mov bx,ax           ;get a factorial value like 1 ,6,120 as....but in hexa 
        mov ax,[result]     ;already save value is now time to work on it
        div bx              ;why it don't divide dx but now it work with fine with bx ..main division 
        add [final],ax      ;final value to store all series
  
        
        pop ax              ;agin geting values
        
        pop bp              ;   it imp geting bp value of our orignal value
        

        
        
        add cx,1        ;main loppiiiiiiiiiiiiiiiiiiii
        cmp [bp+4],cx       ;  compare with parameter value
        jnc  iteration
        ;;;geting a signed value which is depend on conditon
        mov ax,[final]      ;maam na kah tha ka ax mn value store krni hn
        pop bp              ;so it time to back home
        ret 


start:
    mov bx,[n]      ;geting n values
    push bx         ;parameter 
    call summation

    mov ax,0x4c00
    int 0x21
