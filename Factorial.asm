;FACTORIAL

putc    macro   char
        push    ax
        mov     al, char
        mov     ah, 0eh
        int     10h     
        pop     ax
endm
 
org     100h
 
jmp start
 
result dw ?
     
start:
 
mov dx, offset mensaje 
mov ah, 9
int 21h
 
mov dx, offset msg1
mov ah, 9
int 21h
jmp n1
 
mensaje db 0Dh,0Ah,'Numero entre 0 y 8','$'
msg1 db 0Dh,0Ah, 'Numero: $'
n1:
 
call    scan_num
 

mov     ax, 1
cmp     cx, 0
je      print_result
 
 
mov     bx, cx
 
mov     ax, 1
mov     bx, 1
 
calc_it:
mul     bx
cmp     dx, 0
jne     overflow
inc     bx
loop    calc_it
 
mov result, ax
print_result:
mov dx, offset msg2
mov ah, 9
int 21h
jmp n2
msg2 db 0Dh,0Ah, 'Factorial: $'
n2:
 
 
mov     ax, result
call    print_num_uns
jmp     exit
 
 
overflow:
mov dx, offset msg3
mov ah, 9
int 21h
jmp n3
msg3 db 0Dh,0Ah, 'Resultado Demasiado Grande', 0Dh, 0Ah,'Usar valores entre de 0 y 8.$'
n3:
jmp     start
 
exit:
 
mov ah, 0
int 16h
 
ret
 
SCAN_NUM        PROC    NEAR
        PUSH    DX
        PUSH    AX
        PUSH    SI        
        MOV     CX, 0
        MOV     CS:make_minus, 0
 
next_digit:
 
        MOV     AH, 00h
        INT     16h
        MOV     AH, 0Eh
        INT     10h
        CMP     AL, '-'
        JE      set_minus
        CMP     AL, 0Dh 
        JNE     not_cr
        JMP     stop_input
not_cr:
 
 
        CMP     AL, 8                  
        JNE     backspace_checked
        MOV     DX, 0                  
        MOV     AX, CX                  
        DIV     CS:ten                  
        MOV     CX, AX
        PUTC    ' '                     
        PUTC    8                       
        JMP     next_digit
backspace_checked:
        CMP     AL, '0'
        JAE     ok_AE_0
        JMP     remove_not_digit
ok_AE_0:        
        CMP     AL, '9'
        JBE     ok_digit
remove_not_digit:       
        PUTC    8       .
        PUTC    ' '   
        PUTC    8              
        JMP     next_digit   
ok_digit:
        PUSH    AX
        MOV     AX, CX
        MUL     CS:ten        
        MOV     CX, AX
        POP     AX
        CMP     DX, 0
        JNE     too_big
        SUB     AL, 30h
        MOV     AH, 0
        MOV     DX, CX     
        ADD     CX, AX
        JC      too_big2 
 
        JMP     next_digit
 
set_minus:
        MOV     CS:make_minus, 1
        JMP     next_digit
 
too_big2:
        MOV     CX, DX      
        MOV     DX, 0       
too_big:
        MOV     AX, CX
        DIV     CS:ten  
        MOV     CX, AX
        PUTC    8      
        PUTC    ' '    
        PUTC    8              
        JMP     next_digit   
stop_input:
        CMP     CS:make_minus, 0
        JE      not_minus
        NEG     CX
not_minus:
        POP     SI
        POP     AX
        POP     DX
        RET
make_minus      DB      ? 
SCAN_NUM        ENDP
PRINT_NUM       PROC    NEAR
        PUSH    DX
        PUSH    AX
 
        CMP     AX, 0
        JNZ     not_zero
 
        PUTC    '0'
        JMP     printed
 
not_zero:
        CMP     AX, 0
        JNS     positive
        NEG     AX
 
        PUTC    '-'
 
positive:
        CALL    PRINT_NUM_UNS
printed:
        POP     AX
        POP     DX
        RET
PRINT_NUM       ENDP
PRINT_NUM_UNS   PROC    NEAR
        PUSH    AX
        PUSH    BX
        PUSH    CX
        PUSH    DX
        MOV     CX, 1 
        MOV     BX, 10000     
        CMP     AX, 0
        JZ      print_zero
 
begin_print:
 
        CMP     BX,0
        JZ      end_print
        CMP     CX, 0
        JE      calc
        CMP     AX, BX
        JB      skip
calc:
        MOV     CX, 0  
        MOV     DX, 0
        DIV     BX   
        ADD     AL, 30h    
        PUTC    AL
 
 
        MOV     AX, DX 
 
skip:
        PUSH    AX
        MOV     DX, 0
        MOV     AX, BX
        DIV     CS:ten 
        MOV     BX, AX
        POP     AX
 
        JMP     begin_print
        
print_zero:
        PUTC    '0'
        
end_print:
 
        POP     DX
        POP     CX
        POP     BX
        POP     AX
        RET
PRINT_NUM_UNS   ENDP
ten             DW      10 

ret





