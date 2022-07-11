.data
  cadena: .asciiz "adbdcdedfdgdhdid" ; cadena a analizar
  car: .asciiz "d" ; caracter buscado
  cant: .word 0 ; cantidad de veces que se repite el caracter car en cadena.
  
.code 
  daddi r1, r0, cadena  ; r1 = 1er elemento de la cadena
  daddi r2, r0, 0  ; r2 = 0 (donde guardo la cantidad de veces que se repite el caracter en la cadena)
  ld r4, car(r0) ; r4 = caracter "d"
  loop: lbu r3,0(r1)
        nop
        ;mientras recorra la cadena y no me encuentre con un 0, sigo iterando
		beqz r3, fin
		nop
		; sino analizo el caracter
		bne r4,r3, avanzo  ; si no son iguales, avanzo en la cadena
		; si son iguales entonces sumo en r2 +1
		daddi r2,r2,1
		
		avanzo: daddi r1,r1,1
		j loop
		
  fin: sd r2,cant(r0)
  halt