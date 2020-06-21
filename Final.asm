; multi-segment executable file template.

data segment
    
    ;:::::::::MENU STRING::::::::::::::::
    loadcoins db " - Load coin stock $"
    startops db " - Start operation $"
    displays db " - Display coin stock $"
    abouts db " - About $"
    sairs db " - Exit $" 
    
    ;:::::::::LOAD COIN:::::::::::::
    aguarde db "A ler ficheiro. Aguarde..." 
    voltar  db "Para voltar clique no botao direito"
    
    ;:::::::STARTOP:::::
    ctimes db "Current Time:  $"
    mountd db "Amount due:$"
    accumulatedpay db " Accumulated payment: $"
    insertcardtime db "Insert Card's Time: $"
    horacerta db "A hora introduzida esta correta? $" 
    ok db "   OK   "  
    numbercoins db "Number of Coins:"
    
    ;::::::DISPLAY:::::
    numberofcoins db " Number of Coins:  $"
    totalmoney db "-The total of money stored is:",0
    coinstock db "-Coin Stock:$"
    espaco db "      $"  
    espaco2 db "   $"
    espaco3 db "         $" 
    
    
    ;::::::ABOUT::::::
    nome1 db "Rafael Rodrigues n45737 $"
    nome2 db "Fabio Araujo n45028 $"
    nome3 db "****TRABALHO FINAL DE MICROS*** $"

    
    ;::::OTHER 
    ficheiroscarregados db "Os ficheiros foram carregados com sucesso...$" 
    carreguetecladireita db "Carregue na tecla direita para voltar!$" 
    
   
    ;TROCO
    
    business db "Thank you for your Business"
    change db "Your change is"
    returning db "Returning change:"
    naohatroco1 db  "No Change Available"
    naohatroco2 db "- Please insert exact amount"
   
   
    ;:::::COIN STRINGS:::::
    coins0 db "Coins: $"
    euro db "Euro:$"
    euros db "Euros$"
    cent db "Cent$"
    cents db "Cents: $"
    eur db "Eur$"
    eur1 db " Eur: $" 
    e2 db "2 Eur:$"
    e1 db "1 Eur:$" 
    c50 db "50 Cents:$" 
    c20 db "20 Cents:$"
    c10 db "10 Cents:$" 
    c5 db "5 Cents:$"
    c2 db "2 Cents:$"
    c1 db "1 Cent:$"
    edois db "2 Euro"
    eum  db "1 Euro"
    ccinquente  db "50 Cents"
    cvinte  db "20 Cents"
    cdez    db "10 Cents"
    ccinco  db "5 Cents"
    cdois   db "2 Cents"
    cum     db "1 Cents"
    
  
    ncoins db " Number of Coins: $"
    acpayment db "Accumalated payment: $"
    
    ;::::::FICHEIROS::::::
    ;enderecos
    handle dw ?
    handle1 dw ?
    
    
    ;nomes ficheiros
    stock db "stock.txt",0       
    fcontents db "contents.txt",0
    
    ;variavel geral
    temp db 200 dup (0)
    ;variaveis de leitura selecionada
    num1 dw 0 
    num2 dw 0 
    tempnum1 db 3 dup(0)
    tempnum2 db 3 dup(0)
    
     
    
    
    ;::::VARIABLES::::::::::::
    
        ;CARDS TIME
        cardtime db 2 dup(0)   ;hour/minute
        
        horamin1 dw 0
        horamin2 dw 0 
        
        horaints db "Hora introduzida esta correta?"
        sim db "sim"
        nao1 db "nao"
        limpalinha db "                                        "
        
        
        ;HORA NOW
        horaactual db 0,0,0   ;hour/minute/second
       
        ;COIN VARIABLES
        stockmoedas db 8 dup(0)  ;2e/1e/50c/20c/10c/5c/2c/1c
                                 ;todas as moedas do sistema
        
        caixai dw 0              ;valor inteiro do total stock
        caixad dw 0              ;valor decimal do total stock
        
        coinsinput db 8 dup(0)   ;moedas introduzidas
                                 ;2e/1e/50c/20c/10c/5c/2c/1c
        amountduei dw 0
        amountdued dw 0 
        vetortroco db 8 dup(0)
        
    
    

ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
; set segment registers:
    mov ax, data
    mov ds, ax
    mov es, ax  

;::::::CODE:::::::::::
 inicio:
 call printmenuinicial
 jmp exit
 
;::::::FIM CODE:::::::    
    
    
    
    
    
    

  ;:::::PROCS::::::::::::::::
     ;PRINT MENU INICIAL 
     
    printmenuinicial proc 
        
        ;set video mode
        mov al, 13h
        mov ah, 0
        int 10h
         
        mov bl, 1111b ; Cor Branco
        mov bh, 0  ; Numero de Pagina
        mov cx,19  ; Numero de Caracteres    
        mov dl, 0  ; coluna
        mov dh,1  ;linha
        lea bp, loadcoins
        call printstringg
        
        mov bl, 1111b ; Cor Branco
        mov bh, 0  ; Numero de Pagina
        mov cx,19  ; Numero de Caracteres    
        mov dl, 0  ; coluna
        mov dh,3  ;linha
        lea bp, startops
        call printstringg
                 
        mov bl, 1111b ; Cor Branco
        mov bh, 0  ; Numero de Pagina
        mov cx,22  ; Numero de Caracteres    
        mov dl, 0  ; coluna
        mov dh,5  ;linha
        lea bp,  displays
        call printstringg
        
        mov bl, 1111b ; Cor Branco
        mov bh, 0  ; Numero de Pagina
        mov cx,9  ; Numero de Caracteres    
        mov dl, 0  ; coluna
        mov dh,7  ;linha
        lea bp,  abouts
        call printstringg
        
        mov bl, 1111b ; Cor Branco
        mov bh, 0  ; Numero de Pagina
        mov cx,8  ; Numero de Caracteres    
        mov dl, 0  ; coluna
        mov dh,9  ;linha
        lea bp,  sairs
        call printstringg 
        
        call ratomenuinicial ;entranoloop posicao rato
        ret   
        
        
         
    endp 
;::::::::::::::::::::::::::::::::::::::::::::
 
  ;RATO MENU INICIAL
  
  ratomenuinicial proc
            
         xor ax,ax    ;mouse inicialization
         int 33h
   
         looprato:
         mov ax, 2    ;limpa rasto do rato
         int 33h
         mov ax, 3
         int 33h
         
         cmp bx, 2      ;botao direito 
         je verposicao
         cmp bx,1 
         je verposicao 
         jmp looprato
         
         verposicao: 
         
         cmp cx, 15Ch
         ja outsquare
         cmp dx, 53h 
         ja outsquare
         cmp dx, 13h
         jb loadcoin
         cmp dx, 22h
         jb startop
         cmp dx, 31h 
         jb display 
         cmp dx, 41h 
         jb about
         jmp exit
         
         outsquare:
         jmp looprato
         
        endp
        
;::::::::::::::::::::::::::::::::::::::::::::
    ;LOADCOIN (sem precondicoes)  
      
      loadcoin proc
          xor ah,ah
          int 10h
          
          mov al, 13h
          mov ah, 0 
          int 10h 
          
          call lermoedas
          
          mov bl, 1111b
          mov ch, 0 
          mov cx, 35
          mov dl, 4
          mov dh, 5 
          lea bp, voltar
          call printstringg 
          
          looprato1: 
          mov ax, 3
          int 33h
          
          cmp bx, 2
          je backmenu
          jmp looprato1
          
          backmenu:
          jmp inicio
          
          endp
;::::::::::::::::::::::::::::::::::::::::
     ;STARTOP
   
     startop proc
          ;videomode set
          mov ah,0 
          mov al, 13h
          int 10h
          ;:::::::::: 
          
          
          xor ah,ah
          int 10h
          
          mov si, offset horaactual
          call printhora
          call cardstime
           
          call calcularperiodos
          mov bl, 60  ;preco por periodo
          call amountdue    ;amoutduei (preco euros)/amountdue d(preco em centimos)
          
          
          reeintruduzirmoedas:
          
           mov bl, 1111b ; Cor Branco
           mov bh, 0  ; Numero de Pagina
           mov cx, 11  ; Numero de Caracteres    
           mov dl, 0  ; coluna
           mov dh,4  ;linha
           lea bp, mountd
           call printstringg
           
           xor ax,ax
           mov ax, amountduei
           call numeroparaascii
           mov dl, 12
           call imprimirnumeroascii
           
           call inccursor
           mov ah, 09h
           mov al, ','
           mov bh, 0 
           mov bl, 1111b
           mov cx, 1
           int 10h
           
           call inccursor
           
           xor ax,ax
           mov ax, amountdued
           call numeroparaascii
           call imprimirnumeroascii
           
           call inccursor
           mov bl, 1111b ; Cor Branco
           mov bh, 0  ; Numero de Pagina
           mov cx, 3  ; Numero de Caracteres    
           mov dh,4  ;linha
           lea bp, eur
           call printstringg
           
           call coins
          
          
          looprato2:
          mov ax, 3
          int 33h   ;posicao e estado
          cmp bx, 2 ;butao direito
          je backmenu  ;volta para o outro proc onde volta inico(menos memoria)
          
          ;call printhora 
          jmp looprato2
          
          endp     
