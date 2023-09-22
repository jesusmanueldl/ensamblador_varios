Title "Palindromo"
.386
.Model flat,stdcall
include masm32rt.inc 
.Data
	
	pal Byte "anita lava la tina",0

.Code

	Main Proc
		
		Mov ESI,Offset pal
		Call Longitud ;resultado en ECX
		Mov EDI,ESI
		Call Palindromo
		Call Imprimir		
		inkey
		invoke ExitProcess,0
		ret

	Main endp
	
	Longitud Proc USES ESI
		
		Mov ECX,0
		ciclo:
		
			CMP [ESI],Byte ptr 0	;pone en 1 a ZF la bandera si es igual ZF=1
			JZ Salir				;si ZF=1 sal	
			JNZ Continua
		
		Continua:
					
			Inc ESI
			Inc ECX
			JMP ciclo
						
		Salir:
			ret
	Longitud endp
	
	Palindromo Proc USES ESI EDI
		
		ciclo2:
		
			Mov DL,Byte ptr[EDI+ECX-1]
			CMP [ESI],DL
			JE Sigue
			JNE L_izq
			
		Sigue:
					
			Mov EAX,1
			Inc ESI
						
		Loop ciclo2
		JMP final
		
		L_izq:
			
			CMP [ESI],Byte ptr 20H
			JNE L_der
			Inc ESI
			JMP ciclo2
			
		L_der:
			
			CMP DL,Byte ptr 20H
			JNC fin
			Dec ECX
			JMP ciclo2
		
		fin:			
			Mov EAX,0
			
		final:
			
			ret
	Palindromo endp
	
	Imprimir Proc
		pushad
		printf("%d ",EAX)
		popad
		
		ret		
	Imprimir endp
	
	End Main