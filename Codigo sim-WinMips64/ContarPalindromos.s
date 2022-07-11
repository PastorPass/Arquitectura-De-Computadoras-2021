; El ejemplo cuenta cuantos palindromos hay en un texto dado. Un palindromo es una palabra que se lee igual hacia adelante
; que hacia atras.

.data
  texto: .asciiz "Nos sometemos a problemas si se usa un radar para reconocer ese oso azul"

.code
  daddi $sp, $0, 0x400   ; La pila comienza en el tope de la memoria de datos 
  daddi $a0, $0, texto
  jal contar_palindromos
  halt
  
; Cuenta cuantos palindromos hay en un texto dado. Recibe en $a0 la direccion del comienzo del texto (terminado en 00)
; Devuelve en $v0 la cantidad de palindromos encontrados.

  contar_palindromos: daddi $sp, $sp, -48
					  sd $ra, 0($sp)
					  sd $s0, 8($sp)
					  sd $s1, 16($sp)
					  sd $s2, 24($sp)
					  sd $s3, 32($sp)
					  sd $s4, 40($sp)
					  dadd $s0, $a0, $0    ; $s0 apunta al comienzo de una palabra
					  dadd $s1, $a0, $0    ; $s1 apuntara al final de la palabra
					  daddi $s2, $0, 32     ; $s2 contiene el codigo ASCII del espacio en blanco
					  dadd $s4, $0, $0	   ; $s4 cuenta cuantos palindromos se encontraron
			 while1:  lbu $s3, 0($s1)
			 while2:  daddi $s1, $s1, 1
					  dadd $a0, $s0, $0
					  daddi $a1, $s1, -2
					  beqz $s3, procesa        ;Si se acabo la cadena , procesa la ultima palabra
					  bne $s3, $s2, while1	   ;Si no es un espacio, busca el siguiente caracter 
			procesa:  jal es_palindromo        ; si es palindromo, devuelve 1, sino 0
					  dadd $s4, $s4, $v0       ; Sumo el resultado al contador de palindromos
					  beqz $s3, terminar       ; Si se acabo la cadena, termina
	 saltea_blancos:  dadd $s0, $s1, $0
					  lbu $s3, 1($s1)
					  daddi $s1, $s1, 1
					  beqz $s3, terminar
					  bne $s3, $s2, while2
					  j saltea_blancos
			terminar: dadd $v0, $s4, $0
					  ld $ra, 0($sp)
					  ld $s0, 8($sp)
					  ld $s1, 16($sp)
					  ld $s2, 24($sp)
					  ld $s3, 32($sp)
					  ld $s4, 40($sp)
					  daddi $sp, $sp, 48
					  jr $ra
					  
; Determina si una palabra es palindromo. Recibe en $a0 la direccion del comienzo de la palabra y en $a1 la direccion
; del final de la palabra. Devuelve 1 en $v0 si es palindromo o 0 si no lo es.

  es_palindromo: dadd $v0, $0, $0
		   lazo: lbu $t0, 0($a0)
				 daddi $a0, $a0, 1
				 lbu $t1, 0($a1)
				 daddi $a1, $a1, -1
				 slt $t2, $a1, $a0
				 bne $t0, $t1, no_es
				 beqz $t2, lazo
				 daddi $v0, $v0, 1
		 no_es:  jr $ra