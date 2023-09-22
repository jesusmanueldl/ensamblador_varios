.386
.Model flat,stdcall
include masm32rt.inc
CrearArbolBinario 				proto :DWORD,:DWORD,:DWORD
CrearNodo 						proto :DWORD,:DWORD
InsertarNodoArbolBinario 		proto :DWORD,:DWORD
BuscarArbolBinario 				proto :DWORD,:DWORD
memcpy 							PROTO :DWORD,:DWORD, :DWORD
RecuperarDatoNodoArbolBinario 	proto :DWORD,:DWORD,:DWORD

TNodoHeader Struct
	lpNodo	dd ?; Puntero a nodo Raiz
	lpFunc	dd ?; Puntero a Funcion Callback de comparación 
	TamDato	dd ?; Tamaño de los datos a alojar en el Arbol
TNodoHeader ends

TNodoArbol STRUCT 
    Dato 	dd ? ; Puntero a Dato
	HijoIz 	dd ? ; Puntero a Hijo Izquierdo
	HijoDer dd ? ; Puntero a Hijo Derecho
TNodoArbol ends

.Data
	 szBufferAux 	db MAX_PATH dup (0)
	 dato Byte ?
	 lf dword ?
	cadena  Byte "abcdf",0
.Code

;**************************************************************
; lpDato:  Puntero al dato a RAIZ
; TamDato: Tamaño del tipo dato
; lpFunc:  Puntero a Función Callback
;          Tipo:     Arbol:DWORD, lpDato1:DWORD, lpDato2:DWORD
;                    retornar 0; Datos iguales
;                    retornar 1; Dato1 > Dato2
;                    retornar 2; Dato2 > Dato1 
;**************************************************************

Main proc
	
	invoke CrearArbolBinario,addr dato,1,addr lf
	Mov ESI,Offset cadena
	
	Mov ECX,5
	ciclo:
		push EAX			 	
		invoke InsertarNodoArbolBinario,EAX,ESI
		Inc ESI
		pop EAX
	Loop ciclo
		
	
	ret

Main endp

CrearArbolBinario proc lpDato:DWORD, TamDato:DWORD,lpFunc:DWORD
 LOCAL _MiArbol:DWORD
 
 
 mov ebx,TamDato
 .if ebx != 0 
    	    	    	
    	invoke LocalAlloc,LMEM_FIXED or LMEM_ZEROINIT, sizeof TNodoHeader
    	mov _MiArbol,eax
    	
    	mov esi,eax
    	
    	assume esi: ptr TNodoHeader
    		mov ebx,TamDato
    		mov [esi].TamDato,ebx
    		mov ebx,lpFunc
    		mov [esi].lpFunc,ebx
    	assume esi:NOTHING
    	
    	mov eax,lpDato
    	.if eax != NULL
    		invoke CrearNodo,lpDato,TamDato
    		.if eax !=0 
    			mov ebx,_MiArbol
  				assume ebx: ptr TNodoHeader
  					mov [ebx].lpNodo,eax
  				assume ebx:NOTHING
  				mov eax,ebx
    		.else
    			invoke LocalFree,_MiArbol
    			xor eax,eax		
    		.endif
    	.else
    		mov eax,_MiArbol
    	.endif
    .endif
  
 ret
CrearArbolBinario endp


CrearNodo proc lpDato:DWORD, TamDato:DWORD
 LOCAL MiNodo:DWORD
 
 mov eax,lpDato
 mov ebx,TamDato
 .if eax != 0 && ebx != 0 
    	push ebx
    	invoke LocalAlloc,LMEM_FIXED or LMEM_ZEROINIT, sizeof TNodoArbol
    	mov MiNodo,eax
    	
    	pop ebx
    	invoke LocalAlloc,LMEM_FIXED or LMEM_ZEROINIT,ebx
  		push eax
  			
  		mov ebx,eax
  		invoke memcpy,ebx,lpDato,TamDato
  		
  		pop eax
  		 
  		mov esi,MiNodo
  		assume esi: ptr TNodoArbol
  			mov [esi].Dato,eax
  			mov [esi].HijoIz,NULL
  			mov [esi].HijoDer,NULL
  		assume esi:NOTHING
  		
  		mov eax,MiNodo
 .else
 	xor eax,eax
 .endif
  
 ret
CrearNodo endp


InsertarNodoArbolBinario proc Arbol:DWORD, lpDato:DWORD
	LOCAL lpNodo:DWORD  ; puntero a tipo nodo
	LOCAL lpNodo2:DWORD ; Puntero a tipo nodo
	LOCAL lpNuevo:DWORD ; Nuevo nodo
	LOCAL aux:DWORD
	LOCAL FunCallBack:DWORD 	
	LOCAL TamDato:DWORD
	
	mov eax,Arbol
	.if eax !=0 
		
		assume eax: ptr TNodoHeader
			mov ebx,[eax].lpFunc
			mov FunCallBack,ebx
			mov ebx,[eax].TamDato
			mov TamDato,ebx
			mov eax,[eax].lpNodo	; Tomamos el nodo de Cabecera
		assume eax:NOTHING
		
	
		.if eax ==0 
			; Tenemos Nodo cabecera pero no Nodos de datos
			; Nodo Raiz vacio lo volvemos a crear
			
			invoke CrearNodo,lpDato,TamDato
				
			.if eax !=0
					
				mov ebx,Arbol
				assume ebx: ptr TNodoHeader
					mov [ebx].lpNodo ,eax
				assume ebx:NOTHING
				mov eax,1; OK
			.endif
			
		.else
			
			; Verificamos que el dato no se encuentre ya en el Arbol, en se caso salimos con error
			mov lpNodo,eax ; Apunta al Raiz del Arbol

