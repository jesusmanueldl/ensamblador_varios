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
	 numFeliz Dword 19
	 tamNF = ($-numFeliz)/4 ; tamaño de la lista de nuero feliz
.Code
	
	Main proc
		
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
				Mov EBX,Dword ptr[ESI]
				invoke cuadrado,EBX
				invoke esfeliz,ECX
				
				CMP EBX,1					;true = 1 ó falso = 0
				JE imprime
				JNE sigue2
			
			sigue2:
				pop ECX
				Dec ECX
				Add ESI,4
				JMP ciclo1
			
			imprime:				
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
			CMP cont,20
			JE fin
			JNE continua
		
			continua:
				CMP EAX,0
				JE pasa
				JNE continua1
			
			continua1:
				Mov EBX,10
				CDQ
				Div EBX
				push EAX
				invoke cuadrado,EDX
				pop EAX
				Add suma,ECX
				JMP ciclo2
				
			pasa:			
				Mov EAX,suma
				Inc cont				
				CMP EAX,1
				JE salir2
				JNE pasa2
				
				pasa2:					
					Mov suma,0
				 	JMP ciclo2
				 	
					salir2:	
						Mov EBX,1
						JMP fin
	fin:		
		ret

	esfeliz endp
	
	cuadrado proc USES EBX, nume: Dword
		
		Mov EAX,nume
		Mov EBX,nume
		Mul EBX
		Mov ECX,EAX
		
		ret
	
	cuadrado endp
	
	End Main