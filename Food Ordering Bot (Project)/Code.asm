printMsg MACRO para
    mov dx, offset para
    mov ah, 9
    int 21h
ENDM

printOutput MACRO 
    mov ah, 2
    int 21h
ENDM

Input MACRO 
    mov ah, 1
    int 21h
ENDM

addZeros MACRO 
    mov dl, '0'
    mov ah, 2
    int 21h

    mov dl, '0'
    mov ah, 2
    int 21h
ENDM

.model small
.stack 100h
.data

Welcome db 0AH, 0DH, "Welcome to xyz cafe, Please order from below options$"
Thanks_msg db 0AH, 0DH, "Thanks for selecting xyz cafe. Have a nice day$"
seperator db 0AH, 0DH, "------------------------------------ $"

menuList db 0AH, 0DH, "Items                Price$"
item1 db 0AH, 0DH, "1 => Burgoir        Rs.300$"
item2 db 0AH, 0DH, "2 => Chipas         Rs.100$"
item3 db 0AH, 0DH, "3 => Biscut         Rs.100$"
item4 db 0AH, 0DH, "4 => Posta          Rs.500$"
item5 db 0AH, 0DH, "5 => Baryani        Rs.200$"
totalBill db 0AH, 0DH, "Your total bill is = $"

Billvar db 0AH, 0DH, "8 => Cart/total bill $"
terminate db 0AH, 0DH, "0 => Exit $"

msg1 db 0AH, 0DH, "Enter option number = $"

testing db 0AH, 0DH, "Testing Code $"
emptyLine db 0AH, 0DH, "$"

temp1 db 0
temp2 db 0

HighAmount db ?
LowAmount db 0


i1 db 3
i2 db 1
i3 db 1
i4 db 5
i5 db 2
.code
main PROC
    mov ax, @data
    mov ds, ax

    printMsg emptyLine

    printMsg Welcome

    printMsg emptyLine
    
    mainLoop:
    printMsg menuList
    printMsg seperator

    printMsg item1
    printMsg item2
    printMsg item3
    printMsg item4
    printMsg item5

    printMsg emptyLine
    printMsg Billvar
    printMsg terminate

    printMsg emptyLine

    printMsg msg1
    Input

    cmp al, '1'
    je optionLabel1

    cmp al, '2'
    je optionLabel2
    
    cmp al, '3'
    je optionLabel3
    
    cmp al, '4'
    je optionLabel4
    
    cmp al, '5'
    je optionLabel5

    cmp al, '8'
    je billLabel

    cmp al, '0'
    je exit
    
    loop mainLoop

    optionLabel1:
    call option1

    optionLabel2:
    call option2

    optionLabel3:
    call option3

    optionLabel4:
    call option4

    optionLabel5:
    call option5

    billLabel:
    call bill

    exit:
    printMsg Thanks_msg
    mov ah, 4ch
    int 21h

main ENDP

; Option 1
option1 PROC
    printMsg emptyLine

    mov bl, i1
    add bl, 48

    mov bh, 0

    mov al, LowAmount

    mov ah, HighAmount

    add ax, bx
    AAA
    mov cx, ax

    add ch, 48
    add cl, 48

    mov HighAmount, ch
    mov LowAmount, cl

    mov dl, HighAmount
    printOutput

    mov dl, LowAmount
    printOutput
    mov HighAmount, 0

    jmp mainLoop
    ret
option1 ENDP

; Option 2
option2 PROC
    printMsg emptyLine

    mov bl, i2
    add bl, 48

    mov bh, 0

    mov al, LowAmount

    mov ah, HighAmount

    add ax, bx
    AAA
    mov cx, ax

    add ch, 48
    add cl, 48

    mov HighAmount, ch
    mov LowAmount, cl

    mov dl, HighAmount
    printOutput

    mov dl, LowAmount
    printOutput

    mov HighAmount, 0

    jmp mainLoop
    ret
option2 ENDP

; Option 3
option3 PROC
    printMsg testing
    printMsg emptyLine

    jmp mainLoop
    ret
option3 ENDP

; Option 4
option4 PROC
    printMsg testing
    printMsg emptyLine

    jmp mainLoop
    ret
option4 ENDP

; Option 5
option5 PROC
    printMsg testing
    printMsg emptyLine

    jmp mainLoop
    ret
option5 ENDP

;Billing
bill PROC
    printMsg totalBill

    mov dl, HighAmount
    printOutput

    mov dl, LowAmount
    printOutput

    addZeros
    printMsg emptyLine

    ; mov HighAmount, 0

    jmp mainLoop

bill ENDP
end main