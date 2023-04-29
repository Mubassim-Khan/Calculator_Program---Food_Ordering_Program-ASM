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

.model small
.stack 100h
.data

Welcome db 0AH, 0DH, "Welcome to DineDesk, Please order from menu below $"
Thanks_msg db 0AH, 0DH, "Thanks for selecting DineDesk. Have a nice day :) $"
seperator db 0AH, 0DH, "------------------------------------------------------- $"

menu db 0AH, 0DH, '*************************MENU***************************$'
menuList db 0AH, 0DH, "Option Number    Items                Price$"
item1 db 0AH, 0DH, "1               Burgur              Rs.300$"
item2 db 0AH, 0DH, "2               Chips               Rs.100$"
item3 db 0AH, 0DH, "3               Pasta               Rs.500$"
item4 db 0AH, 0DH, "4               Biryani             Rs.200$"
reset db 0AH, 0AH, "0  =>  To reset/empty your cart $"
Billvar db 0AH, 0DH, "8  =>  View Cart & Total bill payable $"

totalItems db 0AH, 0DH, "Total items ordered are: $"

billList db 0AH, 0DH, "Items            Quantity$"
itemBill1 db 0AH, 0DH, "Burgur              $"
itemBill2 db 0AH, 0DH, "Chips               $"
itemBill3 db 0AH, 0DH, "Pasta               $"
itemBill4 db 0AH, 0DH, "Biryani             $"

totalBill db 0AH, 0DH, "Your total bill is = $"
Error db 0AH, 0DH, "You Entered wrong input $"

option db 0AH, 0DH, "Enter option number = $"

emptyLine db 0AH, 0DH, "$"

confirm1 db 0AH, 0DH, "1 BURGUR added to cart $"
confirm2 db 0AH, 0DH, "1 CHIPS added to cart $"
confirm3 db 0AH, 0DH, "1 PASTA added to cart $"
confirm4 db 0AH, 0DH, "1 BIRYANI added to cart $"
confirm5 db 0AH, 0DH, "**Your cart is now empty** $"
confirm6 db 0AH, 0DH, "Do you want to continue ordering ? $"
confirm7 db 0AH, 0DH, "(y) or (n) $"

rupee db "Rs $"

amount dw 0
count dw  '0'

b db '0'
c db '0'
p db '0'
br db '0'
.code
.code
main PROC
    mov ax, @data
    mov ds, ax

    printMsg emptyLine

    printMsg Welcome

    printMsg emptyLine

    printMsg menu
    
    mainLoop:
    printMsg menuList
    printMsg seperator

    printMsg item1
    printMsg item2
    printMsg item3
    printMsg item4

    printMsg emptyLine
    printMsg reset
    printMsg Billvar

    printMsg emptyLine

    printMsg option
    Input

    cmp al, '1'
    je optionLabel1

    cmp al, '2'
    je optionLabel2
    
    cmp al, '3'
    je optionLabel3
    
    cmp al, '4'
    je optionLabel4

    cmp al, '0'
    je resetLabel

    cmp al, '8'
    je billLabel
    
    printMsg Error
    printMsg emptyLine
    jmp mainLoop
    
    loop mainLoop

    optionLabel1:
    jmp option1

    optionLabel2:
    jmp option2

    optionLabel3:
    jmp option3

    optionLabel4:
    jmp option4

    resetLabel:
    jmp resetCart

    billLabel:
    jmp bill


main ENDP

; Option 1
option1 PROC
    printMsg emptyLine

    mov ax, 300
    add amount, ax
    mov dx, 0
    mov bx, 10
    mov cx, 0

    OP1Loop1:
    div bx
    push dx
    mov dx, 0
    mov ah, 0
    inc cx
    cmp ax, 0
    jne OP1Loop1

    OP1Loop2:
    pop dx
    add dx, 48
    loop OP1Loop2

    inc count
    inc b
    printMsg confirm1
    printMsg emptyLine

    jmp mainLoop
    ret
option1 ENDP

; Option 2
option2 PROC
    printMsg emptyLine

    mov ax, 100
    add amount, ax
    mov dx, 0
    mov bx, 10
    mov cx, 0

    OP2Loop1:
    div bx
    push dx
    mov dx, 0
    mov ah, 0
    inc cx
    cmp ax, 0
    jne OP2Loop1

    OP2Loop2:
    pop dx
    add dx, 48
    loop OP2Loop2

    inc count
    inc c
    printMsg confirm2
    printMsg emptyLine

    jmp mainLoop
    ret
option2 ENDP

; Option 3
option3 PROC
    printMsg emptyLine

    mov ax, 500
    add amount, ax
    mov dx, 0
    mov bx, 10
    mov cx, 0

    OP3Loop1:
    div bx
    push dx
    mov dx, 0
    mov ah, 0
    inc cx
    cmp ax, 0
    jne OP3Loop1

    OP3Loop2:
    pop dx
    add dx, 48
    loop OP3Loop2

    inc count
    inc p
    printMsg confirm3
    printMsg emptyLine

    jmp mainLoop
    ret
option3 ENDP

; ; Option 4
option4 PROC
    printMsg emptyLine

    mov ax, 200
    add amount, ax
    mov dx, 0
    mov bx, 10
    mov cx, 0

    OP4Loop1:
    div bx
    push dx
    mov dx, 0
    mov ah, 0
    inc cx
    cmp ax, 0
    jne OP4Loop1

    OP4Loop2:
    pop dx
    add dx, 48
    loop OP4Loop2

    inc count
    inc br
    printMsg confirm4
    printMsg emptyLine

    jmp mainLoop
    ret
option4 ENDP

;Reset Cart & Bill
resetCart PROC
    printMsg emptyLine
    mov b, '0'
    mov c, '0'
    mov p, '0'
    mov br, '0'
    mov amount, 0
    mov count, '0'

    printMsg confirm5
    printMsg emptyLine

    jmp mainLoop

resetCart ENDP

;Billing
bill PROC

    printMsg emptyLine
    printMsg billList
    printMsg seperator

    printMsg itemBill1
    mov dl, b
    printOutput

    printMsg itemBill2
    mov dl, c
    printOutput

    printMsg itemBill3
    mov dl, p
    printOutput

    printMsg itemBill4
    mov dl, br
    printOutput

    printMsg emptyLine

    printMsg totalItems
    mov dx, count
    printOutput

    printMsg totalBill
    printMsg rupee
    
    mov ax, amount
    mov dx, 0
    mov bx, 10
    mov cx, 0

    totalPush:
    div bx
    push dx
    mov dx, 0

    inc cx
    cmp ax, 0
    jne totalPush

    totalPrint:
    pop dx
    add dx, 48
    mov ah, 2
    int 21h
    loop totalPrint

    printMsg confirm6
    printMsg confirm7
    Input
    cmp al, 'y'
    je supporting

    cmp al, 'n'
    printMsg Thanks_msg
    mov ah, 4ch
    int 21h
bill ENDP

;description
supporting PROC
    printMsg emptyLine
    jmp mainLoop
supporting ENDP

end main