;:::::::::::::::::::::::::::::::::::
     
     ;DISPLAY MENU (MOSTRA STOCK MOEDAS)
     display proc
          ;videomode set
          mov ah,0 
          mov al, 13h
          int 10h
          ;::::::::::::
          
          xor ah,ah   ;limpar ecran
          int 10h 
          
          mov si, offset stockmoedas
          call somarvetormoedas      ;fazer soma moedas em stock (atualiza caixai e caixad
          
    
    ;:::Total Money:::
        mov bl, 1111b ; Cor Branco 
        mov bh, 0  ; Numero de Pagina
        mov cx, 30 ; Numero de Caracteres    
        mov dl,0 ; coluna
        mov dh,0  ;linha
        lea bp, totalmoney            
        call printstringg 
        
      ;set cursor position
      mov ah, 2
      mov dh, 0
      mov dl, 30
      mov bh,0
      int 10h 
     
      
      mov ax, caixai 
      call numeroparaascii
      inc dl
      call imprimirnumeroascii 
      
      call inccursor
      
      mov al,44
      mov ah, 09h
      mov bh, 0     ;numpag
      mov bl, 1111b ;corbranca 
      mov cx, 1
      int 10h
      
      
      
      mov ax, caixad
      call numeroparaascii
      inc dl ;startcursor x
      mov bh, 1
      call imprimirnumeroascii
      xor bx, bx
      
      call inccursor
      
      mov bl, 1111b ; Cor Branco 
      mov bh, 0  ; Numero de Pagina
      mov cx, 3 ; Numero de Caracteres    
      lea bp, eur            
      call printstringg 
      
      call mudarlinha
      call mudarlinha
      
      mov bl, 1111b ; Cor Branco 
      mov bh, 0  ; Numero de Pagina
      mov cx, 12 ; Numero de Caracteres    
      lea bp, coinstock            
      call printstringg
      
      call mudarlinha
      call mudarlinha
      
      
      mov bl, 1111b ; Cor Branco 
      mov bh, 0  ; Numero de Pagina
      mov cx, 6 ; Numero de Caracteres    
      lea bp, e2            
      call printstringg
      
      mov si, offset stockmoedas
      xor ax,ax
      mov al, [si] 
      
      
      call numeroparaascii
      mov dl, 7 ;start cursor
      call imprimirnumeroascii 
      
     ;set cursor
      mov ah, 2 
      mov dl, 18
      mov bh,0
      int 10h 
      
      mov bl, 1111b ; Cor Branco 
      mov bh, 0  ; Numero de Pagina
      mov cx, 6 ; Numero de Caracteres    
      lea bp, e1            
      call printstringg
      
      xor ax,ax
      mov al,[si+1]
      call numeroparaascii
      mov dl, 24
      call imprimirnumeroascii 
      
      call mudarlinha
      
      mov bl, 1111b ; Cor Branco 
      mov bh, 0  ; Numero de Pagina
      mov cx, 9 ; Numero de Caracteres    
      lea bp, c50          
      call printstringg
      
      xor ax,ax
      mov al,[si+2]
      call numeroparaascii
      mov dl, 9
      call imprimirnumeroascii
      
      ;set cursor
      mov ah, 2 
      mov dl, 15
      mov bh,0
      int 10h
      
      
      mov bl, 1111b ; Cor Branco 
      mov bh, 0  ; Numero de Pagina
      mov cx, 9 ; Numero de Caracteres    
      lea bp, c20          
      call printstringg
      
      xor ax,ax
      mov al,[si+3]
      call numeroparaascii
      mov dl, 24
      call imprimirnumeroascii
      
      call mudarlinha
      
      mov bl, 1111b ; Cor Branco 
      mov bh, 0  ; Numero de Pagina
      mov cx, 9 ; Numero de Caracteres    
      lea bp, c10          
      call printstringg
      
      xor ax,ax
      mov al,[si+4]
      call numeroparaascii
      mov dl, 9
      call imprimirnumeroascii
      
      ;set cursor
      mov ah, 2 
      mov dl, 16
      mov bh,0
      int 10h
      
      
      mov bl, 1111b ; Cor Branco 
      mov bh, 0  ; Numero de Pagina
      mov cx, 8 ; Numero de Caracteres    
      lea bp, c5          
      call printstringg
      
      xor ax,ax
      mov al,[si+5]
      call numeroparaascii
      mov dl, 24
      call imprimirnumeroascii
         
      call mudarlinha
      
      call inccursor 
      
      mov bl, 1111b ; Cor Branco 
      mov bh, 0  ; Numero de Pagina
      mov cx, 8 ; Numero de Caracteres    
      lea bp, c2          
      call printstringg
      
      xor ax,ax
      mov al,[si+6]
      call numeroparaascii
      mov dl, 9
      call imprimirnumeroascii
      
      ;set cursor
      mov ah, 2 
      mov dl, 17
      mov bh,0
      int 10h
      
      
      mov bl, 1111b ; Cor Branco 
      mov bh, 0  ; Numero de Pagina
      mov cx, 8 ; Numero de Caracteres    
      lea bp, c1          
      call printstringg
      
      xor ax,ax
      mov al,[si+7]
      call numeroparaascii
      mov dl, 24
      call imprimirnumeroascii
      
       looprato3: 
          mov ax, 3
          int 33h
          
          cmp bx, 2
          je inicio
          jmp looprato3
          ret 
          endp          
;::::::::::::::::::::::::::::::::::::::::
    ;ABOUT (sem pre condicoes)
    
    about proc
        mov al, 13h
        mov ah, 0 
        int 10h
        
        xor ah, ah
        int 10h 
        
        ;:::TITULO:::
        mov bl, 1111b ; Cor Branco 
        mov bh, 0  ; Numero de Pagina
        mov cx, 32 ; Numero de Caracteres    
        mov dl,5  ; coluna
        mov dh,2  ;linha
        lea bp, nome3             
        call printstringg   
    
        ;FABIO
        mov cx,24  ; Numero de Caracteres    
        mov dl,2  ; coluna
        mov dh, 5 ;linha
        lea bp, nome1             
        call printstringg
              
        ;RAFA      
        mov cx, 20 ; Numero de Caracteres    
        mov dl,2  ; coluna
        mov dh,7  ;linha
        lea bp, nome2             
        call printstringg
        
        looprato4: 
        mov ax, 3 
        int 33h
        
        cmp bx, 2
        je backmenu
        jmp looprato4
        endp
          
;:::::::::::::::::::::::::::::::::::     
        
    ;PRINTSTRINGG (String grafica)
     
    ;mov bp, offset msg1    
    ;mov cx, msg1end - offset msg1 ; calculate message size., 
    ;podemospor as strings todas com o mesmo tamanhao por exemplo 30 e fixamos o cx? falar com fabio
 
    
    printstringg proc   ;grafico,
    
        mov al, 1 ; write
        mov ah, 13h
        int 10h
        ret

    endp

;::::::::::::::::::::::::::::::::::

 ;printstring (normal)
 ;mov dx, offset string   
  printstring proc    
    mov ah, 9  
    int 21h
    ret
  endp

;:::::::::::::::::::::::::::::::::::::::::::::::::::::::::.    
     
     
     ;CALCULAR PERIODOS
        ;pre:
        ;vetor hora (atual)
        ;vetor cardstime (atual)
        
        ;result:
        ;ax=numeroperiodos
        
     calcularperiodos proc   
        mov si, offset horaactual 
        xor ax, ax
        mov al, [si]
        mov bl, 60 
        mul bl
        xor bh,bh
        mov bx, [si+1]
        xor bh,bh 
        add ax,bx
        mov horamin1, ax
        
        mov si, offset cardtime
        xor ax, ax
        mov al, [si]
        mov bl, 60 
        mul bl
        xor bx, bx
        mov bx, [si+1] ;[si+1] tras residuos
        xor bh,bh     ;precisa-se de fazer soma com carryy
        add ax, bx
        mov horamin2, ax 
        
        cmp ax, horamin1
        ja tamal
        continuacoin:
        mov ax, horamin2
        sub horamin1, ax
        ;horamin1 numero de minutos 
        mov ax, horamin1
        
        xor dx,dx
        xor bx,bx 
        mov bl, 15
        div bx     ;periodosinteiros ax
                   ;resto dx
        cmp dx, 0
        je tempocerto
        inc ax
        ret
        
        tempocerto:
        cmp ax, 0 
        je zeroincrementa
        ret
        
        zeroincrementa:     ;mesmo que entre e saia do parque tem de pagar
        inc ax
        ret
        
        tamal:
        xor ax,ax
        add horamin1, 1440
        jmp continuacoin
        endp     
 ;::::::::::::::::::::::::::::::::::::       
      ;AMOUNT DUE
        ;pre:
        ;al=numeroperiodos
        ;bl=preco por periodo
        
        ;result:
        ;ax=preco em centimos
        ;amountduei=preco inteiro
        ;amountdued=preco decimal
        
       amountdue proc
         mul bl
         ;ax=preco em centimos
         mov bl, 100
         xor dx,dx
         div bx
         mov amountduei,0
         mov amountdued,0
         mov amountduei, ax
         mov amountdued, dx   
         ret
       endp 
       
 ;:::::::::::::::::::::::::::::::::::
      ;SOMAR VETOR MOEDAS
        ;pre:
        ;si=offset vetor
        
        ;result:
        ;caixai=valor inteiro
        ;caixad=valor decimal
        
        
        somarvetormoedas proc 
     ;____moedas2e____
 mov al, [si] ;numero de moedas2e 
 mov bl, 2
 mul bl
 mov caixai, ax ;caixa inteira= moedas2e*2
;____moedas1e____ 
 mov ax, 0 ;limpa ax
 mov al, [si+1] ;numero de moedas1e para ax
 add caixai, ax ;total inteiros
;____moedas50c___ 
 mov ax,0
 mov al, [si+2]  ;mete al o numero de moedas 50cent
 mov bl, 50
 mul bl        ;valor ax= valor cent 
 mov caixad, ax
;____moedas20c___
 mov ax,0
 mov al, [si+3]
 mov bl, 20
 mul bl
 add caixad, ax
;___moedas10c___ 
 mov ax, 0
 mov al, [si+4]
 mov bl, 10 
 mul bl
 add caixad, ax
;___moedas5c___
 mov ax,0
 mov al, [si+5]
 mov bl, 5
 mul bl
 add caixad, ax
;___moedas2c___
 mov ax,0 
 mov al, [si+6]
 mov bl, 2
 mul bl
 add caixad, ax
;___moeda1c___
 mov ax,0 
 mov al, [si+7]
 add caixad, ax

;___comparar centimos com 100___ 
 cmp caixad, 99
 ja mais100cent
 return:
 jmp final
 
 mais100cent:
   inc caixai ;incrementa 1e na caixa inteiro
   sub caixad, 100
   cmp caixad, 100
   ja mais100cent
   jmp return
  
  final:
  ret
endp     
;::::::::::::::::::::::::::::::::::

;::::::::::::::::::::::::::::::::::
 ;TRIANGULO (escreve ambos os triangulos)
      triangulo proc
   
    mov ah, 0Ch
    mov al, 0010b 
    mov bx, 210 ;valor final
    mov dx, 80h
    tri23:
    mov cx, 220 ;valor central
    cmp bx, cx
    je topo1
    
    tri13:
    dec cx
    int 10h
    cmp cx, bx
    je sairtri 
    jmp tri13
    
    sairtri: 
    inc bx
    dec dx
    jmp tri23
   ;:::::::::::::::::: parte1 verde 
    topo1:
    mov bx, 230
    mov dx, 80h
    topo:
    mov cx, 219
    cmp bx, cx 
    je pronto
    
    tri33: 
    inc cx
    int 10h
    cmp cx, bx
    je sairtri1
    jmp tri33
    
    sairtri1:
    dec bx
    dec dx
    jmp topo
 ;:::::::::::::::::parte 2verde  
    pronto:
    
    mov ah, 0Ch
    mov al, 0100b 
    mov bx, 210 ;valor base
    mov dx, 85h
    
    tri223:
    mov cx, 220
    cmp bx, cx 
    je topo12 
    
    tri123:
    dec cx
    int 10h
    cmp cx, bx
    je sairtri121 
    jmp tri123
    
    sairtri121: 
    inc bx
    inc dx
    jmp tri223
    
    topo12:
    mov bx, 230
    mov dx, 85h 
    
    topo2:
    mov cx, 219
    cmp bx, cx 
    je pronto12
    
    tri323: 
    inc cx
    int 10h
    cmp cx, bx
    je sairtri122
    jmp tri323 
    
    sairtri122:
    dec bx
    inc dx
    jmp topo2
    
    pronto12:
    ret
    endp
    



;::::::::::::::::::::::::::::::::::

    ;COINS
    coins proc 
           
        
          
          
          
          call triangulo
          
          
         ;QUADRADO OK:::::::: 
          mov bl, 00100000b ; fundo verde 
          mov bh, 0  ; Numero de Pagina
          mov cx, 8 ; Numero de Caracteres    
          mov dl,30  ; coluna
          mov dh,14  ;linha
          lea bp, limpalinha
          call printstringg 
          inc dh
          call printstringg
          inc dh
          mov bl,00101111b
          lea bp, ok 
          call printstringg
          lea bp, limpalinha
          inc dh 
          call printstringg 
          inc dh 
          call printstringg
         ;:::::::::::::::::::: 
         
          mov bl, 1111b ; fundo verde 
          mov bh,0  ; Numero de Pagina
          mov cx,16 ; Numero de Caracteres    
          mov dl,2  ; coluna
          mov dh,16  ;linha
          lea bp, numbercoins
          call printstringg
             
          
          startcoin:
          mov bl, 1111b ; Cor Branco
          mov bh, 0  ; Numero de Pagina
          mov cx,6  ; Numero de Caracteres    
          mov dl, 0  ; coluna
          mov dh,6  ;linha
          lea bp,  coins0
          call printstringg
          
          mov bl, 1111b ; Cor Branco
          mov bh, 0  ; Numero de Pagina
          mov cx,6  ; Numero de Caracteres    
          mov dl, 0  ; coluna
          mov dh,7  ;linha
          lea bp,  edois
          call printstringg
          
          mov bl, 1111b ; Cor Branco
          mov bh, 0  ; Numero de Pagina
          mov cx,6  ; Numero de Caracteres    
          mov dl, 7  ; coluna
          mov dh,7  ;linha
          lea bp,  eum
          call printstringg
          
          mov bl, 1111b ; Cor Branco
          mov bh, 0  ; Numero de Pagina
          mov cx,8  ; Numero de Caracteres    
          mov dl, 14  ; coluna
          mov dh,7  ;linha
          lea bp,  ccinquente
          call printstringg 
          
          mov bl, 1111b ; Cor Branco
          mov bh, 0  ; Numero de Pagina
          mov cx,8  ; Numero de Caracteres    
          mov dl, 23  ; coluna
          mov dh,7  ;linha
          lea bp,  cvinte
          call printstringg  
          
          mov bl, 1111b ; Cor Branco
          mov bh, 0  ; Numero de Pagina
          mov cx,8  ; Numero de Caracteres    
          mov dl, 0  ; coluna
          mov dh,8  ;linha
          lea bp,  cdez
          call printstringg
          
          mov bl, 1111b ; Cor Branco
          mov bh, 0  ; Numero de Pagina
          mov cx,7  ; Numero de Caracteres    
          mov dl, 9  ; coluna
          mov dh,8  ;linha
          lea bp,  ccinco
          call printstringg
              
          mov bl, 1111b ; Cor Branco
          mov bh, 0  ; Numero de Pagina
          mov cx,7  ; Numero de Caracteres    
          mov dl, 17  ; coluna
          mov dh,8  ;linha
          lea bp,  cdois
          call printstringg 
          
          mov bh, 0  ; Numero de Pagina
          mov cx,6  ; Numero de Caracteres    
          mov dl, 25  ; coluna
          mov dh,8  ;linha
          lea bp,  cum
          call printstringg 
          
          
          xor ax,ax    ;mouse inicialization
          int 33h
   
          loopratocoin:
          mov ax, 2    ;limpa rasto do rato
          int 33h
          mov ax, 3
          int 33h
         
          cmp bx, 1      ;butao esquerdo 
          je verposicaocoin
          jmp loopratocoin 
          
          verposicaocoin:
          
          
          cmp dx, 35h
          jb loopratocoin
          cmp dx, 49h
          ja loopratocoin
          cmp cx, 496
          ja loopratocoin
          cmp dx, 63
          jb cima
          cmp cx, 86
          jb cc10
          cmp cx, 102h
          jb cc5
          cmp cx, 188h
          jb cc2
          
          ;se chegou aqui e 1c 
          
          mov bl, 1111_0000b
          mov bh, 0  ; Numero de Pagina
          mov cx,6  ; Numero de Caracteres    
          mov dl, 25  ; coluna
          mov dh,8  ;linha
          lea bp,  cum
          call printstringg
          mov si, offset coinsinput
          add si, 7
          call numeromoeda
          jmp startcoin 
          
          cc2:
         
          mov bl, 1111_0000b ; Cor Branco
          mov bh, 0  ; Numero de Pagina
          mov cx,7  ; Numero de Caracteres    
          mov dl, 17  ; coluna
          mov dh,8  ;linha
          lea bp,  cdois
          call printstringg
          mov si, offset coinsinput
          add si, 6
          call numeromoeda
          jmp startcoin 
          
          cc5:
          mov bl, 1111_0000b ; Cor Branco
          mov bh, 0  ; Numero de Pagina
          mov cx,7  ; Numero de Caracteres    
          mov dl, 9  ; coluna
          mov dh,8  ;linha
          lea bp,  ccinco
          call printstringg
          mov si, offset coinsinput
          add si, 5
          call numeromoeda
          jmp startcoin
          
          cc10:
          mov bl, 1111_0000b ; Cor Branco
          mov bh, 0  ; Numero de Pagina
          mov cx,8  ; Numero de Caracteres    
          mov dl, 0  ; coluna
          mov dh,8  ;linha
          lea bp,  cdez
          call printstringg
          mov si, offset coinsinput
          add si, 4
          call numeromoeda
          jmp startcoin 
          
          
          cima: 
          cmp cx, 100
          jna ee2
          cmp cx, 212
          jna ee1 
          cmp cx, 356
          jna cc50
          
          ;chegou aqui sao 20c
          
          mov bl, 1111_0000b ; Cor Branco
          mov bh, 0  ; Numero de Pagina
          mov cx,8  ; Numero de Caracteres    
          mov dl, 23  ; coluna
          mov dh,7  ;linha
          lea bp,  cvinte
          call printstringg
          mov si, offset coinsinput
          add si, 3
          call numeromoeda
          jmp startcoin
          
          
          
          ee2:
          
          mov bl, 1111_0000b ; Cor Branco
          mov bh, 0  ; Numero de Pagina
          mov cx,6  ; Numero de Caracteres    
          mov dl, 0  ; coluna
          mov dh,7  ;linha
          lea bp,  edois
          call printstringg
          mov si, offset coinsinput
          call numeromoeda
          jmp startcoin
           
          ee1:
          mov bl, 1111_0000b ; Cor Branco
          mov bh, 0  ; Numero de Pagina
          mov cx,6  ; Numero de Caracteres    
          mov dl, 7  ; coluna
          mov dh,7  ;linha
          lea bp,  eum
          call printstringg
          mov si, offset coinsinput
          inc si
          call numeromoeda
          jmp startcoin
          
          cc50:
         
          mov bl, 1111_0000b ; Cor Branco
          mov bh, 0  ; Numero de Pagina
          mov cx,8  ; Numero de Caracteres    
          mov dl, 14  ; coluna
          mov dh,7  ;linha
          lea bp,  ccinquente
          call printstringg
          mov si, offset coinsinput
          add si, 2
          call numeromoeda
          
          jmp startcoin
          
          troco:
          call comporvetortroco
          
        
        endp
;:::::::::::::::::::::::::::::::::::::
;::: TROCO

;:::::::::::::::::::::::::::::::
   ;AQUISICAO 1
   ;Soma vetor coinsinput ao vetor stock moedas (quando troco pronto)    
    aquisicao1 proc
    ;aquisicao das moedas no stock
    xor bx,bx
    continuaaquisicao:
    cmp bx, 7
    je aquisicaocompleta 
    mov si, offset coinsinput
    add si, bx
    mov al, [si]
    push si
    mov si, offset stockmoedas
    pop dx    ;este offset estraga stack
    xor dx,dx
    add si, bx
    add [si], al
    inc bx
    jmp continuaaquisicao
    
    aquisicaocompleta:
    ret
    endp
;:::::::::::::::::::::::::::::::::::::::::
   ;AQUISICAO 2
   ;Soma vetortroco ao vetor stock moedas quando o troco nao e possivel
   ;repoe troco no stock    
    aquisicao2 proc
    ;reaquisicao das moedas no stock
    xor bx,bx
    continuaaquisicao2:
    cmp bx, 7
    je aquisicaocompleta2 
    mov si, offset vetortroco
    add si, bx
    mov al, [si]
    push si
    mov si, offset stockmoedas
    pop dx    ;este offset estraga stack
    xor dx,dx
    add si, bx
    add [si], al
    inc bx
    jmp continuaaquisicao2
    
    aquisicaocompleta2:
    ret
    endp   
;:::::::::::::::::::::::::::::::::::::::::::::::::
   ;Procedimento que trata do troco
   ;pre
    ;caixai valor introduzido pelo cliente
    ;caixad valor introduzido pelo cliente
    ;amountduei valor em divida
    ;amountdued valor em divida
    
   ;resultado
    ;impressao do troco se este existir (pode imprimir 0 ou imprimir troco inteiro)
    ;se nao houver troco disponivel da salto para reentroduzir troco (nao perde coininput)
    
        
    comporvetortroco proc
    mov ax, amountduei 
    mov num1, ax
    mov ax, amountdued
    mov num2, ax    ;podem ser precisos se se reentruduzir moedas
  
    ;calcular diferenca em centimos
    xor ax,ax
    mov ax, caixai
    mov bl, 100
    mul bl
    mov caixai, ax
    ;caixai valor1
    mov ax, caixad
    add caixai, ax
    ;caixai valor introduzido cliente em centimos
    xor ax, ax
    mov ax, amountduei
    mov bl, 100
    mul bl
    add ax, amountdued
    mov amountduei, ax
    mov ax, caixai
    sub ax, amountduei
    mov dx,ax
    ;DX TEM O VALOR EM CENTIMOS
    
    cmp dx, 0
    je trocopronto
    
    mov cx,offset vetortroco ;vetor troco
    mov si,offset stockmoedas;vetor stock moedas
    
    
    coin2e:
    cmp [si], 0
    je coin1ee
    dec [si]     ;tira moeda 2e
    push si
    mov si, cx
    inc [si]     ;coloca moeda 2 no coinsinput
    pop si
    sub dx, 200  ;tira 200 centimos a dx
    
    cmp dx, 0    
    je trocopronto ;trocoestapronto
    jl repor2e     ;repor2e passar proxima moeda
    ja coin2e      ;retira-se mais 1 moeda 2e
    
    repor2e:
    inc [si]       ;incrementa 2e no coinstock (repor o que se tirou)
    push si
    mov si, cx
    dec [si]       ;decremente 2e no troco (tirar o que se meteu)
    pop si
    add dx, 200 
   ;:::::::::::::::::::::::::::::::::::::::::::fim troco 2 
    coin1ee:
    inc si         ;passa para proxima moeda
    inc cx
    
    coin1e:
    cmp [si], 0
    je coin50cc
    dec [si]     ;tira moeda 1e
    push si
    mov si, cx
    inc [si]     ;coloca moeda 1 no coinsinput
    pop si
    sub dx, 100  ;tira 100 centimos a dx 
    
    cmp dx, 0    
    je trocopronto ;trocoestapronto
    jl repor1e     ;repor2e passar proxima moeda
    ja coin1e      ;retira-se mais 1 moeda 2e
    
    repor1e:
    inc [si]       ;incrementa 2e no coinstock (repor o que se tirou)
    push si
    mov si, cx
    dec [si]       ;decremente 2e no troco (tirar o que se meteu)
    pop si
    add dx, 100 
  ;:::::::::::::::::::::::::::::::::::::::::::fim troco 1
  
    coin50cc:
    inc si         ;passa para proxima moeda
    inc cx
   
    coin50c: 
    cmp [si], 0
    je coin20cc
    dec [si]     ;tira moeda 1e
    push si
    mov si, cx
    inc [si]     ;coloca moeda 1 no coinsinput
    pop si
    sub dx, 50  ;tira 100 centimos a dx 
    
    cmp dx, 0    
    je trocopronto ;trocoestapronto
    jl repor50c     ;repor2e passar proxima moeda
    ja coin50c      ;retira-se mais 1 moeda 2e
    
    repor50c:
    inc [si]       ;incrementa 2e no coinstock (repor o que se tirou)
    push si
    mov si, cx
    dec [si]       ;decremente 2e no troco (tirar o que se meteu)
    pop si
    add dx, 50
  ;:::::::::::::::::::::::::::::::::::::::::::fim troco 20c 
   coin20cc:
    inc si         ;passa para proxima moeda
    inc cx
  
   coin20c:
    cmp [si], 0
    je coin10cc
    dec [si]     ;tira moeda 1e
    push si
    mov si, cx
    inc [si]     ;coloca moeda 1 no coinsinput
    pop si
    sub dx, 20  ;tira 100 centimos a dx 
    
    cmp dx, 0    
    je trocopronto ;trocoestapronto
    jl repor20c     ;repor2e passar proxima moeda
    ja coin20c      ;retira-se mais 1 moeda 2e
    
    repor20c:
    inc [si]       ;incrementa 2e no coinstock (repor o que se tirou)
    push si
    mov si, cx
    dec [si]       ;decremente 2e no troco (tirar o que se meteu)
    pop si
    add dx, 20 
  ;:::::::::::::::::::::::::::::::::::::::::::fim troco 20c
    coin10cc:
    inc si         ;passa para proxima moeda
    inc cx
 
    coin10c:
    cmp [si], 0
    je coin5cc
    dec [si]     ;tira moeda 1e
    push si
    mov si, cx
    inc [si]     ;coloca moeda 1 no coinsinput
    pop si
    sub dx, 10  ;tira 100 centimos a dx 
    
    cmp dx, 0    
    je trocopronto ;trocoestapronto
    jl repor10c     ;repor2e passar proxima moeda
    ja coin10c      ;retira-se mais 1 moeda 2e
    
    repor10c:
    inc [si]       ;incrementa 2e no coinstock (repor o que se tirou)
    push si
    mov si, cx
    dec [si]       ;decremente 2e no troco (tirar o que se meteu)
    pop si
    add dx, 10 
  ;:::::::::::::::::::::::::::::::::::::::::::fim troco 10c
  coin5cc:
    inc si         ;passa para proxima moeda
    inc cx
  
  coin5c:
    cmp [si], 0
    je coin2cc
    dec [si]     ;tira moeda 1e
    push si
    mov si, cx
    inc [si]     ;coloca moeda 1 no coinsinput
    pop si
    sub dx, 5  ;tira 100 centimos a dx 
    
    cmp dx, 0    
    je trocopronto ;trocoestapronto
    jl repor5c     ;repor2e passar proxima moeda
    ja coin5c      ;retira-se mais 1 moeda 2e
    
    repor5c:
    inc [si]       ;incrementa 2e no coinstock (repor o que se tirou)
    push si
    mov si, cx
    dec [si]       ;decremente 2e no troco (tirar o que se meteu)
    pop si
    add dx, 5 
   
  ;:::::::::::::::::::::::::::::::::::::::::::fim troco 10c
   coin2cc:
    inc si         ;passa para proxima moeda
    inc cx
   
   
   coin2c:
    cmp [si], 0
    je coin1cc
    dec [si]     ;tira moeda 1e
    push si
    mov si, cx
    inc [si]     ;coloca moeda 1 no coinsinput
    pop si
    sub dx, 2  ;tira 100 centimos a dx 
    
    cmp dx, 0    
    je trocopronto ;trocoestapronto
    jl repor2c     ;repor2e passar proxima moeda
    ja coin2c      ;retira-se mais 1 moeda 2e
    
    repor2c:
    inc [si]       ;incrementa 2e no coinstock (repor o que se tirou)
    push si
    mov si, cx
    dec [si]       ;decremente 2e no troco (tirar o que se meteu)
    pop si
    add dx, 2 
    inc si         ;passa para proxima moeda
    inc cx
  ;:::::::::::::::::::::::::::::::::::::::::::fim troco 10c
  coin1cc:
    inc si         ;passa para proxima moeda
    inc cx
 
  coin1c:
    cmp [si], 0
    je naohatroco
    dec [si]     ;tira moeda 1e
    push si
    mov si, cx
    inc [si]     ;coloca moeda 1 no coinsinput
    pop si
    sub dx, 1  ;tira 100 centimos a dx 
    
    cmp dx, 0    
    je trocopronto ;trocoestapronto
    jl repor1c     ;repor2e passar proxima moeda
    ja coin1c      ;retira-se mais 1 moeda 2e
    
    repor1c:
    inc [si]       ;incrementa 2e no coinstock (repor o que se tirou)
    push si
    mov si, cx
    dec [si]       ;decremente 2e no troco (tirar o que se meteu)
    pop si
    add dx, 1 
    inc si         ;passa para proxima moeda
    inc cx
  ;:::::::::::::::::::::::::::::::::::::::::::fim troco 10c
  
  cmp dx, 0
  jne naohatroco
  
  naohatroco: 
  ;somar vetor troco ao vetor moedas
  call aquisicao2
  ;voltar a pedir para colocar moedas
  ;REPETIR MOEDAS SEM PERDER COININPUT
  
  ;clean vetor troco 
  mov si, offset vetortroco
  call limparvetormoedas 
  mov si, offset coinsinput
  call limparvetormoedas
  ;limpar encran
  xor ah,ah   ;limpar ecran
  mov al, 13h
  int 10h
  
  call escrevernaohatroco
  mov ax, num1
  mov amountduei,ax
  mov ax, num2
  mov amountdued, ax
   
  jmp reeintruduzirmoedas
 
  
  trocopronto: 
  
  xor ah,ah   ;limpar ecran
  mov al, 13h
  int 10h
  
  
  ;somar vetor o coinsinput
  call aquisicao1
  mov si, offset vetortroco
  call somarvetormoedas
  call escrevetroco   
  ;clean vetor troco
  mov si, offset vetortroco
  call limparvetormoedas
  mov si, offset coinsinput
  call limparvetormoedas
  loopratotroco:
  mov ax, 3
  int 33h 
  cmp bx,2
  je printmenuinicial
  jmp loopratotroco
;:::::::::::::::::::::::::::
escrevernaohatroco proc
        mov bl, 1111b  
        mov bh, 0  ; Numero de Pagina
        mov cx, 19 ; Numero de Caracteres    
        mov dl,0  ; coluna
        mov dh,2  ;linha  
        lea bp, naohatroco1
        call printstringg
        
        mov bl, 1111b  
        mov bh, 0  ; Numero de Pagina
        mov cx, 28 ; Numero de Caracteres    
        mov dl,0  ; coluna
        mov dh,3  ;linha  
        lea bp, naohatroco2
        call printstringg
        ret
   
    endp


;:::::::::::::::::::::::::::::::::::::::
  escrevetroco proc  
        mov bl, 1111b  
        mov bh, 0  ; Numero de Pagina
        mov cx, 27 ; Numero de Caracteres    
        mov dl,0  ; coluna
        mov dh,2  ;linha  
        lea bp, business
        call printstringg
        
        mov bl, 1111b ; 
        mov bh, 0  ; Numero de Pagina
        mov cx, 14 ; Numero de Caracteres    
        mov dl,0  ; coluna
        mov dh,3  ;linha  
        lea bp, change
        call printstringg
        
       
        mov ax, caixai 
        call numeroparaascii
        mov dl, 15 ;start x
        mov dh, 3  ;start y
        call imprimirnumeroascii
        call inccursor
        
        mov ah, 0Ah
        mov al, ','
        mov bh, 0
        mov bl, 1111b
        mov cx, 1
        int 10h
        
        call inccursor
        
        
        mov ax, caixad
        call numeroparaascii
        mov bh,1 ;indicar que e centimo precisa de 0 direita
        call imprimirnumeroascii 
        
        call inccursor
        mov bl, 1111b ; Cor Branco 
        mov bh, 0  ; Numero de Pagina
        mov cx, 3 ; Numero de Caracteres    
        lea bp, eur            
        call printstringg
        
        call mudarlinha 
        mov bl, 1111b ; Cor Branco 
        mov bh, 0  ; Numero de Pagina
        mov cx, 3 ; Numero de Caracteres    
        lea bp, returning            
        call printstringg 
        
        call mudarlinha
        
      mov bl, 1111b ; Cor Branco 
      mov bh, 0  ; Numero de Pagina
      mov cx, 6 ; Numero de Caracteres    
      lea bp, e2            
      call printstringg
      
      mov si, offset vetortroco
      xor ax,ax
      mov al, [si] 
      
      
      call numeroparaascii
      mov dl, 7 ;start cursor
      call imprimirnumeroascii 
      
     ;set cursor
      mov ah, 2 
      mov dl, 18
      mov bh,0
      int 10h 
      
      mov bl, 1111b ; Cor Branco 
      mov bh, 0  ; Numero de Pagina
      mov cx, 6 ; Numero de Caracteres    
      lea bp, e1            
      call printstringg
      
      xor ax,ax
      mov al,[si+1]
      call numeroparaascii
      mov dl, 24
      call imprimirnumeroascii 
      
      call mudarlinha
      
      mov bl, 1111b ; Cor Branco 
      mov bh, 0  ; Numero de Pagina
      mov cx, 9 ; Numero de Caracteres    
      lea bp, c50          
      call printstringg
      
      xor ax,ax
      mov al,[si+2]
      call numeroparaascii
      mov dl, 9
      call imprimirnumeroascii
      
      ;set cursor
      mov ah, 2 
      mov dl, 15
      mov bh,0
      int 10h
      
      
      mov bl, 1111b ; Cor Branco 
      mov bh, 0  ; Numero de Pagina
      mov cx, 9 ; Numero de Caracteres    
      lea bp, c20          
      call printstringg
      
      xor ax,ax
      mov al,[si+3]
      call numeroparaascii
      mov dl, 24
      call imprimirnumeroascii
      
      call mudarlinha
      
      mov bl, 1111b ; Cor Branco 
      mov bh, 0  ; Numero de Pagina
      mov cx, 9 ; Numero de Caracteres    
      lea bp, c10          
      call printstringg
      
      xor ax,ax
      mov al,[si+4]
      call numeroparaascii
      mov dl, 9
      call imprimirnumeroascii
      
      ;set cursor
      mov ah, 2 
      mov dl, 16
      mov bh,0
      int 10h
      
      
      mov bl, 1111b ; Cor Branco 
      mov bh, 0  ; Numero de Pagina
      mov cx, 8 ; Numero de Caracteres    
      lea bp, c5          
      call printstringg
      
      xor ax,ax
      mov al,[si+5]
      call numeroparaascii
      mov dl, 24
      call imprimirnumeroascii
         
      call mudarlinha
      
      call inccursor 
      
      mov bl, 1111b ; Cor Branco 
      mov bh, 0  ; Numero de Pagina
      mov cx, 8 ; Numero de Caracteres    
      lea bp, c2          
      call printstringg
      
      xor ax,ax
      mov al,[si+6]
      call numeroparaascii
      mov dl, 9
      call imprimirnumeroascii
      
      ;set cursor
      mov ah, 2 
      mov dl, 17
      mov bh,0
      int 10h
      
      
      mov bl, 1111b ; Cor Branco 
      mov bh, 0  ; Numero de Pagina
      mov cx, 8 ; Numero de Caracteres    
      lea bp, c1          
      call printstringg
      
      xor ax,ax
      mov al,[si+7]
      call numeroparaascii
      mov dl, 24
      call imprimirnumeroascii
      
      
      ret  
      endp
    
  
;::::::::::::::::::::::::::::::::::::::
   ;mov si, offset vetor
   limparvetormoedas proc
        
        xor cl, cl
        continualimpa:
        cmp cl, 7
        je retlimpa
        mov [si],0
        inc si
        inc cl
        jmp continualimpa
        
        retlimpa:
        ret
      
     endp    
    
    
             
              



;:::::::::::::::::::::::::::::::
 ;NUMEROMOEDA
 
 numeromoeda proc
    
      mov bl, 1111b ; Cor Branco
      mov bh, 0  ; Numero de Pagina
      mov cx, 20 ; Numero de Caracteres    
      mov dl, 2  ; coluna
      mov dh,20  ;linha
      
      lea bp, accumulatedpay
      call printstringg
      
      mov bl, 1111b ; Cor Branco
      mov bh, 0  ; Numero de Pagina
      mov cx, 3 ; Numero de Caracteres    
      mov dl, 30  ; coluna
      mov dh,20  ;linha
      
      lea bp, eur
      call printstringg  
      
      
      
      atualizounum:
      
      
      ;set cursor position
      mov ah, 2
      mov dh, 16
      mov dl, 23
      mov bh,0
      int 10h

      xor ax,ax
      mov al, [si] 
      call numeroparaascii
      call imprimirnumeroascii
                              
      ;set cursor position
      mov ah, 2
      mov dh, 20
      mov dl, 24
      mov bh,0
      int 10h 
      
      push si
      mov si, offset coinsinput
      call somarvetormoedas
      mov ax, caixai
      call numeroparaascii
      call imprimirnumeroascii
      
      
      call inccursor
      mov ah,09h 
      mov al, ','
      mov bh, 0
      mov bl, 1111b
      mov cx,1
      int 10h
      call inccursor
      
      mov ax, caixad
      call numeroparaascii
      mov bh, 1
      call imprimirnumeroascii
      pop si
      
      xor ax,ax
      mov ax, amountduei
      cmp caixai, ax
      ja troco
      jb loopratonummoeda
      xor ax,ax
      mov ax, amountdued
      cmp caixad, ax
      ja troco 
      jb loopratonummoeda
      je troco
      
      
      
    loopratonummoeda:
          
          
          mov ax, 2    ;limpa rasto do rato
          int 33h
          mov ax, 3
          int 33h
         
          cmp bx, 1      ;butao esquerdo 
          je verposicaonummoeda
          jmp loopratonummoeda 
          
          verposicaonummoeda:
          cmp dx, 77h
          jb loopratonummoeda
          cmp dx, 142
          ja loopratonummoeda
          cmp cx, 422
          jb loopratonummoeda
          cmp cx, 458
          ja verificaquad
          cmp dx, 80h
          jb verde
          
          cmp [si], 0
          je loopratonummoeda
          dec [si]
          jmp atualizounum
          
          
          verde:
          inc [si]
          jmp atualizounum 
          
          
          verificaquad:
          cmp cx,478
          jb loopratonummoeda
          cmp cx, 606
          ja loopratonummoeda
          
          ;estamos dentro quadrado
          ;set cursor position
        
          mov dh, 16
          mov dl, 23
          mov bl, 1111b ; Cor Branco 
          mov bh, 0  ; Numero de Pagina
          mov cx, 3 ; Numero de Caracteres    
          lea bp, limpalinha          
          call printstringg
          
          jmp startcoin
          ret
    
    endp
    
    

 ;::::::::::::::::::::::::::::
    ;ABRIR FICHEIRO MOEDAS
           
           ;result: Coloca no Stockmoedas, moedas do ficheiro
           
           lermoedas proc
           ;____ABRIR FICHEIRO STOCK____  
             mov al, 2
             mov dx, offset stock ;file name
             mov ah, 3dh
             int 21h
             mov handle, ax
           ;____LER FICHEIRO E METER NO VETOR TEMP___
             mov bx, handle
             mov cx, 200
             mov ah, 3Fh
             mov dx, offset temp
             int 21h
    
           ;____FECHAR FICHEIRO
             mov ah, 3Eh
             int 21h 
             
              
          mov bl, 1111b
          mov ch, 0 
          mov cx, 26
          mov dl, 4
          mov dh, 5 
          lea bp, aguarde
          call printstringg   
     
          mov dx, 0 ;counter
          mov si, offset temp
          prox: 
          mov bl, [si]
          cmp bl, 0      
          je rett 
          inc si 
          cmp bl, ':' 
          je segundonum
          call verificarnumero
          cmp al, 1
          je numero
          cmp al, 0 
          je prox
           
          numero: 
            call asciiparanumero ;transforma numero ascii para numero decimal
            push si   ;guarda si 
            mov si, offset tempnum1 
            add si, dx
            mov [si], bl 
            inc dx
            pop si
            jmp prox
            
           segundonum:
            cmp dx, 0     ;nao foi lido nenhum numero antes dos ':'
            je prox
            mov num1, dx   ;num1 numero de numeros do temp1         
            mov dx, 0
            prox2:
            
            mov bl, [si]      
            
            call verificarnumero
            cmp al, 0
            je deucarry       ;verifica se deu carry
            
            
            ;call verificarnumero   ;verifica se e numero
            ;cmp al, 0
            ;je prox1 ;nao e numero reenicia tudo
            
            push si        ;guarda endereco da posicao temp
            mov si, offset tempnum2
            add si, dx                   ;escolhe posicao corret do tempnum2
            call asciiparanumero         ;transforma ascii em decimal
            mov [si],bl                  ;move decimal para tempnum2
            pop si 
            inc si 
            inc dx 
            jmp prox2
                     
             
            prox1: 
            mov dx, 0
            jmp prox
           
           
            deucarry:
            cmp num1, 1       ;verifica se temos 2 numeros
            jb  prox1         ;se nao temos 2 numeros arranca para proximo
            cmp dx, 1
            jb prox1
            mov num2, dx      ;temos tempnum1 com valores decimais
            
                              ;temos tempnum2 com valores decimais
                              ;num1 /valores tempnum1 
                              ;num2 /vlores tempnum2
            ;TRANSFORMAR numeros decimais individuais num conjunto
           
            push si
            mov si, offset tempnum1
            mov ch, 0
            cmp num1, 1
            je uno
            cmp num1, 2
            je duo
            cmp num1, 3
            je tri
            cmp num1, 4
            je quad
            
            uno: 
            mov al, [si]
            cmp ch,1
            je segund
            mov num1, ax
            jmp tmp2
            segund:
            mov num2, ax
            jmp frente
            
            duo: 
            mov al, [si]
            mov bl, 10
            mul bl
            add al, [si+1]
            cmp ch,1
            je segund1
            mov num1, ax
            jmp tmp2
            segund1:
            mov num2, ax
            jmp frente
            
            tri: 
            mov al, [si]
            mov bl, 100
            mul bl
            mov cl, al
            mov al,[si+1]
            mov bl, 10
            mul bl
            add cl, al
            mov al, [si+2]
            add cl, al
            mov al, cl
            cmp ch,1
            je segund2
            mov num1, ax
            jmp tmp2
            segund2:
            mov num2, ax
            jmp frente
            
            
            quad: 
            mov al, [si]
            mov bx, 1000
            mul bl
            mov cl, al
            mov al,[si+1]
            mov bl, 100
            mul bl
            add cl, al
            mov al, [si+2]
            mov bl, 10
            mul bl
            add cl,al
            mov al, [si+3]
            add cl, al
            mov al, cl
            cmp ch, 1
            je segund3
            mov num1, ax
            jmp tmp2
            segund3:
            mov num2, ax
            jmp frente
            
            tmp2:
            mov si, offset tempnum2
            mov ch,1
            cmp num2, 1
            je uno
            cmp num2, 2
            je duo
            cmp num2, 3
            je tri
            cmp num2,  4
            je quad
           
            
            frente: 
            mov bx, offset stockmoedas 
            mov si, offset stockmoedas
            
            cmp num1, 1
            je h
            cmp num1, 2
            je hh
            cmp num1, 5
            je hhh
            cmp num1, 10
            je hhhh
            cmp num1, 20
            je hhhhh 
            cmp num1, 50
            je hhhhhh
            cmp num1, 100
            je hhhhhhh
            cmp num1, 200
            je hhhhhhhh
            jmp ex
            
            
             
            h:   
            mov ax, num2
            add [si+7], al
            jmp ex
            
            hh:
            mov ax, num2
            add [si+6], al
            jmp ex
            
            hhh:
            mov ax, num2
            add [si+5], al
            jmp ex
            
            hhhh:
            mov ax, num2
            add [si+4], al
            jmp ex
            
            hhhhh: 
            mov ax, num2
            add [si+3], al
            jmp ex
            
            hhhhhh:
            mov ax, num2 
            add [si+2], al 
            jmp ex
            
            hhhhhhh:
            mov ax, num2
            add [si+1], al
            jmp ex 
            
            hhhhhhhh:
            mov ax, num2
            add [si], al
            jmp ex
            
            
            ex: 
            pop si
            mov dx, 0
            jmp prox 
            rett:
            ret 
            endp
       
  ;:::::::::::::::::::::::::::::::::::
    ;VERIFICAR NUMERO 
     ;pre:
        ;mov bl, char a testar
     ;res: 
        ;al=1 se for num
        ;al=0 se nao for num
     
     verificarnumero proc
         cmp bl, 48
         jb nao
         cmp bl, 57
         ja nao 
         mov al, 1
         ret
         nao: 
         mov al, 0
         ret
     endp 
     
   ;:::::::::::::::::::::::::::::::::::
    ;ASCII PARA NUMERO 
    ;pre
     ;mov bl, numero em ascii
    asciiparanumero proc
        sub bl, 48 
        ret
    endp
    
   ;:::::::::::::::::::::::::::::::::::
     ;NUMERO PARA ASCII
     ;pre
      ;mover numero para ax
     ;res          (500)
      ;ah numero1  (5)
      ;al numero2  (0)
      ;bl numero3  (0)
      
      ;indicador de dezenas cl
      ;se cl 3 (considerar ah, al, bl)
      ;se cl 2 (considerar al, bl)
      ;se cl 1 (considerar bl)
   numeroparaascii proc    
      mov bl, 10      ;ex bh=0 bl=5
      div bl
      cmp al, 0
      je zero
      cmp al, 9 ;dividendo
      ja carry
      add al, 48
      mov bl, ah
      add bl, 48
      
      mov cl, 2 ;indicador de 2num
      ret
      
      zero:      ; (dividendo 0)
      mov cl, 1  
      mov bl, ah
      add bl, 48 
      ret      
      
      carry:
      push ax
      mov bl, 10 
      xor ah, ah
      div bl
      add al, 48
      add ah, 48
      mov cl, ah
      mov ch, al
      pop ax
      mov bl, ah
      add bl, 48 
      mov ah,ch
      mov al, cl     ;653 (ah=6/al=5/bl=3 (+48 ascii)
      mov cl, 3 ;(cl 0 indica 3 numeros ;prontos a imprimir
      ret
      
      endp
   ;::::::::::::::::::::::::::::::::::::
     ;IMPRIMIR NUMERO ASCII
     ;pre 
       ;numeros (500) = ah=5/al=0/bl=0
       ;indicador cl=1/2/3
       ;dl start x
       ;dh start y
       ;bh condicao centimos (se estamos a falar de centimos 0 a direita (3,"0"3  Eur)
       
     ;resultado
     ;escreve na posicao do cursor numero correspondente
      
     imprimirnumeroascii proc
        push ax
        push bx
        push cx
        
        ;set cursor
        mov ah, 2
        ;dl pre cond
        mov bh,0
        int 10h 
        
        pop cx
        pop bx
        pop ax 
        push ax 
        push bx
        push cx
        
        
        cmp cl, 1
        je uni 
        cmp cl, 2
        je dez  
      
        
        mov al, ah ;caracter 
        mov ah, 09h
        mov bh, 0  ;numerop pagina
        mov bl, 1111b ;cor branca
        mov cx, 1
        int 10h 
        call inccursor
        dez:
        pop cx
        pop bx
        pop ax
        push ax
        push bx
        push cx
        
        
        mov ah, 09h
        mov bh, 0     ;numpag
        mov bl, 1111b ;corbranca 
        mov cx, 1
        int 10h
        
        call inccursor 
        
        uni:
        pop cx
        pop bx 
        pop ax 
        push ax
        push bx
        push cx
        
        cmp bh, 0  ;estamos a falar centimos se for 1 
        je naocent
        cmp cl,2
        je naocent ;se numero tiver dois nao vale a pena tar meter 0 esquerda
        mov ah, 09h
        mov al, 48
        mov bh, 0 
        mov bl, 1111b
        mov cx, 1
        int 10h 
        
        call inccursor 
        
        naocent: 
        pop cx
        pop bx
        pop ax
        mov ah, 09h
        mov al, bl
        mov bh, 0 
        mov bl, 1111b
        mov cx, 1
        int 10h
        
        ret
        endp  
  ;::::::::::::::::::::::::::::::::::
    ;MUDARLINHA
    ;sem precondicoes muda linha caracter
    
    mudarlinha proc 
        mov ah, 2
        inc dh 
        mov dl,0
        mov bh,0
        int 10h 
       
       ret
     endp 
  ;:::::::::::::::::::::::::::::::::
    ;INC CURSOR
    inccursor proc
        mov ah, 2
        inc dl
        mov bh, 0 
        int 10h
        ret
    endp 
    
    ;DEC CURSOR
    deccursor proc
        mov ah, 2
        dec dl
        mov bh, 0 
        int 10h
        ret
        endp
   
  ;:::::::::::::::::::::::::::::::
   ;PRINTHORA
   
   printhora proc 
      mov ah, 2Ch     ;interrupt get system time
      int 21h
     
      mov [si], ch
      mov [si+1], cl 
      mov [si+2], dh
      
      mov bl, 1111b
      mov ch, 0 
      mov cx, 15
      mov dl, 0
      mov dh, 0 
      lea bp, ctimes
      call printstringg 
      
    xor bh, bh  

    mov si, offset horaactual
    xor ah, ah
    mov al, [si]
    call numeroparaascii ;ex 50 bh=num1 bl=num2     
    mov dl,15  
    mov bh,1
    call imprimirnumeroascii
    
    call inccursor
    mov ah, 09h
    mov al, 58 
    mov bh, 0 
    mov bl, 1111b
    mov cx, 1 
    int 10h
    
    
    
    
    call inccursor
    xor ah, ah 
    mov al,[si+1]
    call numeroparaascii
    mov bh, 1 ;indicar que precisa de 0 a esquerda
    call imprimirnumeroascii
    
    call inccursor
    mov ah, 09h
    mov al, 58
    mov bh, 0 
    mov bl, 1111b
    mov cx, 1  
    int 10h 
    
    call inccursor
    xor ah, ah
    mov al, [si+2]
    call numeroparaascii
    mov bh, 1
    call imprimirnumeroascii
    ret
    endp
;:::::::::::::::::::::::::::::::::::::::::
   ;CARDSTIME___________
   
   cardstime proc
       
        repetetudo:
        mov bl, 1111b ; Cor Branco
        mov bh, 0  ; Numero de Pagina
        mov cx,18  ; Numero de Caracteres    
        mov dl, 0  ; coluna
        mov dh,2  ;linha
        lea bp, insertcardtime  ; mov bp, offset insertcardtime
        call printstringg
        
        
        
        
        ;read cursor
        repete:
        
        
        ;set cursor position
        mov ah, 2h
        mov dh, 2
        mov dl, 20 
        mov bh, 0 
        int 10h
        
        mov ah, 1
        int 21h
        
        cmp al, '0'
        jb repete
        cmp al, '2'
        ja repete
        
        mov ah, 2h 
        mov dh, 2
        mov dl, 20
        mov bh, 0 
        int 10h
        
        mov ah, 09h
        mov bl, 1111b
        mov cx, 1 
        int 10h
        
        mov tempnum1, al
        call inccursor
       
        
         
        repete1: 
        ;set cursor
        mov ah, 2
        mov dl, 21
        mov bh, 0 
        int 10h
        
        mov ah, 1
        int 21h 
        
        
        cmp al, '0'
        jb repete1
        cmp tempnum1, '2'
        jne naoe2
        cmp al, '3'
        ja repete1
        
        naoe2:
        cmp al, '9'
        ja repete1 
        
        mov ah, 2h
        mov dh, 2
        mov dl, 21 
        mov bh, 0 
        int 10h
        
        mov ah, 09h
        mov bl, 1111b
        mov cx, 1 
        int 10h 
        
        mov tempnum2, al
        mov si, offset cardtime
        sub tempnum1, 48 ;passar para num
        sub tempnum2, 48
        mov al, tempnum1
        mov bl, 10 
        mul bl
        mov [si], al
        mov al, tempnum2
        add [si], al
        
                       
                       
        call inccursor
        mov al, ':' 
        mov ah, 09h
        int 10h
        
        repete2:
        mov ah, 2h
        mov dh, 2
        mov dl, 23 
        mov bh, 0 
        int 10h
        
        mov ah, 1
        int 21h
        
        cmp al, '0'
        jb repete2
        cmp al, '5'
        ja repete2 
        
        mov ah, 2h
        mov dh, 2
        mov dl, 23 
        mov bh, 0 
        int 10h
        
        mov ah, 09h
        mov bl, 1111b
        mov cx, 1 
        int 10h  
        mov tempnum1, al
        
        
        repete3: 
        mov ah, 2h
        mov dh, 2
        mov dl, 24 
        mov bh, 0 
        int 10h
        
        mov ah, 1
        int 21h
        
        cmp al, '0'
        jb repete3
        cmp al, '9'
        ja repete3
        
        mov ah, 2h
        mov dh, 2
        mov dl, 24 
        mov bh, 0 
        int 10h
        
        
        mov ah, 09h
        mov bl, 1111b
        mov cx, 1 
        int 10h
        mov tempnum2, al
        
   
        mov si, offset cardtime
        sub tempnum1, 48 ;passar para num
        sub tempnum2, 48
        mov al, tempnum1
        mov bl, 10 
        mul bl       
        mov [si+1], al
        mov al, tempnum2
        add [si+1], al 
        
        mov bl, 1111b ; Cor Branco
        mov bh, 0  ; Numero de Pagina
        mov cx,30  ; Numero de Caracteres    
        mov dl,3  ; coluna
        mov dh,4  ;linha
        lea bp, horaints  ; mov bp, offset insertcardtime
        call printstringg 
        
        
        mov bl, 0010b ; Cor VERDE
        mov bh, 0  ; Numero de Pagina
        mov cx,3  ; Numero de Caracteres    
        mov dl,9  ; coluna
        mov dh,6  ;linha
        lea bp, sim  ; mov bp, offset insertcardtime
        call printstringg
        
        
        mov bl, 0100b ; Cor VERMELHA
        mov bh, 0  ; Numero de Pagina
        mov cx,3  ; Numero de Caracteres    
        mov dl,19  ; coluna
        mov dh,6  ;linha
        lea bp, nao1  ; mov bp, offset insertcardtime
        call printstringg
        
        xor ax, ax 
        int 33h
        
        loopratocard:
        mov ax, 2
        int 33h      ;limpa rasto do rato
        
        mov ax, 3
        int 33h      ;status and position
         
        cmp bx, 1  ;left button
        je verposicaocard
        cmp bx, 2
        ;je backmenu
        jmp loopratocard 
        
        verposicaocard:
        cmp cx, 194
        ja talveznao
        cmp cx, 8Eh
        jb loopratocard
        cmp dx, 38h
        ja loopratocard
        cmp dx, 2Dh
        jb loopratocard
       
        ;chega aqui se selecionar sim
        ;CLEAN LINE
        mov bl, 1111b ; Cor Branco
        mov bh, 0  ; Numero de Pagina
        mov cx,34  ; Numero de Caracteres    
        mov dl,0  ; coluna
        mov dh,4  ;linha
        lea bp, limpalinha  ; mov bp, offset insertcardtime
        call printstringg
        
        mov bl, 1111b ; Cor Branco
        mov bh, 0  ; Numero de Pagina
        mov cx,30  ; Numero de Caracteres    
        mov dl,0  ; coluna
        mov dh,6  ;linha
        lea bp, limpalinha  ; mov bp, offset insertcardtime
        call printstringg 
        
        ret
         
        
        
        talveznao:
        cmp cx, 164h
        ja loopratocard
        cmp cx, 128h
        jb loopratocard
        cmp dx, 38h
        ja loopratocard
        cmp dx, 2Dh
        jb loopratocard
        
         
        limparepete: 
         
        mov bl, 1111b ; Cor Branco
        mov bh, 0  ; Numero de Pagina
        mov cx,34  ; Numero de Caracteres    
        mov dl,0  ; coluna
        mov dh,4  ;linha
        lea bp, limpalinha  ; mov bp, offset insertcardtime
        call printstringg
        
        mov bl, 1111b ; Cor Branco
        mov bh, 0  ; Numero de Pagina
        mov cx,30  ; Numero de Caracteres    
        mov dl,0  ; coluna
        mov dh,6  ;linha
        lea bp, limpalinha  ; mov bp, offset insertcardtime
        call printstringg
        
        
        mov bl, 1111b ; Cor Branco
        mov bh, 0  ; Numero de Pagina
        mov cx,30  ; Numero de Caracteres    
        mov dl,0  ; coluna
        mov dh,2  ;linha
        lea bp, limpalinha  ; mov bp, offset insertcardtime
        call printstringg
        
        
        jmp repetetudo
           
                      
        endp 
        
            
        
        
        imprimirnumeroasciif proc
        mov si, offset temp
       
        cmp cl, 1
        je unif
        cmp cl, 2
        je dezf 
        
        mov [si], ah
        mov [si+1], al
        mov [si+2], bl
        mov cx, 3
        ret
        
        dezf:
        mov [si], al
        mov [si+1],bl
        mov cx, 2
        ret
                    
        unif:
        cmp bh, 0 
        je naocentf
        mov [si], '0'
        mov [si+1],bl
        mov cx,2
        ret
        
        naocentf:
        mov [si], bl
        mov cx,1
        ret 
        endp
 
      
      mudarlinhaf proc
        mov si, offset temp
        mov [si], 13
        inc si
        mov [si], 10       
        mov ah, 40h
        mov dx, offset temp
        mov bx, handle
        mov cx, 2
        int 21h
        ret 
        
      endp
      
      
       escreverficheiro proc
        
        ;cria ficheiro contents se nao existe
        ;escreve por cima se existe
        mov ah, 3Ch
        mov cx, 0 
        mov dx, offset fcontents
        int 21h  
        mov handle, ax
        
        mov ah, 40h
        mov dx, offset totalmoney        
        mov cx, 30
        mov bx, handle
        int 21h 
        
        
        
        mov ax, caixai
        call numeroparaascii  ;ah numero1
                              ;al numero2
                              ;bl numero3
        
        ;condicao centimos bh=1
        ;cl indica 1 2 3 algarismos
        call imprimirnumeroasciif 
        ;coloca no temp o numero 
        ;coloca no cx quantidade numero
        mov ah, 40h
        mov dx, offset temp       
        mov bx, handle
        int 21h
        
        mov si, offset temp
        mov [si], ','
        mov ah, 40h
        mov dx, offset temp
        mov cx, 1
        mov bx, handle
        int 21h
        
        mov ax, caixad 
        call numeroparaascii
        mov bh,1 ;indicador cent
        call imprimirnumeroasciif
        
        mov ah, 40h
        mov dx, offset temp
        mov bx, handle
        int 21h
        
        mov ah, 40h
        mov dx, offset eur
        mov cx, 3 
        mov bx, handle
        int 21h 
        
        call mudarlinhaf
        
        mov ah, 40h
        mov dx, offset e2
        mov cx, 6 
        mov bx, handle
        int 21h
        
        mov si, offset stockmoedas
        mov al, [si]
        call numeroparaascii
        call imprimirnumeroasciif
        mov ah, 40h
        mov dx, offset temp 
        mov bx, handle
        int 21h
        
        mov cx, 4
        mov dx, offset limpalinha
        mov ah, 40h
        int 21h
        
        mov ah, 40h
        mov dx,offset e1 
        mov cx, 6
        mov bx, handle 
        int 21h
        
        mov si, offset stockmoedas
        mov al, [si+1]
        call numeroparaascii
        call imprimirnumeroasciif
        mov ah, 40h
        mov dx, offset temp 
        mov bx, handle
        int 21h 
        
        call mudarlinhaf
        
        mov ah, 40h
        mov dx,offset c50 
        mov cx, 9
        mov bx, handle 
        int 21h 
        mov si, offset stockmoedas 
        mov al, [si+2]
        call numeroparaascii
        call imprimirnumeroasciif
        mov ah, 40h 
        mov dx, offset temp
        mov bx, handle 
        int 21h
        
        mov cx, 2
        mov dx, offset limpalinha
        mov ah, 40h
        int 21h
        
        mov ah, 40h
        mov dx,offset c20 
        mov cx, 9
        mov bx, handle 
        int 21h
        
        mov si, offset stockmoedas  
        mov al, [si+3]
        call numeroparaascii
        call imprimirnumeroasciif
        mov ah, 40h 
        mov dx, offset temp
        mov bx, handle 
        int 21h
        
        
        call mudarlinhaf
        
        
        mov ah, 40h
        mov dx,offset c10 
        mov cx, 9
        mov bx, handle 
        int 21h
       
        mov si, offset stockmoedas  
        mov al, [si+4]
        call numeroparaascii
        call imprimirnumeroasciif
        mov ah, 40h 
        mov dx, offset temp
        mov bx, handle 
        int 21h
        
        mov cx, 2
        mov dx, offset limpalinha
        mov ah, 40h
        int 21h
        
        mov ah, 40h
        mov dx,offset c5 
        mov cx, 8
        mov bx, handle 
        int 21h  
       
        mov si, offset stockmoedas
        mov al, [si+5]
        call numeroparaascii
        call imprimirnumeroasciif
        mov ah, 40h 
        mov dx, offset temp
        mov bx, handle 
        int 21h
        
        call mudarlinhaf
        
        mov ah, 40h
        mov dx,offset c2 
        mov cx, 8
        mov bx, handle 
        int 21h  
        
        mov si, offset stockmoedas
        mov al, [si+6]
        call numeroparaascii
        call imprimirnumeroasciif
        mov ah, 40h 
        mov dx, offset temp
        mov bx, handle 
        int 21h
        
        mov cx, 2
        mov dx, offset limpalinha
        mov ah, 40h
        int 21h
        
        mov ah, 40h
        mov dx,offset c1 
        mov cx, 7
        mov bx, handle 
        int 21h  
        
        mov si, offset stockmoedas
        mov al, [si+7]
        call numeroparaascii
        call imprimirnumeroasciif
        mov ah, 40h 
        mov dx, offset temp
        mov bx, handle 
        int 21h
        ret
       
       endp 
        
       exit:
       call escreverficheiro
    
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
