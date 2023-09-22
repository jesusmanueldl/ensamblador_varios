;===============================================================
;un número primo es
;un número natural mayor que 1 que
;tiene únicamente dos divisores
;distintos: él mismo y el 1
;==============================================================
Title "Números Primos"
.386
.Model flat,stdcall
include masm32rt.inc
;==============#=Prototipos=#=======================
esprimo proto, num: Dword
listaprimo proto,listanum: ptr Dword, taml: Dword
;===================================================
.Data

	lista Dword 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20
	tmlista = ($-lista)/4		;tamaño de mi lista de numeros 
	
.Code
	;procedimiento principal
	Main proc
		;invocamos el procedimiento listaprimo que esnlista los nuemros que son primos
		printf("Los numeros primos son: \n")
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
				invoke esprimo, EBX			;el resultado retorna el EDX	
				CMP EDX,1					;comparar si es falso o true el resultado 
				JE imprime
				JNE sigue			
			
			sigue:				;si no es 1
			
				Add ESI,4
				Dec ECX
				JMP ciclo
			
			imprime:			;si es 1 imprime el numero primo
			
				pushad
				Mov EAX,Dword ptr[ESI]
				printf("%d ",EAX)
				popad
				JMP sigue
				
				
		salir:
		ret

	listaprimo endp	
	
	esprimo proc USES ECX EBX, num: Dword
				
		Mov EDI,0			;contador de que cantidad de divisores tiene el nuemro
		
		Mov ECX,num
		ciclo2:
		
			CMP ECX,0		;compara sino es el final del ciclo
			JE salir		;sale si es 0
			JNE next		;sigue con el ciclo
			
			next:
			
				Mov EAX,num			
				Mov EBX,ECX
				CDQ
				Div EBX			
			
			CMP EDX,0		;si el reciduio es cero tiene es divisible por otro numero exacto
			JE aumenta
			JNE sigue2
			
			sigue2:
				Dec ECX
				JMP ciclo2
			
			aumenta:		;incrementamos el contador 
				Inc EDI
				Dec ECX
				JMP ciclo2		
		salir:
		
			CMP EDI,2		;si solo tiene dos divisores es primo y si no no es primo
		    JE verdad
		    JNE falso
		    
		falso:
		
			Mov EDX,0
			JMP ext
			
		verdad:
		
			Mov EDX,1
			JMP ext
					
	ext:		
		ret

	esprimo endp
	
	End Main