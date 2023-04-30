dosseg
printString MACRO a1
    mov dx, offset a1
    mov ah, 9
    int 21h
ENDM

printResult MACRO 
    mov ah, 2
    int 21h
ENDM

input MACRO
    mov ah, 1
    int 21h
ENDM

.model small
.stack 100h
.data
msg1 db 0AH, 0DH, "Enter 1st Number : $"
msg2 db 0AH, 0DH, "Enter 2nd Number : $"
msg3 db 0AH, 0DH, "Result : $"

msg4 db 0AH, 0DH, "Sum : $"

msg6 db 0AH, 0DH, "Enter Number : $"

msg7 db 0AH, 0DH, "Enter Multiplier : $"
msg8 db 0AH, 0DH, "Enter Multiplicand : $"
msg5 db 0AH, 0DH, "Product : $"

msg9 db 0AH, 0DH, "Enter Divisor : $"
msg10 db 0AH, 0DH, "Enter Dividend : $"
msg11 db 0AH, 0DH, "Quotient : $"

format1 db " x $"
format2 db " = $"
store db 1
inputValue db ?
highNo db ?
lowNo db ?
Ten db 10
StrTen db "10$"

Welcome_msg db 0AH, 0DH, "Welcome to QuickCalc !$"
Thank_msg db 0AH, 0DH, "                        Thank you for using QuickCalc ! $"

option1 db 0AH, 0DH, "Press 1 -> For Addition$"
option2 db 0AH, 0DH, "Press 2 -> For Subtraction$"
option3 db 0AH, 0DH, "Press 3 -> For Multiplication$"
option4 db 0AH, 0DH, "Press 4 -> For Division$"
option5 db 0AH, 0DH, "Press 5 -> For Square of a Number$"
option6 db 0AH, 0DH, "Press 6 -> For Table of any Number$"
option9 db 0AH, 0DH, "Press 0 -> To Exit$"

breaker db 0AH, 0DH, "==================================================================$"

userChoice db 0AH, 0DH, "Enter your choice = $"
userInput db 0

error db 0AH, 0DH, "WARNING: Divisor can not be ZERO '0', else the Answer would be 'INFINITY'. $"
throwError db 0AH, 0DH, "ERROR: Enter correct option number $"

emptyLine db 0AH, 0DH, " $"

a db ?
b db ?
remainder db ?
quotient db ?

.code
main PROC
    mov ax, @data
    mov ds, ax

    printString Welcome_msg

    printString emptyLine

    firstLoop:

    printString option1

    printString option2

    printString option3

    printString option4

    printString option5

    printString option6

    printString option9

    printString emptyLine

    printString userChoice

    input

    mov userInput, al

    cmp userInput, '1'
    je AdditionLabel

    cmp userInput, '2'
    je SubtractionLabel

    cmp userInput, '3'
    je MultiplicationLabel

    cmp userInput, '4'
    je DivisionLabel

    cmp userInput, '5'
    je SquareLabel

    cmp userInput, '6'
    je TableLabel

    cmp userInput, '0'
    je exit

    cmp userInput, '7'
    je inputError

    cmp userInput, '8'
    je inputError

    cmp userInput, '9'
    je inputError

    jmp jumper

    AdditionLabel:
    jmp Addition

    SubtractionLabel:
    jmp Subtraction

    MultiplicationLabel:
    jmp Multiplication

    DivisionLabel:
    jmp Division

    SquareLabel:
    jmp Square

    TableLabel:
    jmp Table11

    inputError:
    printString throwError
    printString emptyLine
    jmp firstLoop

    exit:
    mov ah, 6
; Black Background with text
    mov al, 00h         ; Full screen mode
    mov bh, 00001110b
    mov ch, 0
    mov cl, 0
    mov dh, 100
    mov dl, 100
    int 10h 

    mov dx, offset Thank_msg
    mov ah,9
    int 21h

    mov ah, 4ch
    int 21h
main ENDP

;Supporting Proc (Jumps to the firstLoop)
jumper PROC
    jmp firstLoop
jumper ENDP

