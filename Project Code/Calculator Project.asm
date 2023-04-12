dosseg
printString MACRO a1
    mov dx, offset a1
    mov ah, 9
    int 21h
ENDM

printResult MACRO b1
    mov ah, 2
    int 21h
ENDM

input MACRO c1
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
msg5 db 0AH, 0DH, "Product : $"
msg6 db 0AH, 0DH, "Enter Number : $"
msg7 db 0AH, 0DH, "Enter Multiplier : $"
msg8 db 0AH, 0DH, "Enter Multiplicand : $"
msg9 db 0AH, 0DH, "Enter Divisior : $"
msg10 db 0AH, 0DH, "Enter Dividend : $"


Welcome_msg db 0AH, 0DH, "Welcome to Calculating Machine !$"
option1 db 0AH, 0DH, "Press 1 -> For Addition$"
option2 db 0AH, 0DH, "Press 2 -> For Subtraction$"
option3 db 0AH, 0DH, "Press 3 -> For Multiplication$"
option4 db 0AH, 0DH, "Press 4 -> For Division$"
option5 db 0AH, 0DH, "Press 5 -> For Square of a Number$"

option9 db 0AH, 0DH, "Press 0 -> To Exit$"
Thank_msg db 0AH, 0DH, "Thank you for using Calculator$"

breaker db 0Ah, 0DH, "--------------------------------------------------$"

userChoice db 0Ah, 0DH, "Enter your choice = $"
userInput db 0

error db 0Ah, 0DH, "The Result is negative. Enter proper values. $"

testing db "TESTING OVERHERE @@@^ $"

a db ?
b db ?

.code
main PROC
    mov ax, @data
    mov ds, ax

    printString Welcome_msg

    firstLoop:

    printString option1

    printString option2

    printString option3

    printString option4

    printString option5

    printString option9

    printString userChoice

    input

    mov userInput, al

    cmp userInput, 49
    je Addition

    cmp userInput, 50
    je Subtraction

    cmp userInput, 51
    je MultiplicationLabel

    cmp userInput, 52
    je DivisionLabel

    cmp userInput, 53
    je SquareLabel

    cmp userInput, 48
    je exit

    loop firstLoop

    MultiplicationLabel:
    jmp Multiplication

    DivisionLabel:
    jmp Division

    SquareLabel:
    jmp Square

    exit:
    printString Thank_msg

    mov ah, 4ch
    int 21h
main ENDP

;Procedure for Addition
Addition PROC

    printString msg1

    input

    mov a, al

    printString msg2

    input

    mov b, al

    mov ah, 0

    add al, a
    AAA

    add al, 48
    add ah, 48

    mov bx, ax

    printString msg4

    mov dl, bh
    printResult 

    mov dl, bl
    printResult

    printString breaker

    jmp main
Addition ENDP

;Subtraction Procedure
Subtraction PROC
    printString msg1

    input

    mov bl, al

    printString msg2
    
    input
    
    mov bh, al

    printString msg3

    sub bl, bh
    add bl, 48
    mov dl, bl

    cmp dl, 48

    jl negativeResult
    jge PositiveResult

    negativeResult:
    printString error
    printString breaker
    jmp Subtraction

    positiveResult:
    printResult
    printString breaker
    jmp main
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

Multiplication ENDP

;Division
Division PROC
    printString testing

    printString breaker
    jmp main
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
Square ENDP
end main