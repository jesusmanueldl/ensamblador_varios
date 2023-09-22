Title "de minuscula a mayuscula"
.386
.Model flat,stdcall
include masm32rt.inc
.Data
	cadena Byte "jesusmanuel",0
	tamanoCadena = ($-cadena)-1
	
.Code
	main:
		Mov ESI,Offset cadena
		Mov ECX,tamanoCadena
		ciclo:
			push ECX
			
			Mov AH,32
			Mov AL,Byte ptr[ESI]
			Sub AL,AH
		
			printf("%c",EAX)
			
			pop ECX
			Inc ESI
		
		Loop ciclo
		printf("\n")
		inkey
		invoke ExitProcess,0
	
	
	End main