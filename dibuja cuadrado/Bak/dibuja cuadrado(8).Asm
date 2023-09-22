Title "dibuja cuadrado"
.386
.Model flat,stdcall
include masm32rt.inc
.Data
	
	coord Byte 2,1,6,4
	tamCor = ($-coord)
	
.Code
	 main:
	 
	 	Mov ESI,Offset coord
	 	
	 	Mov AL,Byte ptr[ESI+1]
	 	Sub AL,1
	 	Movzx ECX,AL	 	
	 	ciclo:
	 		
	 		Pushad
	 		printf("\n")	 		
	 		Popad
	 		
	 	Loop ciclo	 	
	 	
	 	
	 	Movzx ECX,Byte ptr[ESI+(tamCor-1)]
	 	ciclo2:
	 	
	 		pushad
	 		
	 		printf("%c%c",20H,20H)
	 		Movzx ECX,Byte ptr[ESI+(tamCor-2)]
	 		
	 		ciclo3:
	 		
	 			Pushad
	 			printf("*")
	 			Popad
	 			
	 		Loop ciclo3	
	 		
	 		printf("\n") 
	 				
	 		Popad
	 	Loop ciclo2
	 	
	 	printf("\n")
	 	
	 	inkey
	 	invoke ExitProcess,0	 
	 
	 End main