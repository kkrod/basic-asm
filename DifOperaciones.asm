org 100h

include 'emu8086.inc'
DEFINE_SCAN_NUM
DEFINE_PRINT_STRING
DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS


.model small
.stack 100h
.data

; Mensajes de menu de orden de cadena
Struct0A EQU $
max db 100
got db 0
buf db 100 dup (0)
Linefeed db 13, 10, '$'
Cadena   db 'Introduzca la cadena a ordenar: $'
salto db 13,10, '$'
mensajeorden db  "La cadena ordenada es: $"


; Mensajes menu inicial
msg db 13, 10, "$"
op1 db "1 - Banderas", 13, 10
op2 db "2 - Caracter en pantalla", 13, 10
op3 db "3 - Operaciones matematicas", 13, 10
op4 db "4 - Ordenador alfabetico", 13, 10
op5 db "5 - Salir", 13, 10, "$"


; Mensajes de menu de operaciones matematicas
texto db 'numero 1: $'
texto1 db 13, 10, 'numero 2: $'
texto2 db 13, 10, 'Suma: $'
texto3 db 13, 10, 'Resta: $'
texto4 db 13, 10,'Multiplicacion: $'
texto5 db 13, 10,'Division: $'
numero1 dw ?
numero2 dw ?



; Mensajes de menu de Banderas
band db "Selecciona una bandea:", 13, 10, "$"
band1 db "1 - Argentina", 13, 10
band2 db "2 - Espana", 13, 10
band3 db "3 - Venezuela", 13, 10, "$"


.code
  mov ax, @data
  mov ds, ax
  jmp  inicio

limpiar:

  mov ax,0600h
  mov bh,07h    ;color
  mov cx,0000h  ;posicion ini
  mov dx, 193fh ;posicion final
  int 10h 
   
  pusha
  mov ah, 0x00
  mov al, 0x03   
  int 0x10    
  popa 
  
  ret

inicio:
    
  call limpiar
  
  
  ; Mostrar mensajes por pantalla
  lea dx, msg
  mov ah, 09h
  int 21h

  lea dx, op1
  mov ah, 09h
  int 21h



  ; Leer opcion igresada
  mov ah, 01h
  int 21h




  ; Hacer salto a porcion de codigo respectiva
  ;Banderas
  cmp al, 49
  je banderas

  ;Caracter
  cmp al, 50
  je caracter

  ;Operaciones
  cmp al, 51
  je operaciones

  ; Ordenador
  cmp al, 52
  je ordenador

  ;Salir
  cmp al, 53
  je exit


banderas:

    call limpiar
    mov ah,09
    lea dx, band
    int 21h

    lea dx, band1
    mov ah, 09h
    int 21h



    ; Leer opcion igresada
    mov ah, 01h
    int 21h


    cmp al, 49
    je argentina

    ;Caracter
    cmp al, 50
    je espana 

    ;Operaciones
    cmp al, 51
    je venezuela



    ; banderas

    argentina:
        ; Primera Franja (Azul)
        mov ax,0600h   
        mov bh,17h    ;color
        mov cx,0000h  ;posicion ini
        mov dx, 083fh ;posicion final
        int 10h
        
         ; Franja (blanco)
        mov ax,0600h
        mov bh,77h    ;color
        mov cx,0900h  ;posicion ini
        mov dx, 103fh ;posicion final
        int 10h        
                      
      
        ; Franja (Azul)
        mov ax,0600h
        mov bh,17h    ;color
        mov cx,1100h  ;posicion ini
        mov dx, 193fh ;posicion final
        int 10h
           
       
 
        ; Imprime el mensaje:
        mov dx, offset msg
        mov ah,9
        int 21h
 
        ; Evitar que se cierre sola la ventana DOS
        mov ax,0C07h
        int 21h

        jmp inicio
    espana:
        ; Primera Franja (amarilla)
        mov ax,0600h   
        mov bh,47h    ;color
        mov cx,0000h  ;posicion ini
        mov dx, 053fh ;posicion final
        int 10h
        
         ; Franja (rojo)
        mov ax,0600h
        mov bh,60h    ;color
        mov cx,0600h  ;posicion ini
        mov dx, 103fh ;posicion final
        int 10h        
                      
      
        ; Franja (amarilla)
        mov ax,0600h
        mov bh,47h    ;color
        mov cx,1100h  ;posicion ini
        mov dx, 163fh ;posicion final
        int 10h
           
       
 
        ; Imprime el mensaje:
        mov dx, offset msg
        mov ah,9
        int 21h
 
        ; Evitar que se cierre sola la ventana DOS
        mov ax,0C07h
        int 21h

        jmp inicio
    venezuela:

            ; Primera Franja (amarillas)
        mov ax,0600h
        mov bh,60h    ;color
        mov cx,0000h  ;posicion ini
        mov dx, 073fh ;posicion final
        int 10h
        
         ; Franja (azul)
        mov ax,0600h
        mov bh,97h    ;color
        mov cx,0800h  ;posicion ini
        mov dx, 103fh ;posicion final
        int 10h        
                      
      
        ; Franja (rojo)
        mov ax,0600h
        mov bh,47h    ;color
        mov cx,1100h  ;posicion ini
        mov dx, 183fh ;posicion final
        int 10h
           
       
 
        ; Imprime el mensaje:
        mov dx, offset msg
        mov ah,9
        int 21h
 
        ; Evitar que se cierre sola la ventana DOS
        mov ax,0C07h
        int 21h

        jmp inicio

