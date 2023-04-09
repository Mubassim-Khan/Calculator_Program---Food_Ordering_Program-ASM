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
msg1 db 0AH, 0DH, "Enter 1st number : $"
msg2 db 0AH, 0DH, "Enter 2nd number : $"
msg3 db 0AH, 0DH, "Result : $"

Welcome_msg db 0AH, 0DH, "Welcome to Calculating Machine !$"
option1 db 0AH, 0DH, "Press 1 -> For Addition$"
option2 db 0AH, 0DH, "Press 2 -> For Subtraction$"
option3 db 0AH, 0DH, "Press 9 -> To Exit$"
Thank_msg db 0AH, 0DH, "Thank you for using Calculator$"

breaker db 0Ah, 0DH, "--------------------------------------------------$"

userChoice db 0Ah, 0DH, "Enter your choice = $"
userInput db 0

error db 0Ah, 0DH, "The Result is negative. Enter proper values. $"

testing db "TESTING OVERHERE @@@^ $"

a db 0
b db 0

.code
main PROC
    mov ax, @data
    mov ds, ax

    printString Welcome_msg

    firstLoop:

    printString option1

    printString option2

    printString option3
    
    printString userChoice

    input

    mov userInput, al

    cmp userInput, 49
    je Addition

    cmp userInput, 50
    je Subtraction

    cmp userInput, 57
    je exit

    loop firstLoop

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
    aaa

    add al, 48
    add ah, 48

    mov bx, ax

    printString msg3

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
end main