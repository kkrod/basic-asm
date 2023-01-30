.model 
 
.data
    msg db "Espana",13,10,"$"
 
.code
    .startup
 
        
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
 
    .exit
 
end
