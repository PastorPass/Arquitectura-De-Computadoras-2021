.data
  cadena: .asciiz "adbdcdedfdgdhdid" ; cadena a analizar
  car: .asciiz "a" ; caracter buscado
  cant: .word 0 ; cantidad de veces que se repite el caracter car en cadena.
  
.code 
  daddi r1, r0, cadena  ; r1 = 1er elemento de la cadena
  daddi r2, r0, 0  ; r2 = 0 (donde guardo la cantidad de veces que se repite el caracter en la cadena)
  daddi r4,r0,car ; r4 = caracter "d"
  loop: lbu r3,0(r1)
  
        ;mientras recorra la cadena y no me encuentre con un 0, sigo iterando
		beqz r3, fin
		
		;analizo el caracter de la cadena, si "d" es igual al 1er elemento de la cadena entonces sumo
		beq r4,r3, sumo
	    j avanzo
		sumo: daddi r2,r2,1
		        ; avanzo en la cadena
	    avanzo: daddi r1,r1,1
		j loop
  fin: sd r2,cant(r0)
  halt