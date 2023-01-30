 org 100h ; inicio de programa

include 'emu8086.inc' ;Incluye funciones de libreria emu8086
DEFINE_SCAN_NUM
DEFINE_PRINT_STRING
DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS

jmp inicio ;salta a etiqueta inicio

texto db 13,10,' '
db 13,10,' '
db 13,10,13,10,'Digite el Primer Numero: $'
texto2 db 13,10,13,10,'Digite el Segundo Numero: $'
texto3 db 13,10,13,10, 'La Suma Es: $'
texto4 db 13,10,'La Resta Es: $'
texto5 db 13,10,'La Multiplicacion Es: $'
texto6 db 13,10,'La Dision es: $'

num1 dw ? ;defino variables de 2 bytes
num2 dw ? ; el simbolo ? es para indicar q no se inicilizan con valor algunp

inicio:

mov ah,09 ;instruccion para imprimir en pantalla
lea dx,texto ;carga cadena de texto 1 en dx
int 21h ;interrupcion pantalla

call SCAN_NUM ;Llama Funcion SCAN_NUM que toma numero de teclado; el valor se guarda en ax
mov num1,cx ;mueve numero a variable num1

mov ah,09 ;interrupcion para imprimir en pantalla
lea dx,texto2 ;carga cadena de texto 2 en dx
int 21h

call SCAN_NUM ;Llama Funcion SCAN_NUM que toma numero de teclado; el valor se guarda en ax
mov num2,cx ;mueve numero a variable num2

mov ah,09
lea dx,texto3
int 21h

mov ax,num1 ;mueve primer numero digitado a ax
add ax,num2 ;suma los numeros digitado, queda almacenaddo en ax
call PRINT_NUM

mov ah,09
lea dx,texto4
int 21h
mov ax,num1 ;mueve primer numero digitado a ax
sub ax,num2 ;resta el 2do del 1er numero, queda almacenaddo en ax
call PRINT_NUM



mov ah,09
lea dx,texto5
int 21h
mov ax,num1 ;mueve primer numero digitado a ax
mov bx,num2 ;mueve segundo numero digitado a bx
mul bx ;ax = ax*bx
call PRINT_NUM

mov ah,09
lea dx,texto6
int 21h
xor dx,dx ;deja en cero dx; si no lo hago se desborda la division
;DX ALMACENA EL modulo de la division, por eso hay q dejarlo en cero
mov ax,num1 ;mueve primer numero digitado a ax
mov bx,num2 ;mueve segundo numero digitado a bx
div bx ;ax = ax*bx
call PRINT_NUM


ret