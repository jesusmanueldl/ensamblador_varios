Title "ordenamiento burbuja"
.386
.Model flat,stdcall
include masm32rt.inc
.Data
	
	lista Byte 0,2,4,15,1,20
	tamval = ($-lista)
		
.Code
	
	main proc
		Mov ESI,Offset lista
		Call burbuja
		Call imprime
		inkey
		invoke ExitProcess,0
		ret

	main endp
	
	burbuja proc
	
		Add ESI,tamval-1
		Mov EBX,0
		ciclo1:
			
			CMP EBX,tamval-1
			JBE sigue
			JNAE salir
			
			sigue:
				Mov EAX,tamval
				ciclo2:
					CMP EAX,EBX
					JA intercambia
					JNB inicio
					
					intercambia:
						Mov AL,Byte ptr[ESI]
    					Mov [ESI],Byte ptr[ESI-1]
						Mov [ESI-1],AL
						Dec EAX
						JMP ciclo2
					
					inicio:
						Inc EBX
						JMP ciclo1	
		
		salir:
		ret

	burbuja endp
	
	imprime proc
		
		
		Mov ECX,tamval
		Mov ESI,Offset lista
		ciclo1:
		
			pushad 
			
			Mov AL,Byte ptr[ESI]
			printf("%d",EAX)
			printf("\n")
			Inc ESI
			
			popad 
			
		Loop ciclo1
		
		ret

	imprime endp
	End main