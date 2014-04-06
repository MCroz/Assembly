.model small
.stack 100h
.386
.387
dispf macro what
			mov ah,2
			mov dl,what
			int 21h
endm
;=============================
show macro
			push eax
			push edx
			mov ah,2
			mov dl,al
			add dl,30h
			int 21h
			pop edx
			pop eax
endm
;=============================
backposition macro
			push ax
			push dx
			mov ah,2
			mov dl,08
			int 21h
			pop dx
			pop ax
endm
;=============================
setcursorposition macro x,y
			pushad
			mov ah,2
			mov bh,0
			mov dh,x
			mov dl,y
			int 10h 
			popad
endm
;==============================
clrscrn macro
			pushad
			mov ax,0600h
			mov bh,07h
			mov cx,0000h
			mov dx,184fh
			int 10h
			popad
endm
;==============================
displaystring macro string
			pushad
			lea dx,string
			mov ah,9
			int 21h
			popad
endm
;==============================
decimal macro
			push ax
			push dx
			mov ah,2
			mov dl,'.'
			int 21h
			pop dx
			pop ax
endm
;==============================
getuserinput macro zaplan
local error1,error2,error3,error4,start_input,after_decimal1,after_decimal2,decimal
			jmp start_input
error1:
			backposition
			jmp start_input
error2:
			backposition
			jmp decimal
error3:
			backposition
			jmp after_decimal1
error4:
			backposition
			jmp after_decimal2
start_input:
			mov ah,1
			int 21h
			cmp al,30h
			jl error1
			cmp al,39h
			jg error1
			xor ah,ah
			sub al,30h
			mov ebx,0ah
			mul ebx
			mov ecx,eax
decimal:
			mov ah,1
			int 21h
			cmp al,'.'
			jne error2
after_decimal1:
			mov ah,1
			int 21h
			cmp al,30h
			jl error3
			cmp al,39h
			jg error3
			xor ah,ah
			sub al,30h
			add eax,ecx
			mov ebx,0ah
			mul ebx
			mov ecx,eax
after_decimal2:
			mov ah,1
			int 21h
			cmp al,30h
			jl error4
			cmp al,39h
			jg error4
			xor ah,ah
			sub al,30h
			add eax,ecx
			mov zaplan,eax

endm
;=============================
tryagain macro
			setcursorposition 0fh,1ch
			displaystring question
			mov ah,1
			int 21h
endm
;============================
inputposition1 macro
			setcursorposition 0bh,2eh
endm
;============================
inputposition2 macro
			setcursorposition 0ch,2eh
endm
;============================
answerposition macro
			setcursorposition 0dh,2eh
endm
;============================
inputquestion1 macro
			setcursorposition 0bh,0ah
endm
;============================
inputquestion2 macro
			setcursorposition 0ch,0ah
endm
;============================
answerstringposition macro
			setcursorposition 0dh,0ah
endm
;============================
interface macro a,b,c,d,e
			clrscrn
			setcursorposition 07h,20h
			displaystring a
			setcursorposition 08h,24h
			displaystring b
			inputquestion1
			displaystring c
			inputquestion2
			displaystring d 
			answerstringposition
			displaystring e 
endm
;============================
decimal macro
 			push eax
 			push edx
			mov ah,2
			mov dl,'.'
			int 21h
			pop edx
			pop eax
endm
;=============================
getsum macro a,b,c
			finit
			fild a
			fild b 
			faddp
			fist c 
			mov eax,c 
			xor edx,edx
			mov ebx,3e8h
			div ebx
			mov ebx,eax
			mov ecx,edx
			mov ah,2
			mov dl,bl
			add dl,30h
			int 21h
			mov eax,ecx
			mov ebx,64h
			xor edx,edx
			div ebx
			mov ebx,eax
			mov ecx,edx
			mov ah,2
			mov dl,bl
			add dl,30h
			int 21h
			decimal
			mov eax,ecx
			mov ebx,0ah
			xor edx,edx
			div ebx
			mov ebx,eax
			mov ecx,edx
			mov ah,2
			mov dl,bl
			add dl,30h
			int 21h
			mov dl,cl 
			add dl,30h
			int 21h
endm
;===========================
getdifference macro a,b
			mov eax,a 
			mov ebx,b
			cmp eax,ebx
			jge regular 
negative:
			sub ebx,eax
			mov eax,ebx
			mov ebx,64h
			xor edx,edx
			div ebx
			mov ebx,eax
			mov ecx,edx
			mov ah,2
			mov dl,'-'
			int 21h
			mov dl,bl
			add dl,30h
			int 21h
			decimal
			mov eax,ecx
			mov ebx,0ah
			xor edx,edx
			div ebx
			mov ebx,eax
			mov ecx,edx
			mov ah,2
			mov dl,bl
			add dl,30h
			int 21h
			mov dl,cl
			add dl,30h
			int 21h
			jmp end_difference
