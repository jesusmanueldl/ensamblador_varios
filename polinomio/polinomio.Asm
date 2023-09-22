Title "polinomio"
.386
.Model flat,stdcall
include masm32rt.inc
.Data
	polino Byte "111111000101",0
	tamano = ($-polino)
	
.Code
	Main proc		
		
		LOCAL grado:Byte
		Mov grado,0
		printf("\nEl polinomio se representa: ")
		Mov ESI,Offset polino
		add ESI,tamano-2
		Mov ECX,tamano-1
		ciclo1:
			
			Movzx EAX,grado
			
			pushad			
			printf("x^%d",EAX)
			popad
			
			Mov EAX,0
			Mov AL,[ESI]		
			pushad			
			printf("(%c)",EAX)
			popad
			
			CMP ECX,1
			JE salir
			JNE sigue
			sigue:
				pushad			
				printf("+")
				popad			
			
						
			Add grado,1
			Dec ESI	
			
			salir:
			
		Loop ciclo1
		
		printf("\n\n")
		inkey
		ret

	Main endp
	
	end Main