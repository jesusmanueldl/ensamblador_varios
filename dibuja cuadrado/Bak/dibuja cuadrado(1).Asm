Title "dibuja cuadrado"
.386
.Model flat,stdcall
include masm32rt.inc
.Data
	
	coord Byte 3,3,6,4	;vector de coordenadas
	tamCor = ($-coord) ;tamaño de mi vect
	
.Code
	 main:
	 
	 	Mov ESI,Offset coord ;obtengo la primera coordenada
	 	
	 	;obtengo la coordenada donde comienza la fila
	 	Mov AL,Byte ptr[ESI+1]
	 	Sub AL,1
	 	Movzx ECX,AL	 	
	 	ciclo:
	 		
	 		Pushad
	 		printf("\n")	 		
	 		Popad
	 		
	 	Loop ciclo	 	
	 	
	 	;obtengo el  total de filas
	 	Movzx ECX,Byte ptr[ESI+(tamCor-1)]
	 	ciclo2:
	 	
	 		pushad
	 		
	 		Movzx ECX,Byte ptr[ESI]
	 		ciclo3:
	 			;pinto los espacion de la columna
	 			Pushad
	 			printf("%c",20H)
	 			Popad
	 			
	 		Loop ciclo3
	 		;dibujo el cuadro
	 		Movzx ECX,Byte ptr[ESI+(tamCor-2)]	 		
	 		ciclo4:
	 			
	 			Pushad
	 			printf("*")
	 			Popad
	 			
	 		Loop ciclo4	
	 		
	 		printf("\n") 
	 				
	 		Popad
	 	Loop ciclo2
	 	
	 	printf("\n")
	 	
	 	inkey
	 	invoke ExitProcess,0	 
	 
	 End main