regular:
			sub eax,ebx
			mov ebx,64h
			xor edx,edx
			div ebx
			mov ebx,eax
			mov ecx,edx
			mov ah,2
			mov dl,'0'
			int 21h
			mov dl,bl
			add dl,30h
			int 21h
			decimal
			mov eax,ecx
			mov ebx,0ah
			xor edx,edx
			div ebx
			mov ebx,eax
			mov ecx,edx
			mov ah,2
			mov dl,bl
			add dl,30h
			int 21h
			mov dl,cl
			add dl,30h
			int 21h
end_difference:
endm
;===============================
getproduct macro a,b
			mov eax,a 
			mov ebx,b 
			mul ebx
			xor edx,edx
			mov ebx,186a0h
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
			decimal
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
;===========================
getquotient macro a,b 
			mov eax,a 
			mov ebx,1000
			mul ebx
			mov ebx,b 
			xor edx,edx
			cmp ebx,0
			je print_error
			div ebx
			xor edx,edx
			xor ecx,ecx
			mov ch,0
			mov cl,1
			mov ebx,100000
			cmp eax,0
			je print_zero
start_print:
			inc ch
 			cmp ebx,0
 			je end_print
 			cmp cl,0
 			je calc
			cmp eax,ebx
			jl skip
calc:
			mov cl,0
			mov edx,0
			div ebx
			show
			mov eax,edx
skip:
			cmp ch,3
			je print_decimal
skip2:
			push eax
			mov edx,0
			mov eax,ebx
			div ten
			mov ebx,eax
			pop eax
			jmp start_print
print_decimal:
			decimal
			jmp skip2
print_zero:
			dispf '0'
			dispf '.'
			dispf '0'
			dispf '0'
			jmp end_print
print_error:
			displaystring error
end_print:
			

endm
.data

		calculator 			db 			'Calculator$'
		calculator2 		db 			'Calculator Menu$'
		mainmenustring1  	db 			'1.  Addition$'
		mainmenustring2 	db 			'2.  Subtraction$'
		mainmenustring3 	db 			'3.  Multiplication$'
		mainmenustring4 	db 			'4.  Division$'
		mainmenustring5 	db 			'5.  Exit$'
		askinput1 			db 			'Input First Number [0.00-9.99]   :  $'
		askinput2 			db 			'Input Second Number [0.00-9.99]  :  $'
		sum 				db 			'The Sum is :$'
		diff 				db 			'The difference is: $'
		prod 				db 			'The product is: $'
		quo 				db 			'The quotient is: $'
		add_head 			db 			'Addition$'
		sub_head 			db 			'Subtraction$'
		mul_head 			db 			'Multiplication$'
		div_head 			db 			'Division$'
		menuchoice 			db 			'Enter your choice: $'
		question 			db 			'Input another? [Y/N]: $'
		error 				db 			'Cannot be divided to zero.$'
		ten 				dd 			10
		integer1000 		dd 			1000
		input1 				dd 			?
		input2 				dd 			?
		input3 				dd 			?
.code
begin: .startup
			clrscrn
			setcursorposition 08h,23h
			displaystring calculator
			setcursorposition 0ah,1dh
			displaystring mainmenustring1
			setcursorposition 0bh,1dh
			displaystring mainmenustring2
			setcursorposition 0ch,1dh
			displaystring mainmenustring3
			setcursorposition 0dh,1dh
			displaystring mainmenustring4
			setcursorposition 0eh,1dh
			displaystring mainmenustring5
main_menu_choice:
			setcursorposition 10h,1dh
			displaystring menuchoice
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
			jmp main_menu_choice

addition:
			interface calculator2,add_head,askinput1,askinput2,sum
			inputposition1
			getuserinput input1
			inputposition2
			getuserinput input2
			answerposition
			backposition
			getsum input1,input2,input3
option1:
			tryagain
			cmp al,'y'
			je addition
			cmp al,'Y'
			je addition
			cmp al,'n'
			je begin
			cmp al,'N'
			je begin
			jmp option1
subtraction:
			interface calculator2,sub_head,askinput1,askinput2,diff
			inputposition1
			getuserinput input1
			inputposition2
			getuserinput input2
			answerposition
			backposition
			getdifference input1,input2
option2:
			tryagain
			cmp al,'y'
			je subtraction
			cmp al,'Y'
			je subtraction
			cmp al,'n'
			je begin
			cmp al,'N'
			je begin
			jmp option2
multiplication:
			interface calculator2,mul_head,askinput1,askinput2,prod
			inputposition1
			getuserinput input1
			inputposition2 
			getuserinput input2 
			answerposition
			backposition
			getproduct input1,input2
option3:
			tryagain
			cmp al,'y'
			je multiplication
			cmp al,'Y'
			je multiplication
			cmp al,'n'
			je begin
			cmp al,'N'
			je begin
			jmp option3
division:
			interface calculator2,div_head,askinput1,askinput2,quo
			inputposition1
			getuserinput input1
			inputposition2
			getuserinput input2
			answerposition
			getquotient input1,input2
option4:
			tryagain
			cmp al,'y'
			je division
			cmp al,'Y'
			je division
			cmp al,'n'
			je begin
			cmp al,'N'
			je begin
			jmp option4

exit:
.exit
end begin
