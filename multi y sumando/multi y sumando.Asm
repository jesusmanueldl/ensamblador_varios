Title "multiplicando y sumando numeros"
.386
.Model flat,stdcall
include masm32rt.inc
.Data
	
	V1 Dword 500,400,245
	tamv1 = ($-V1)/4		;tamaño de mi vect 1
	V2 Dword 456,789,12
	tamv2 = ($-V2)/4		;tamaño de mi vect 2
	
.Code
	
	main:
		;empiezo en las primeras dir. de los vect
		Mov ESI,Offset V1				
		Mov EBX,Offset V2
		Mov EAX,0			;contador de la suma total
		
		Mov ECX,tamv1							
		ciclo:
			Push ECX
				
				
				Mov ECX,tamv2
				ciclo2:
					push ECX
					
					Mov ECX,[EBX]				;obtengo el primer nuemro del segundo vect
					ciclo3:
					
						Mov EDX,[ESI]
						Add EAX,EDX				;sumo cada uno de los vectores
						
					Loop ciclo3						
					
					Add EBX,4					;aumento el vector 2
					
					pop ECX					
					
				Loop ciclo2
					
					Add ESI,4					;aumento el vect 1
					
				Mov EBX,Offset V2				;regreso el EBX al primer dato de la segnda cad.
			
			Pop ECX
		
		Loop ciclo
		
		;imprimo mi resultado
		pushad
		printf("%d",EAX)
		printf("\n")
		popad
		inkey
		invoke ExitProcess,0
	
	End main
	