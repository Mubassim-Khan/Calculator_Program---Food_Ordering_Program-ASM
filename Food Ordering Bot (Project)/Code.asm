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
Welcome db 0AH, 0DH, "Hey channel welcome back to my guyz$"

item1 db 0AH, 0DH, "1 -> Burgoir $"
item2 db 0AH, 0DH, "2 -> Chipas $"
item3 db 0AH, 0DH, "3 -> Biscut $"
item4 db 0AH, 0DH, "4 -> Posta $"
item5 db 0AH, 0DH, "5 -> Baryani $"

terminate db 0AH, 0DH, "0 -> Exit"
msg1 db 0AH, 0DH, "Enter input $"

testing db 0AH, 0DH, "Testing Code $"


.code
main PROC
    mov ax, @data
    mov ds, ax

    printMsg Welcome
    
    l1:

    printMsg item1
    printMsg item2
    printMsg item3
    printMsg item4
    printMsg item5
    printMsg terminate

    printMsg msg1
    Input

    cmp al, '1'
    je working

    cmp al, '2'
    je working
    
    cmp al, '3'
    je working
    
    cmp al, '4'
    je working
    
    cmp al, '5'
    je working

    cmp al, '0'
    je exit
    
    loop l1

    working:
    call working12

    exit:
    mov ah, 4ch
    int 21h

main ENDP
;description
working12 PROC
    printMsg testing
    jmp main
    ret
working12 ENDP
end main