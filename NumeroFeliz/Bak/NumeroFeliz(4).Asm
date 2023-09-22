Title "Nuemro Feliz"
.386
.Model flat,stdcall
include masm32rt.inc
;===========prototipos==============
numeroFeliz proto, feliz: ptr Dword, tam: Dword
esfeliz proto, num: Dword
cuadrado proto, nume: Dword  

;===================================
.Data
	;lista de los numero felices	 
	 numFeliz Dword 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30
	 tamNF = ($-numFeliz)/4 ; tamaño de la lista de numero feliz
.Code
	
	Main proc
		printf("LOS NUEMROS FELIZ SON: ")
		printf("\n")
		invoke numeroFeliz, Addr numFeliz,tamNF
		printf("\n")		
		inkey
		ret

	Main endp
	
	numeroFeliz proc, feliz: ptr Dword, tam: Dword  
		
		Mov ESI,feliz		;offset a la primera pos de la lista de num
		
		Mov ECX,tam			;ciclo para recorrer la lista de numeros		
		ciclo1:		
			CMP ECX,0
			JE salir1
			JNE sigue1
			
			sigue1:
				push ECX
				Mov EBX,Dword ptr[ESI]		;le mando el rimer numero
				invoke esfeliz,EBX
				
				CMP EBX,1					;true = 1 ó falso = 0 si es feliz o no
				JE imprime
				JNE sigue2
			
			sigue2:							;sigo con el siguiente numero
				pop ECX
				Dec ECX
				Add ESI,4
				JMP ciclo1
			
			imprime:						;imprimo el numero que es feliz				
				pushad				
				Mov EAX,Dword ptr[ESI]
				printf("%d ",EAX)
				popad
				JMP sigue2
	salir1:		
		ret

	numeroFeliz endp
	
	esfeliz proc, num: Dword
	
		LOCAL cont: Dword	;numero maximo de iteracines
		LOCAL suma: Dword	;guardo las suma de los cuadrados	
		Mov suma,0					
		Mov cont,0
		
		Mov EAX,num				
		ciclo2:		
			CMP cont,20			;maximo de iteraciones para los nuemeros que sean feliz
			JE fin				
			JNE continua
		
			continua:			
				CMP EAX,0			;si ya no queda nuemero al monmento de dividir
				JE pasa
				JNE continua1
			
			continua1:				;divido entre 10 y separo los nuemos para sumar sus cuadrados
				Mov EBX,10
				CDQ
				Div EBX					
				push EAX
				invoke cuadrado,EDX		;invoco el procedimeinto que eleva al cuadrado
				pop EAX
				Add suma,ECX
				JMP ciclo2
				
			pasa:			
				Mov EAX,suma
				Inc cont			;sumo 1 al contador				
				CMP EAX,1			;si la suma dio 1 ya es feliz el numero
				JE salir2
				JNE pasa2
				
				pasa2:					
					Mov suma,0		;inicializo la suma para una nueva
				 	JMP ciclo2
				 	
					salir2:	
						Mov EBX,1	;si es feliz uso EBX como bol
						JMP fin
	fin:		
		ret

	esfeliz endp
	
	cuadrado proc USES EBX, nume: Dword		;procedimiento que recibe un numero y devuelve el cuadrado de el mismo
		
		Mov EAX,nume
		Mov EBX,nume
		Mul EBX
		Mov ECX,EAX
		
		ret
	
	cuadrado endp
	
	End Main