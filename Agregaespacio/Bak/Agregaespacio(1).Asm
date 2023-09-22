Title "separa cadenas"
.386
.Model flat,stdcall
include masm32rt.inc
.Data
	
	cadena Byte "jesusmanuel",0
	longitud = ($-cadena)-1
	vector Dword 3,6,7,9
	longw = ($-vector)/4
	palabras Byte (longitud + longw) Dup(0)
	longp = ($-palabras)
	valor Dword 0
	
.Code
	
	main:
	
		Mov ESI,Offset cadena
		Mov EDI,Offset palabras
		Mov ECX,longw
		Mov EDX,Offset vector
	
		ciclo:
		
			Mov EAX,[EDX]
			push ECX
			
			Sub EAX,valor
			Mov ECX,EAX
			push EAX
			push EDX
		
			ciclo2:
			
				Mov BL,Byte ptr[ESI]
				Mov [EDI],BL
				Inc ESI
				Inc EDI
			
			Loop ciclo2
			
			Mov AL,20h
			Mov [EDI],AL
			Inc EDI
			pop EDX
			pop EAX
			pop ECX
			Add EDX,4
			Mov valor,EAX
		Loop ciclo
	
		Mov EAX,ESI
		mov EDX, offset cadena
		sub EAX,EDX
		Mov EBX,longitud
		;Add EAX,EBX
		Sub EBX,EAX
		
		Mov ECX,EBX	
		ciclo3:
		
			Mov BL, Byte ptr[ESI]
			Mov [EDI],BL
			Inc ESI
			Inc EDI
	
		Loop ciclo3
		
		Mov ESI,Offset palabras
		Mov ECX,longp
		ciclo4:
			
			push ECX
			Mov AL,Byte ptr[ESI]
			printf("%c",EAX)
			Inc ESI		
			pop ECX
		
		Loop ciclo4
		printf("\n")
	inkey
	invoke ExitProcess,0
	End main
	
	