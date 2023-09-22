Title "criba de arastotenes"
.386
.Model flat,stdcall
include masm32rt.inc

multiplos proto, multi: Dword
rellenaArreglo proto,num: Byte

.Data
	
	arreglo Byte 10 Dup(0)
	tamArr = ($-arreglo)
		
	
.Code
	Main proc
	
		Mov EDI,Offset arreglo
		Mov ESI,Offset arreglo
		Add EDI,2
		
		;===relleno las dos primeras posiciones del arreglo=== la 0 y la 1===
		Mov AH,1
		Mov[ESI],AH
		Inc ESI
		Mov[ESI],AH
		Inc ESI		
		
		Mov ECX,2
		ciclo:
		
			CMP ECX,9 ;verifico si ya llegue al tope de tamaño del arreglo
			JE salir
			
			Mov EBX,0
			Mov BH,[EDI]
			CMP BH,1
			JE sig2
			JNE sig5
			
			sig5:
				Mov [ESI],ECX
				Inc ESI
				invoke multiplos,ECX
				JMP sig2
			
			sig2:
				Inc ECX
				Inc EDI
				JMP ciclo			
			
			salir:
		ret

	Main endp
	;=====verifica los mutiplos de el numero===
	multiplos proc USES ECX, multi: Dword
	
		Mov EAX,multi
		Add EAX,1		
			
		Mov ECX,EAX
		ciclo2:
		
			CMP ECX,9
			JE exit1
			
			push EAX
			Mov EBX,multi
			CDQ
			Div EBX
			
			CMP EDX,0
			JE esmult
			JNE sigue
			
			esmult:			
				invoke rellenaArreglo,1
				JMP sig
			
			sigue:
				Inc ESI
				JMP sig
		sig:
			pop EAX
			Inc ECX
			Inc EAX
			JMP ciclo2
				
	exit1:
				
		ret

	multiplos endp
	
	rellenaArreglo proc,num:Byte		
		
		Mov AH,num
		CMP [ESI],AH
		JE salir3
		
		Mov AH,num
		
		Mov[ESI],AH
		Inc ESI	
			
	salir3:
		Inc ESI
		ret

	rellenaArreglo endp
	
	End Main