InsertarNodoArbolBinario_B_otro:		
			mov ecx,lpNodo
			cmp ecx,0
			je InsertarNodoArbolBinario_B_Fin
			
				mov lpNodo2,ecx
				assume ecx: ptr TNodoArbol
					mov ecx,[ecx].Dato
				assume ecx:NOTHING
				
				push lpDato
				push ecx
				push Arbol
				;call FunCallBack
				
		;		.if eax == 0
		;			mov aux,0 ; Error
		;			jmp InsertarNodoArbolBinario_B_Fin
			;	.elseif eax == 1 ; Dato1 > Dato2
					mov esi,lpNodo
					assume esi: ptr TNodoArbol
						mov esi,[esi].HijoIz
					assume esi: NOTHING
					mov lpNodo,esi
					mov aux,1
				.else  ; Dato 1 < Dato 2
				
					mov esi,lpNodo
					assume esi: ptr TNodoArbol
						mov esi,[esi].HijoDer
					assume esi: NOTHING
					mov lpNodo,esi
					mov aux,2
									 
				.endif	
			jmp InsertarNodoArbolBinario_B_otro
		

InsertarNodoArbolBinario_B_Fin:		
			.if aux == 1
				invoke CrearNodo,lpDato,TamDato
				.if eax !=0
					
					mov ebx,lpNodo2
					assume ebx: ptr TNodoArbol
						mov [ebx].HijoIz,eax
					assume ebx:NOTHING
					mov eax,1; OK
				.endif	
			.elseif aux == 2
				
				invoke CrearNodo,lpDato,TamDato
				.if eax !=0
					
					mov ebx,lpNodo2
					assume ebx: ptr TNodoArbol
						mov [ebx].HijoDer,eax
					assume ebx:NOTHING
					mov eax,1; OK
				.endif
			.else
				xor eax,eax ; Error 
			.endif
		
		.endif
	.endif	
	ret

InsertarNodoArbolBinario endp

BuscarArbolBinario proc Arbol:DWORD, lpDato:DWORD
	LOCAL func:DWORD
	LOCAL lpNodo:DWORD
	LOCAL Return:DWORD
	
	mov Return,0
	
	mov eax,Arbol
	.if eax != 0
		
		assume eax: ptr TNodoHeader
			mov ebx,[eax].lpFunc
			mov func,ebx
			mov edx,[eax].lpNodo
			mov lpNodo,edx
		assume eax:NOTHING
		
		.if edx !=0 && ebx != 0
			
BuscarArbolBinario_otro:
			mov esi,lpNodo
			assume esi: ptr TNodoArbol
				mov edx,[esi].Dato
			assume esi:NOTHING
				
			push lpDato
			push edx  ; Dato 
			push Arbol
			call func
			
			.if eax == 1
				mov esi,lpNodo
				assume esi: ptr TNodoArbol
					mov esi,[esi].HijoIz
				assume esi: NOTHING
				
				.if esi != NULL
					mov lpNodo,esi
					jmp BuscarArbolBinario_otro
				.endif
			.elseif eax == 2
				
				mov esi,lpNodo
				assume esi: ptr TNodoArbol
					mov esi,[esi].HijoDer
				assume esi: NOTHING
				.if esi != NULL
					mov lpNodo,esi
					jmp BuscarArbolBinario_otro
				.endif	
			.else
				mov eax,lpNodo
				mov Return,eax
			.endif
			
		.endif		
	.endif
	
	mov eax,Return
	
	ret

BuscarArbolBinario endp

memcpy PROC Des:DWORD,Src:DWORD, Len:DWORD
	
    push ecx
    push esi
    push edi
    cld		; set direction flag forward
    mov esi, Src	; put address into the source index
    mov edi, Des	; put address into the destination index

    mov ecx, Len	; put the number of bytes to copy in ecx
  ; --------------------------------------------------
  ; repeat copying bytes from ESI to EDI until ecx = 0
  ; --------------------------------------------------
    rep movsb		

    pop edi
    pop esi
    pop ecx
	
	ret

memcpy endp

RecuperarDatoNodoArbolBinario proc Arbol:DWORD,lpNodo:DWORD,lpDato:DWORD
	
	mov esi,Arbol
	mov edi,lpNodo
	mov ebx,lpDato
		
	.if esi != NULL && edi != 0 && ebx != 0
		
		assume edi: ptr TNodoArbol
			mov edi,[edi].Dato
		assume edi:NOTHING
		
		assume esi: ptr TNodoHeader
			mov esi,[esi].TamDato
		assume esi:NOTHING
		
		invoke memcpy,lpDato,edi,esi	
		mov eax,1	
	.else
		xor eax,eax
	.endif
	
	ret
RecuperarDatoNodoArbolBinario endp

End Main
