Title "de minuscula a mayuscula"
.386
.Model flat,stdcall
include masm32rt.inc
.Data
	cadena Byte "ensamblador",0 ;la cadena debe de ser toda en minuscula
	tamanoCadena = ($-cadena)-1
	
.Code
	main:
	
		Mov ESI,Offset cadena		;apunto a la direccion de memo del primer caract.
		Mov ECX,tamanoCadena
		ciclo:						;recorro toda la cadena
			push ECX
			
			Mov AH,32
			Mov AL,Byte ptr[ESI]	;tomo el primer caracter de la cadena
			Sub AL,AH				;resto para obtener la letra mayuscula
		
			printf("%c",EAX)		;imprimo cada caracter en mayuscula
			
			pop ECX
			Inc ESI
		
		Loop ciclo
		printf("\n");imprimo un salto de linea
		inkey
		invoke ExitProcess,0	
	
	End main