caracter:  
    
    call limpiar
    mov  ah,05h
    mov  al,01h
    int  10h

    
    car    DB 0
    pox    DB 0
    poy    DB 0
    xa     DB 0
    ya     DB 0
    aviso DB 'Escriba un caracter y muevalo con las flechas: ','$'
          
          
      
     mov ax,@data
   mov ds,ax
   mov  ah,02h      ;
   mov  bh,00h
   mov  dh,5      ;fil
   mov  dl,5      ;col
   int  10h
   mov  ah,9
   mov  dx,OFFSET aviso
   int  21h
   mov  ah,01h
   int  21h
   mov  car,al
   mov  ah,03h
   mov  bh,00h
   int  10h
   mov  pox,ch
   mov  poy,dh
   dec  pox
   mov  ah,05h   ; borrar pantalla
   mov  al,01h
   int  10h
bucle:
   mov  ah,02h; ubicarse en la posicion anterior
   mov  bh,01h
   mov  dh,ya
   mov  dl,xa
   int  10h
   mov  ah,02h ; borrar el caracter
   mov  dl,32 ;
   int  21h
   mov  ah,02h; ubicar el cursor
   mov  bh,01h
   mov  dh,poy
   mov  dl,pox
   int  10h
   mov  ah,02h ; imprimir el caracter
   mov  dl,car
   int  21h
   mov  ah,02h ; colocar el cursor en su posicion anterior
   mov  bh,01h
   mov  dh,poy
   mov  dl,pox
   int  10h
   mov  xa,dl
   mov  ya,dh
   mov  ah,00h
   int  16h   ; interrup de teclado
   cmp  ah,75
   jnz  noleft
   dec  pox
   jmp  bucle
noleft:
   cmp  ah,72
   jnz  nodown
   dec  poy
   jmp  bucle
nodown:
   cmp  ah,77
   jnz  noright
   inc  pox
   jmp  bucle
noright:
   cmp  ah,80
   jnz  noup
   inc  poy
   jmp  bucle
noup:
   cmp  al,27
   jz   fin
   jmp  bucle
fin:
   mov  ah,4ch
   mov  al,00h
   int  21h  
   
   ; Evitar que se cierre sola la ventana DOS
        mov ax,0C07h
        int 21h

        jmp inicio  
   
   
operaciones:
    call limpiar
    mov  ah,05h
    mov  al,01h
    int  10h
    ; SUMA
    mov ah,09
    lea dx, texto
    int 21h

    call SCAN_NUM
    mov numero1,cx

    mov ah,09
    lea dx,texto1
    int 21h
    call SCAN_NUM
    mov numero2,cx

    mov ah,09
    lea dx,texto2
    int 21h
    mov ax,numero1
    add ax,numero2
    call PRINT_NUM

    ;RESTA

    mov ah,09
    lea dx,texto3
    int 21h
    mov ax,numero1
    sub ax,numero2
    call PRINT_NUM

    ;Multiplicacion

    mov ah,09
    lea dx,texto4
    int 21h
    mov ax,numero1
    mov bx,numero2
    mul bx
    call PRINT_NUM


    ;DIVISION

    mov ah,09
    lea dx,texto5
    int 21h
    xor dx,dx
    mov ax,numero1
    mov bx,numero2
    div bx
    call PRINT_NUM  
    
    ; Evitar que se cierre sola la ventana DOS
    mov ax,0C07h
    int 21h 
    
    jmp inicio

ordenador: 
    call limpiar
    mov  ah,05h
    mov  al,01h
    int  10h
    mov ax, @DATA    
    mov ds, ax
    ; Input String
    mov ah, 09h
    mov dx, OFFSET Cadena
    int 21h
    mov dx, OFFSET Struct0A
    mov ah, 0Ah
    INT 21h

    mov si, OFFSET buf
    xor bx, bx
    mov bl, got
    mov BYTE PTR [si + bx], '$'

    BucleExterno:
    dec bx
    jz FinCiclo
    mov cx, bx
    mov si, OFFSET buf
    xor dl, dl

    BucleInterno:
    mov ax, [si]
    cmp al, ah
    jl S1
    mov dl, 1
    xchg al, ah
    mov [si], ax
    S1:
    inc si
    loop BucleInterno

    test dl, dl
    jnz BucleExterno
    FinCiclo:
    ; Imprimir resultado
        mov dx, OFFSET salto
    call imprimir
        mov dx, OFFSET salto
    call imprimir
        mov dx, OFFSET mensajeorden
    call imprimir
        mov dx, OFFSET buf
    call imprimir 
    
      ; Evitar que se cierre sola la ventana DOS
        mov ax,0C07h
        int 21h

        jmp inicio
    
   ; jmp exit
    imprimir:
        mov ah, 9h
        int 21h
        ret
             
   

    

; Retornar el control al SO
exit:
  mov ah, 4ch
  int 21h
end