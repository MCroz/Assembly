.model small
.stack 100h
.386
.387




;---------------------------------
choices macro
			position 0fh,1ch
			showstring choice
			mov ah,01h
			int 21h
endm
;--------------------------------
input111 macro
			position 0bh,2eh
endm
;--------------------------------
input222 macro
			position 0ch,2eh
endm
;--------------------------------
answer1 macro
			position 0dh,2dh
endm
;--------------------------------
position macro number1,number2
			
			push ax
			push bx
			push cx
			push dx
			mov ah,02
			mov bh,0
			mov dh,number1
			mov dl,number2
			int 10h
			pop dx
			pop cx
			pop bx
			pop ax
endm
;-------------------------------
clearscreen macro
			pushad
			mov ax,0600h
			mov bh,07h
			mov cx,0000h
			mov dx,184fh
			int 10h
			popad
endm
;-------------------------------
showstring macro string
			pushad
			lea dx,string
			mov ah,9
			int 21h
			popad
endm
;-------------------------------
input11 macro
			position 0bh,0ah
endm
;-------------------------------
input22 macro
			position 0ch,0ah
endm
;-------------------------------
answer macro
			position 0dh,0ah
endm
;-------------------------------
dotpoint macro
			push ax
			push dx
			mov ah,02
			mov dl,2eh
			int 21h
			pop dx
			pop ax
endm
;------------------------------
getinput1 macro
			mov ah,01
			int 21h
			sub al,30h
			mov bh,al
			dotpoint
			int 21h
			sub al,30h
			mov ch,al
			int 21h
			sub al,30h
			mov dh,al
endm	
;-----------------------------
getinput2 macro
			mov ah,01
			int 21h
			sub al,30h
			mov bl,al
			dotpoint
			int 21h
			sub al,30h
			mov cl,al
			int 21h
			sub al,30h
			mov dl,al
endm
;-----------------------------
getsum macro
local carry1,carry2,nxt1,nxt2,unangcarry,pangalawangcarry,pangatlongcarry,finish,finish2
			pushad
			add dh,dl
			cmp dh,0ah
			jge unangcarry
			jmp nxt1
carry1:			
			add ch,1
nxt1:
			add ch,cl
			cmp ch,0ah
			jge pangalawangcarry
			jmp nxt2
carry2:		
			add bh,1
nxt2:
			add bh,bl
			cmp bh,0ah
			jge pangatlongcarry
			jmp finish

unangcarry:
			sub dh,0ah
			jmp carry1
pangalawangcarry:
			sub ch,0ah
			jmp carry2
pangatlongcarry:
			sub bh,0ah
			mov bl,1
			jmp finish2
finish:
			mov bl,0
finish2:
			mov cl,dh

			mov ah,02
			mov dl,bl
			add dl,30h
			int 21h
			mov dl,bh
			add dl,30h
			int 21h
			dotpoint
			mov dl,ch
			add dl,30h
			int 21h
			mov dl,cl
			add dl,30h
			int 21h
			popad
endm

getinputdiff1 macro
			mov ah,01
			int 21h
			sub al,30h
			xor ah,ah
			mov bx,0ah
			mul bx
			xor bx,bx
			mov bx,ax
			dotpoint
			mov ah,01
			int 21h
			sub al,30h
			xor ah,ah
			add ax,bx
			mov bx,0ah
			mul bx
			xor bx,bx
			mov bx,ax
			mov ah,01
			int 21h
			sub al,30h
			xor ah,ah
			add bx,ax
			xor cx,cx
			mov cx,bx
endm

getinputdiff2 macro
			mov ah,01
			int 21h
			sub al,30h
			xor ah,ah
			mov bx,0ah
			mul bx
			xor bx,bx
			mov bx,ax
			dotpoint
			mov ah,01
			int 21h
			sub al,30h
			xor ah,ah
			add ax,bx
			mov bx,0ah
			mul bx
			xor bx,bx
			mov bx,ax
			mov ah,01
			int 21h
			sub al,30h
			xor ah,ah
			add bx,ax
endm

getdiff macro

			cmp cx,bx
			jge regular
			sub bx,cx
			xor ax,ax
			mov ax,bx
			div integerhundred
			xor bx,bx
			xor cx,cx
			mov bx,ax
			mov cx,dx
			mov ah,02
			mov dl,'-'
			int 21h
			mov dx,bx
			add dx,30h
			int 21h
			dotpoint
			mov ax,cx
			div integerten
			mov bx,ax
			mov cx,dx
			mov ah,02
			mov dl,bl
			add dl,30h
			int 21h
			mov dl,cl
			int 21h
			jmp tapos
