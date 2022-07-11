.data
  cadena1: .asciiz "abc"
  cadena2: .asciiz "abc"
  Poscads: .word 0
.code
  daddi $a0, $0, cadena1  ; $a0 = dir de cadena1
  daddi $a1, $0, cadena2  ; $a1 = dir de cadena2
  jal Recorrer   
  sd $v0, Poscads($0) ; guardo el valor que se haya cargado en $v0 a la variable Poscads
  halt
  
  Recorrer: dadd $v0, $0, $0 ; $v0 = 0 (inicializa)
		    loop: lbu $t0, 0($a0)  ; $t0 = 1er elemento de la cadena1
				  lbu $t1, 0($a1)  ; $t0 = 1er elemento de la cadena2
				  beqz $t0, fin_a0  ; compara ,si el elemento en la cadena1 es cero, salta a fin_a0
				  beqz $t1, final   ; compara, si el elemento en la cadena2 es cero, salta a final
				  nop
				  bne $t0, $t1, final  ; si ambos elemento en $tn no son iguales ,salto a final
				  
				  ;los elementos en las cadenas son iguales , then:
				  daddi $v0, $v0, 1  ; sumo +1 (sirve como posicion) hasta que los elementos de las cadenas difieran
				  daddi $a0, $a0, 1 ; sumo +1, ya que es un byte por cada caracter de la cadena
				  daddi $a1, $a1, 1
				  j loop
   fin_a0: bnez $t1, final
		   daddi $v0, $0, -1
   final: jr $r 