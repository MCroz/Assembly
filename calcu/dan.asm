.model small
.stack 100h
.386
.387
print_quotient macro a 
				mov eax,a 
				xor edx,edx
				mov ebx,100000
				div ebx
				cmp al,0
				jne cont
				mov cx,99
				jmp skips
cont:
				putc
skips:
				mov eax,edx
				mov ebx,10000
				xor edx,edx
				div ebx
				cmp al,0
				jne cont2
				cmp cx,99
				jne cont2
				jmp skipss
cont2:
				putc
skipss: 	
				mov eax,edx
				mov ebx,1000
				xor edx,edx
				div ebx
				putc
				ah02 '.'
				mov eax,edx
				mov ebx,100
				xor edx,edx
				div ebx
				putc
				mov eax,edx
				mov ebx,10
				xor edx,edx
				div ebx
				putc
				mov eax,edx
				putc
endm

print_prod macro a 
				mov eax,a 
				xor edx,edx
				mov ebx,100000
				div ebx
				cmp al,0
				je skip_print_zero
				putc
skip_print_zero:
				mov eax,edx
				mov ebx,10000
				xor edx,edx
				div ebx
				putc
				ah02 '.'
				mov eax,edx
				mov ebx,1000
				xor edx,edx
				div ebx
				putc
				mov eax,edx
				mov ebx,100
				xor edx,edx
				div ebx
				putc
				mov eax,edx
				mov ebx,10
				xor edx,edx
				div ebx
				putc
				mov eax,edx
				putc

endm

print_diff macro a 
				cmp ecx,1
				jne start_print
				ah02 08h
				ah02 '-'
start_print:
				mov eax,a 
				mov ebx,100
				xor edx,edx
				div ebx
				putc
				ah02 '.'
				mov eax,edx
				mov ebx,10
				xor edx,edx
				div ebx
				putc
				mov eax,edx
				putc
endm

putc macro
				push ax
				push dx
				mov ah,2
				mov dl,al
				add dl,30h
				int 21h
				pop dx
				pop ax
endm

print_sum macro a 
				mov eax,a 
				mov ebx,1000
				xor edx,edx
				div ebx
				cmp al,0
				je skip
				putc
skip:
				mov eax,edx
				xor edx,edx
				mov ebx,100
				div ebx
				putc
				mov eax,edx
				xor edx,edx
				mov ebx,10
				div ebx
				ah02 '.'
				putc
				mov eax,edx
				putc
endm

scan_num macro a
				mov ah,1
				int 21h
				sub al,30h
				xor ah,ah
				mov hundreds,eax
				ah02 '.'
				mov ah,1
				int 21h
				sub al,30h
				xor ah,ah
				mov tens,eax
				mov ah,1
				int 21h
				sub al,30h
				xor ah,ah 
				mov ones,eax
				finit
				fild hundreds
				fild integerten
				fmulp
				fild tens
				faddp
				fild integerten
				fmulp
				fild ones
				faddp
				fistp a
endm


setcursor macro a,b
				pushad
				mov ah,2
				mov bh,0
				mov dh,a 
				mov dl,b 
				int 10h 
				popad
endm

eraseall macro 
				pushad
				mov ax,0600h
				mov bh,07h
				mov cx,0000h
				mov dx,184fh
				int 10h
				popad
endm				

cout macro string
				pushad
				lea dx,string
				mov ah,9
				int 21h
				popad
endm

ah02 macro a 	
				push eax 
				push edx
				mov ah,2
				mov dl,a 
				int 21h
				pop edx
				pop eax
endm

gui macro a,b,c,d,e
				eraseall
				setcursor 07h,20h
				cout a
				setcursor 08h,24h
				cout b
				setcursor 0bh,0ah
				cout c
				setcursor 0ch,0ah
				cout d 
				setcursor 0dh,0ah
				cout e 
endm