regular:
			sub cx,bx
			xor ax,ax
			mov ax,cx
			div integerhundred
			xor bx,bx
			xor cx,cx
			mov bx,ax
			mov cx,dx
			mov ah,02
			mov dl,'0'
			int 21h
			mov dx,bx
			add dx,30h
			int 21h
			dotpoint
			mov ax,cx
			xor dx,dx
			div integerten
			mov bx,ax
			mov cx,dx
			mov ah,02
			mov dl,bl
			add dl,30h
			int 21h
			mov dl,cl
			add dl,30h
			int 21h
tapos:
		
endm

getdiff2 macro
local regular2,ws
			cmp cx,bx
			jge regular2
			sub bx,cx
			mov ax,bx
			mov bx,64h
			div bx
			mov bx,ax
			mov cx,dx
			mov ah,02
			mov dl,'-'
			int 21h
			mov dl,bl
			add dl,30h
			int 21h
			mov dl,'.'
			int 21h
			mov ax,cx
			mov bx,0ah
			xor dx,dx
			div bx
			mov bx,ax
			mov cx,dx
			mov ah,02
			mov dl,bl
			add dl,30h
			int 21h
			mov dl,cl
			add dl,30h
			int 21h
			jmp ws
regular2:
			sub cx,bx
			mov ax,cx
			mov bx,64h
			div bx
			mov bx,ax
			mov cx,dx
			mov ah,02
			mov dl,'0'
			int 21h
			mov dl,bl
			add dl,30h
			int 21h
			mov dl,'.'
			int 21h
			mov ax,cx
			mov bx,0ah
			xor dx,dx
			div bx
			mov bx,ax
			mov cx,dx
			mov ah,02
			mov dl,bl
			add dl,30h
			int 21h
			mov dl,cl
			add dl,30h
			int 21h

ws:
endm

getprod macro
			mov eax,ecx
			mul ebx
			mov ebx,186a0h
			xor edx,edx
			div ebx
			mov ecx,edx
			mov ebx,eax
			mov ah,02
			mov dl,bl
			add dl,30h
			int 21h
			mov eax,ecx
			xor edx,edx
			mov ebx,2710h
			div ebx
			mov ebx,eax
			mov ecx,edx
			mov ah,02
			mov dl,bl
			add dl,30h
			int 21h
			mov ah,02
			mov dl,'.'
			int 21h
			xor dx,dx
			mov ax,cx
			mov bx,03e8h
			div bx
			mov bx,ax
			mov cx,dx
			mov ah,02
			mov dl,bl
			add dl,30h
			int 21h
			mov ax,cx
			mov bx,64h
			xor dx,dx
			div bx
			mov bx,ax
			mov cx,dx
			mov ah,02
			mov dl,bl
			add dl,30h
			int 21h
			mov ax,cx
			mov bx,0ah
			xor dx,dx
			div bx
			mov bx,ax
			mov cx,dx
			mov ah,02
			mov dl,bl
			add dl,30h
			int 21h
			mov dl,cl
			add dl,30h
			int 21h
endm

getquo macro
			mov number1,ecx
			mov number2,ebx
			finit
			fild number1
			fild thousand
			fmulp
			fild number2
			fdivp
			fistp number3
			mov eax,number3

			mov ebx,186a0h
			xor edx,edx
			div ebx
			mov ebx,eax
			mov ecx,edx
			mov ah,02
			mov dl,bl
			add dl,30h
			cmp dl,30h
			je noawt1
			int 21h
			jmp @111
noawt1:
			mov dl,20h
			int 21h
			push ax
			mov ax,1
			mov checker,ax
			pop ax
@111:
			mov eax,ecx
			mov ebx,2710h
			xor edx,edx
			div ebx
			mov ebx,eax
			mov ecx,edx
			mov ah,02
			mov dl,bl
			add dl,30h
			cmp dl,30h
			je noawt2
			int 21h
			jmp @222
noawt2:
			cmp checker,1
			je @noawt3
			int 21h
			jmp @222
@noawt3:
			mov dl,20h
			int 21h
@222:
			mov eax,ecx
			mov ebx,3e8h
			xor edx,edx
			div ebx
			mov ebx,eax
			mov ecx,edx
			mov ah,02
			mov dl,bl
			add dl,30h
			int 21h
			mov ah,02
			mov dl,'.'
			int 21h
			mov eax,ecx
			mov ebx,64h
			xor edx,edx
			div ebx
			mov ebx,eax
			mov ecx,edx
			mov ah,02
			mov dl,bl
			add dl,30h
			int 21h
			mov eax,ecx
			mov ebx,0ah
			xor edx,edx
			div ebx
			mov ebx,eax
			mov ecx,edx
			mov ah,02
			mov dl,bl
			add dl,30h
			int 21h
			mov dl,cl
			add dl,30h
			int 21h
