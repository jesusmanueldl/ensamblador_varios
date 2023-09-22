Title "Números Primos"
.386
.Model flat,stdcall
include masm32rt.inc
;==============#=Prototipos=#=======================
esprimo proto, num: Dword
listaprimo proto,listanum: ptr Dword, taml: Dword
;===================================================
.Data

	lista Dword 1
	tmlista = ($-lista)/4
	
.Code
	;procedimiento principal
	Main proc
		;invocamos el procedimiento listaprimo que esnlista los nuemros que son primos
		invoke listaprimo, Addr lista,tmlista
		printf("\n")
		inkey
		ret

	Main endp
	
	listaprimo proc,listanum: ptr Dword, taml: Dword
		
		Mov ESI,listanum
		Mov ECX,taml
		ciclo:
		
			CMP ECX,0
			JE salir
			JNZ adelante
			
			adelante:
			
				Mov EBX,Dword ptr[ESI]
				invoke esprimo, EBX
				CMP EDX,1
				JE imprime
				JNE sigue
			
			;comparar si es falso o tru y inorimir el nuemro de esi
			sigue:
			
				Add ESI,4
				Dec ECX
				JMP ciclo
			
			imprime:
			
				pushad
				Mov AL,Byte ptr[ESI]
				printf("%d ",EAX)
				popad
				JMP sigue
				
				
		salir:
		ret

	listaprimo endp	
	
	esprimo proc USES ECX EBX, num: Dword
				
		Mov EDI,0
		
		Mov ECX,num
		ciclo2:
		
			CMP ECX,0
			JE salir
			JNE next
			
			next:
			
				Mov EAX,num			
				Mov EBX,ECX
				CDQ
				Div EBX			
			
			CMP EDX,0
			JE aumenta
			JNE sigue2
			
			sigue2:
				Dec ECX
				JMP ciclo2
			
			aumenta:
				Inc EDI
				Dec ECX
				JMP ciclo2		
		salir:
		
			CMP EDI,2
		    JE verdad
		    JNE falso
		    
		falso:
			Mov EDX,0
			JMP ext
			
		verdad:
			Mov EDX,1
					
	ext:		
		ret

	esprimo endp
	
	End Main