Title "cuenta palabra"
.386
.Model flat,stdcall
include masm32rt.inc
cuentaP proto,tam: Byte,Dir:ptr Byte
.Data
	
	palabra Byte "hola Jesus Manuel",0
	tmp = ($-palabra)

.Code
	Main proc
	
		invoke cuentaP, tmp, Addr palabra
		
		printf("%d",EAX)
		
		inkey
		ret

	Main endp
	
	cuentaP proc,tam: Byte,Dir:ptr Byte
		Mov EBX,0		
		Mov ESI,Dir
		Movzx ECX,tam
		ciclo1:
			Mov AL,[ESI]
			CMP AL,20H
			JE cuenta
			JNE sigue
			
			cuenta:
				Inc EBX
				JMP sigue
				
			sigue:
				Inc ESI
								
		Loop ciclo1
		Inc EBX
		Mov EAX,EBX			
		
		
		ret

	cuentaP endp
	
	end Main