endm

			


.data

	calcu 			db			'Calculator$'
	calcu2			db 			'Calculator Menu$'
	menadd	 		db 			'1.  Addition$'	
	mensub 			db 			'2.  Subtraction$'
	menmul 			db 			'3.  Multiplication$'
	mendiv 			db 			'4.  Division$'
	menexit 		db 			'5.  Exit$'
	input1 			db 			'Input First Number [0.00-9.99]   :  $'
	input2 			db 			'Input Second Number [0.00-9.99]  :  $'
	sum 			db 			'The sum is: $'
	diff 			db 			'The difference is: $'
	prod 			db 			'The product is: $'
	quo 			db 			'The quotient is: $'
	addhead 		db 			'Addition$'
	subhead 		db 			'Subtraction$'
	mulhead 		db 			'Multiplication$'
	divhead 		db 			'Division$'
	mainchoice 		db 			'Enter your choice: $'
	choice 			db 			'Input another? [Y/N]: $'
	error 			db 			'Cannot be divided to zero.$'
	integerten 		db 			10
	integerhundred	dw 			100
	number1 		dd 			?
	number2 		dd 			?
	number3 		dd 			?
	number4 		dw 			?
	number5 		dw 			?
	number6 		dw 			?
	number7 		dw 			?
	number8 		dw 			?
	number9 		dw 			?
	tester 			db 			?
    thousand 		dd 			1000
    checker 		dw			?


.code
begin: .startup

			clearscreen
			position 08h,23h
			showstring calcu
			position 0ah,1dh
			showstring menadd
			position 0bh,1dh
			showstring mensub
			position 0ch,1dh
			showstring menmul
			position 0dh,1dh
			showstring mendiv
			position 0eh,1dh
			showstring menexit

menuchoice:
			position 10h,1dh
			showstring mainchoice
			mov ah,01
			int 21h
			cmp al,31h
			je addition
			cmp al,32h
			je subtraction
			cmp al,33h
			je multiplication
			cmp al,34h
			je division
			cmp al,35h
			je exit
			jmp menuchoice

addition:
			clearscreen
			position 07h,20h
			showstring calcu2
			position 08h,24h
			showstring addhead
			input11
			showstring input1
			input22
			showstring input2
			answer
			showstring sum
			input111
			getinput1
			input222
			getinput2
			answer1
			getsum
option1:
			choices
        	cmp al,59h
        	je addition
        	cmp al,79h
        	je addition
        	cmp al,4eh
        	je begin
        	cmp al,6eh
        	je begin
        	jmp option1

subtraction:
			clearscreen
			position 07h,20h
			showstring calcu2
			position 08h,24h
			showstring subhead
			input11
			showstring input1
			input22
			showstring input2
			answer
			showstring diff
			input111
			getinputdiff1
			input222
			getinputdiff2
			answer1
			getdiff2
option2:
			choices
        	cmp al,59h
        	je subtraction
        	cmp al,79h
        	je subtraction
        	cmp al,4eh
        	je begin
        	cmp al,6eh
        	je begin
        	jmp option2

multiplication:
			clearscreen
			position 07h,20h
			showstring calcu2
			position 08h,24h
			showstring mulhead
			input11
			showstring input1
			input22
			showstring input2
			answer
			showstring prod
			input111
			getinputdiff1
			input222
			getinputdiff2
			answer1
			getprod
option3:
			choices
        	cmp al,59h
        	je multiplication
        	cmp al,79h
        	je multiplication
        	cmp al,4eh
        	je begin
        	cmp al,6eh
        	je begin
        	jmp option3
division:
			clearscreen	
			position 07h,20h
			showstring calcu2
			position 08h,24h
			showstring divhead
			input11
			showstring input1
			input22
			showstring input2
			answer
			showstring quo
			input111
			getinputdiff1
			input222
			getinputdiff2
			cmp bx,0
			je fag
			answer1
			pushad
			mov ah,02
			mov dl,08
			int 21h
			popad
			getquo
			jmp option4
fag: 	
			answer1	
			showstring error
option4:
			choices
        	cmp al,59h
        	je division
        	cmp al,79h
        	je division
        	cmp al,4eh
        	je begin
        	cmp al,6eh
        	je begin
        	jmp option4

		
exit:
.exit
end begin