Title "multiplicando y sumando numeros"
.386
.Model flat,stdcall
include masm32rt.inc
.Data
	
	V1 Dword 500,400,245
	tamv1 = ($-V1)/4
	V2 Dword 456,789,12
	tamv2 = ($-V2)/4
	
.Code
	
	main:
		
		Mov ESI,Offset V1
		Mov EBX,Offset V2
		Mov EAX,0
		
		Mov ECX,tamv1
		ciclo:
			Push ECX
				
				
				Mov ECX,tamv2
				ciclo2:
					push ECX
					
					Mov ECX,[EBX]
					ciclo3:
					
						Mov EDX,[ESI]
						Add EAX,EDX
						
					Loop ciclo3						
					
					Add EBX,4
					
					pop ECX					
					
				Loop ciclo2
					
					Add ESI,4
					
				Mov EBX,Offset V2
			
			Pop ECX
		
		Loop ciclo
		
		pushad
		printf("%d",EAX)
		popad
		inkey
		invoke ExitProcess,0
	
	End main
	