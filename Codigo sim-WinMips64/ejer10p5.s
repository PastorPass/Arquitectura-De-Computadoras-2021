.data
  vocales: .asciiz "aeiou"   ; tabla de vocales(en may y en min)
  cadena: .asciiz "inavowanwowqxa"
  cantVocalesEnCad: .word 0
  
.code
  daddi $a0, $0, vocales 
  daddi $a1, $0, cadena
  jal ContarVocales
  sd $v0, cantVocalesEnCad($0)
  halt
  
  ContarVocales: dadd $v0, $0, $0   ; $v0 = 0 (inicializo el contador para la cantidad de vocales en cadena)
		   dadd $s0, $s0,$a0  ; copia 
	       loop: lbu $t1, 0($a1)  ; $t1 = 1er elemento de la cadena de caracteres a analizar
				 beqz $t1, fin_letras ; $t1 = 0 ,salto a fin
				 
				 ; reinicio $a0
				 daddi $a0, $0,0
				 dadd $a0, $0,$s0
				 
			loop2: lbu $t0, 0($a0) ; $t0 = 1er vocal de la tabla de vocales
				 ; compara el 1er elemento de la cadena con la 1er vocal de la tabla
		         beq $t0, $t1, contarVocal
				 
				 ; sino fue vocal , entonces :

				 daddi $a0, $a0, 1 ; avanzo en la cadena de vocales
				 lbu $t0, 0($a0)
				 ; si termine de recorrer y comparar con la cadena de vocales(llegue a cero), avanzo en la cadena de letras
				 beqz $t0, avanzoLetra
				 j loop2
				 
				 contarVocal: daddi $v0,$v0, 1
							  ;avanzo en la cadena de caracteres a analizar
				 avanzoLetra: daddi $a1, $a1,1
							  j loop
							  
  fin_letras: jr $ra