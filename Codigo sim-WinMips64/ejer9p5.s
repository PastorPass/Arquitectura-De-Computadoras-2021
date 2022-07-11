.data
  letra: .ascii "u"
  vocales: .asciiz "AEIOUaeiou"   ; tabla de vocales(en may y en min)
  ok: .word 0 ; si es 1 = el caracter fue una vocal(ya sea mayuscula o minuscula), 0 en caso contrario
.code
  ld $a0, letra($0)
  jal Esvocal
  sd $v0, ok($0)
  halt
  
  Esvocal: dadd $v0, $0, $0   ; $v0 = 0 (inicializo, con que el caracter no fue vocal)
		   daddi $t0, $0, 0  ; $t0 = 0 (inicializo el desplazamiento que sirve para desplazarme en la tabla de vocales)
		   loop: lbu $t1, vocales($t0) ; $t1 = 1er vocal de la tabla de vocales
			     beqz $t1, fin_vocal  ; $t1 = 0 , salto a  fin_vocal (termine de recorrer todas las vocales de la tabla)
				 beq $a0, $t1, si_es_voc ; $a0(letra) = $t1 (vocal de la tabla) , salto a si_es_voc 
				 
				 ; sino fue vocal , entonces :
				 daddi $t0, $t0, 1 ; +1 al desplazamiento para seguir analizando la letra con la tabla de vocales
				 j loop
  si_es_voc: daddi $v0, $0, 1 ; dejo un 1 porque encontre que la letra coincida con una vocal de la tabla
  fin_vocal: jr $ra