;Procedure for Addition
Addition PROC

    printString msg1

    input

    sub al, 48
    mov bh, al

    input

    sub al, 48
    mov bl, al

; 1st two digit value into 'BX'

    printString msg2

    input

    sub al, 48
    mov ch, al

    input

    sub al, 48
    mov cl, al

; 2nd two digit value into 'CX' 

    add bl, cl

    mov al, bl
    mov ah, 0
    AAA

    mov cl, al
    mov bl, ah

    add bl, bh
    add bl, ch

    mov al, bl
    mov ah, 0
    AAA

    mov bx, ax

    printString msg4
    
    mov dl, bh
    add dl, 48
    printResult 

    mov dl, bl
    add dl, 48
    printResult

    mov dl, cl
    add dl, 48
    printResult

    printString breaker

    jmp main
    ret
Addition ENDP

;Subtraction Procedure
Subtraction PROC
    printString msg1

    input

    mov bl, al

    printString msg2
    
    input
    
    mov bh, al

    cmp bl, bh
    jl Minus

    sub bl, bh

    printString msg3

    mov dl, bl
    add dl, 48
    printResult
    printString breaker
    jmp main

    Minus:
    sub bh, bl

    printString msg3

    mov dl, '-'
    printResult

    mov dl, bh
    add dl, 48
    printResult
    printString breaker

    jmp main
    ret
Subtraction ENDP

;Multiplication
Multiplication PROC
    printString msg7

    input

    sub al, 48
    mov a, al

    printString msg8
    
    input

    sub al, 48
    mov b, al

    mov ah, 0

    mul a       ; Always multiply by the 1st variable
    AAM

    mov ch, ah
    mov cl, al

    printString msg5

    mov dl, ch
    add dl, 48

    printResult

    mov dl, cl
    add dl, 48

    printResult

    printString breaker
    jmp main
    ret
Multiplication ENDP

;Division
Division PROC
    printString msg9

    input
    sub al, 48
    mov a, al

    cmp a, 0
    je ZeroInput
    jg Continue

    ZeroInput:
    printString error
    printString emptyLine
    jmp Division

    Continue:

    printString msg10

    input

    sub al, 48
    mov b, al

    mov ah, 0

    div a

    mov remainder, ah
    mov quotient, al

    printString msg3

    mov dl, quotient
    add dl, 48

    printResult

    mov dl, '.'
    printResult

    mov cx, 2

    floatNo:

    mov al, remainder
    mov bl, 10
    mul bl

    mov b, al
    div a

    mov quotient, al
    mov remainder, ah

    mov dl, quotient
    add dl, 48
    printResult

    loop floatNo

    printString breaker
    jmp main
    ret
Division ENDP

;Square
Square PROC
    printString msg6

    input

    sub al, 48
    mov a, al

    mul a
    AAM

    mov ch, ah
    mov cl, al

    printString msg3

    mov dl, ch
    add dl, 48
    printResult

    mov dl, cl
    add dl, 48
    printResult

    printString breaker
    jmp main
    ret
Square ENDP

;Table
Table11 PROC
    printString msg6

    input

    mov inputValue, al

    sub al, 48

    mov bl, al

    printString emptyLine

    mov cx, 9

    TableLoop:
    mov ah, 0

    mov al, store

    mul bl
    AAM

    mov highNo, ah
    mov lowNo, al

    mov dl, inputValue
    printResult 

    printString format1

    mov dl, store
    add dl, 48
    printResult

    printString format2

    mov dl, highNo
    add dl, 48
    printResult

    mov dl, lowNo
    add dl, 48
    printResult

    printString emptyLine

    inc store
    loop TableLoop
    mov store, 1

    mov dl, inputValue
    printResult

    sub dl, 48

    mov al, Ten

    mul bl
    AAM

    mov highNo, ah
    mov lowNo, al

    printString format1

    printString StrTen

    printString format2

    mov dl, highNo
    add dl, 48
    mov ah, 2
    int 21h

    mov dl, lowNo
    add dl, 48
    mov ah, 2
    int 21h

    printString breaker
    jmp main
    ret
Table11 ENDP
end main