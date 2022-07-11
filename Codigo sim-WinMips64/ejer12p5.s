.data
  valor: .word 10
  result: .word 0
.text
  daddi $sp, $zero, 0x400 ; Inicializa puntero al tope de la pila ;(1)
  ld $a0, valor($zero)
  jal factorial
  sd $v0, result($zero)
  halt

  factorial: daddi $sp, $sp, -16
			 sd $ra, 0($sp)
			 sd $s0, 8($sp)
			 beqz $a0, fin_rec
			 dadd $s0, $0, $a0
			 daddi $a0, $a0, -1
			 jal factorial
			 dmul $v0, $v0, $s0
		     j fin
  fin_rec: daddi $v0, $0, 1
  fin: ld $s0, 8($sp)
	   ld $ra, 0($sp)
       daddi $sp, $sp, 16
	   jr $ra