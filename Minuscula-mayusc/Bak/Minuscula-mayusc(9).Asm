Title "de minuscula a mayuscula"
.386
.Model flat,stdcall
include masm32rt.inc
.Data
	cadena Byte "hola",0
	tamanoCadena = ($-cadena)-1
	
.Code
	main:
		Mov ESI,Offset cadena
		Mov ECX,tamanoCdena
		ciclo:
			pushad
			
			Mov AH,32
			Mov AL,Byte ptr[ESI]
			Sub AL,AH
		
			printf("%c",EAX)
			Inc ESI
			popad
		
		Loop ciclo
		
		inkey
		invoke ExitProcess,0
	
	
	End main