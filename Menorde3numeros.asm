org 100h ; Iniciando el Programa
include 'emu8086.inc'

jmp inicio 


;Declarando las Cadenas que serviran de Guia
msj1 db 13,10,13,10,"Numero1 : $"
msj2 db 13,10,13,10,"Numero2: $"
msj3 db 13,10,13,10, "Numero3: $"
msj4 db 13,10,"resultado: $"


;Declaracion de las variables
n1 dw ? 
n2 dw ?
n3 dw ?
resta dw ?

inicio:   
 
;Inicio del codigo 
.code  

;Preparando la consola
mov ah,09 
lea dx,msj1 
int 21h 


;Registro de numeros  
call SCAN_NUM 
mov n1,cx 

mov ah,09 
lea dx,msj2 
int 21h
call SCAN_NUM 
mov n2,cx 

mov ah,09 
lea dx,msj3
int 21h
call SCAN_NUM 
mov n3,cx 

          
;Buscando el menor de los 3 Numeros

mov ax, n1
mov bx, n2
mov cx, n3
 

cmp ax, bx
    jg esMayor
    js 1esMenor
    je igual 
    
    1esMenor:  
        cmp ax, cx
            jg esMayor
            js 1esMenor
            je igual 
            
       
   1esMenor:
        printn ""
        printn "........El Numero 1 Es el Menor........"  

   
                
    esMayor:
        printn ""
        
    igual:
        printn ""  
   
        
        
cmp bx, ax
    jg esMayor2
    js 1esMenor2
    je igual2 
    
    1esMenor2:  
        cmp bx, cx
            jg esMayor2
            js 1esMenor2
            je igual2 
            
       
   1esMenor2:
        printn ""
        printn "........El Numero 2 Es el Menor........"  

   
                
    esMayor2:
        printn ""
        
    igual2:          
        printn ""  
        
   
cmp cx, ax
    jg esMayor3
    js 1esMenor3
    je igual3 
    
    1esMenor3:  
        cmp cx, bx
            jg esMayor3
            js 1esMenor3
            je igual3 
            
       
   1esMenor3:
        printn ""
        printn "........El Numero 3 Es el Menor........"  

   
                
    esMayor3:
        printn ""
        
    igual3:
        printn ""



;Definicion de Modulos
DEFINE_SCAN_NUM
DEFINE_PRINT_STRING
DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS

ret




