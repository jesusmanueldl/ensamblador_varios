Title "Encriptado"
.386
.Model flat,stdcall
include masm32rt.inc

.Data

	cadena Byte "ana",0		;mensaje que sera codificado
	tamCadena = ($-cadena)-1
	vecEncriptador Byte 1,3,6		;lista de los letras qeu seran utilizadas para codificrls
	tamVector = ($-vecEncriptador)	;que debera ser del mimo tamaño que el mensaje
	abcdario Byte "abcdefghijklmnñopqrstuvwxyz",0
	tamacbd = ($-abcdario)-1
	mensaje Byte tamCadena Dup(0)
	
.Code
	
	main:
			
		
		Mov EDI,Offset mensaje
		Mov EDX,Offset vecEncriptador
		
		Mov ECX,tamVector
		ciclo:
			push ECX
			
			Mov ESI,Offset abcdario		;mi primera posi
			Mov AL,Byte ptr[EDX]		;obtngo el peimer elemento de la lista
			Mov CL,AL
			Dec ESI	;resto uno para que empiece uno menos
			Mov ECX,ECX			
			ciclo2:	
			
				Inc ESI		;recorro el ABCdario		
				
			Loop ciclo2
				
			Mov AL,[ESI]
			Mov [EDI],AL
			Inc EDI
			Inc EDX
			
			pop ECX			
			
		Loop ciclo
		;imprimo el mensaje ya codificado
		Mov ESI,Offset mensaje
		Mov ECX,tamCadena		
		ciclo3:
			push ECX
			Mov AL,[ESI]
			printf("%c",EAX)
			
			Inc ESI
						
			pop ECX
		
		Loop ciclo3	
		
		printf("\n")
		
		inkey
		invoke ExitProcess,0	
	
	
	End main