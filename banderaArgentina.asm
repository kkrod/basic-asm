.model 
 
.data
    msg db "Argentina",13,10,"$"
 
.code
    .startup
 
        
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
 
    .exit
 
end