.data
		calcustring1		db 			'Calculator$'
		calcustring2		db 			'Calculator Menu$'
		menustring1  		db 			'1.  Addition$'
		menustring2 		db 			'2.  Subtraction$'
		menustring3 		db 			'3.  Multiplication$'
		menustring4 		db 			'4.  Division$'
		menustring5 		db 			'5.  Exit$'
		askinput1 			db 			'Input First Number [0.00-9.99]   :  $'
		askinput2 			db 			'Input Second Number [0.00-9.99]  :  $'
		sum 				db 			'The Sum is :$'
		diff 				db 			'The difference is: $'
		prod 				db 			'The product is: $'
		quo 				db 			'The quotient is: $'
		add_string			db 			'Addition$'
		sub_string 			db 			'Subtraction$'
		mul_string 			db 			'Multiplication$'
		div_string 			db 			'Division$'
		choicestring 		db 			'Enter your choice: $'
		questionstring 		db 			'Input another? [Y/N]: $'
		syntax_error 		db 			'Cannot be divided to zero.$'
		input_error 		db 			'Invalid Input Please Try Again$'
		hundreds 			dd 			?
		tens 				dd 			?
		ones 				dd 			?
		integerhundred 		dd 			100
		integerten 			dd 			10
		integerthousand 	dd 			1000
		number1 			dd 			?
		number2 			dd 			?
		number3 			dd 			?
.code
begin:
.startup
				eraseall
				setcursor 08h,23h
				cout calcustring1
				setcursor 0ah,1dh
				cout menustring1
				setcursor 0bh,1dh
				cout menustring2
				setcursor 0ch,1dh
				cout menustring3
				setcursor 0dh,1dh
				cout menustring4
				setcursor 0eh,1dh
				cout menustring5
menuoption:
				setcursor 10h,1dh
				cout choicestring
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
				je quit 
				setcursor 11h,19h
				cout input_error
				jmp menuoption
addition:
				gui calcustring2,add_string,askinput1,askinput2,sum
				setcursor 0bh,2eh
				scan_num number1
				setcursor 0ch,2eh
				scan_num number2
				finit
				fild number1
				fild number2
				faddp
				fistp number3
				setcursor 0dh,2eh
				print_sum number3
add_option:
				setcursor 0fh,1ch
				cout questionstring
				mov ah,01h
				int 21h
				cmp al,'y'
				je addition
				cmp al,'Y'
				je addition
				cmp al,'n'
				je begin
				cmp al,'N'
				je begin
				jmp add_option

subtraction:
				gui calcustring2,sub_string,askinput1,askinput2,diff
				setcursor 0bh,2eh
				scan_num number1
				setcursor 0ch,2eh
				scan_num number2
				mov ebx,number1
				mov ecx,number2
				cmp ebx,ecx
				jge positive
				finit
				fild number2
				fild number1
				fsubp
				fistp number3
				mov ecx,1
				jmp skippers
positive:
				finit
				fild number1
				fild number2
				fsubp
				fistp number3
				mov ecx,0
skippers:		
				setcursor 0dh,2eh
				print_diff number3	
sub_option:
				setcursor 0fh,1ch
				cout questionstring
				mov ah,01h
				int 21h
				cmp al,'y'
				je subtraction
				cmp al,'Y'
				je subtraction
				cmp al,'n'
				je begin
				cmp al,'N'
				je begin
				jmp sub_option			
multiplication:
				gui calcustring2,mul_string,askinput1,askinput2,prod
				setcursor 0bh,2eh
				scan_num number1
				setcursor 0ch,2eh
				scan_num number2
				finit
				fild number1
				fild number2
				fmulp
				fistp number3
				setcursor 0dh,2eh
				print_prod number3
mul_option:
				setcursor 0fh,1ch
				cout questionstring
				mov ah,01h
				int 21h
				cmp al,'y'
				je multiplication
				cmp al,'Y'
				je multiplication
				cmp al,'n'
				je begin
				cmp al,'N'
				je begin
				jmp mul_option
division:
				gui calcustring2,div_string,askinput1,askinput2,quo
				setcursor 0bh,2eh
				scan_num number1
				setcursor 0ch,2eh
				scan_num number2
				mov eax,number2
				cmp eax,0
				je print_syntax_error
				finit
				fild number1
				fild integerthousand
				fmulp
				fild number2
				fdivp
				fistp number3
				setcursor 0dh,2eh
				print_quotient number3
				jmp div_option
print_syntax_error:
				setcursor 0dh,2eh
				cout syntax_error
div_option:
				setcursor 0fh,1ch
				cout questionstring
				mov ah,01h
				int 21h
				cmp al,'y'
				je division
				cmp al,'Y'
				je division
				cmp al,'n'
				je begin
				cmp al,'N'
				je begin
				jmp div_option
quit:
.exit 
end begin

