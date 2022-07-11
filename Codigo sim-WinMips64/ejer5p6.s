.data
  CONTROL: .word32 0x10000
  DATA: .word32 0x10008
  ingreso_base: .asciiz "Ingrese Base: "
  ingreso_exponente: .asciiz "Ingrese Exponente: "
  resultado: .asciiz "El resultado es: "
.code
  daddi $sp, $0, 0x400 ; Inicializa el puntero al tope de la pila
  jal lee_base
  dadd $s0, $v0, $0
  jal lee_exponente
  dadd $a0, $s0, $0
  dadd $a1, $v0, $0
  jal a_la_potencia
  dadd $s0, $v0, $0
  daddi $a0, $0, resultado
  jal muestra_entero  ;jal muestra
  jal muestra_cadena
  dadd $a0, $0, $s0
  jal muestra_flotante
  halt
  
  lee_base: daddi $sp, $sp, -8
			sd $ra, 0($sp)
			daddi $a0, $0, ingreso_base
			jal muestra_cadena
			jal lee_numero
			dadd $a0, $v0, $0
			jal muestra_flotante
			ld $ra, 0($sp)
			daddi $sp, $sp, 8
			jr $ra
			
  lee_exponente: daddi $sp, $sp, -8
				 sd $ra, 0($sp)
				 daddi $a0, $0, ingreso_exponente
				 jal muestra_cadena
				 jal lee_numero
				 dadd $a0, $v0, $0
				 jal muestra_entero
				 ld $ra, 0($sp)
				 daddi $sp, $sp, 8 
				 jr $ra
				 
  a_la_potencia: daddi $t1, $0, 1
				 mtc1 $t1, f0
				 cvt.d.l f0, f0
				 mtc1 $a0, f1
				 ciclo: beqz $a1, final
				 mul.d f0, f0, f1
				 daddi $a1, $a1, -1
				 j ciclo
		  final: mfc1 $v0, f0
				jr $ra
				
  muestra_entero: lwu $t2, CONTROL($0) ; $t2 = dirección de CONTROL
				  lwu $t3, DATA($0) ; $t3 = dirección de DATA
				  sd $a0, 0($t3) ; DATA recibe el puntero al comienzo del mensaje
				  daddi $t0, $0, 1 ; $t0 = 1 -> función 1:
				  ;salida de un entero sin signo
				  sd $t0, 0($t2)
				  jr $ra
				  
  muestra_flotante: lwu $t2, CONTROL($0) ; $t2 = dirección de CONTROL
					lwu $t3, DATA($0) ; $t3 = dirección de DATA
					sd $a0, 0($t3) ; DATA recibe el puntero al comienzo del mensaje
					daddi $t0, $0, 3 ; $t0 = 3 -> función 3: salida de un flotante
					sd $t0, 0($t2)
					jr $ra
					
  muestra_cadena: lwu $t2, CONTROL($0) ; $t2 = dirección de CONTROL
				  lwu $t3, DATA($0) ; $t3 = dirección de DATA
				  sd $a0, 0($t3) ; DATA recibe el puntero al comienzo del mensaje
				  daddi $t0, $0, 4 ; $t0 = 4 -> función 4: salida de una cadena ASCII
				  sd $t0, 0($t2)
				  jr $ra
				  
  lee_numero: lwu $t2, CONTROL($0) ; $t2 = dirección de CONTROL
			  lwu $t3, DATA($0) ; $t3 = dirección de DATA
			  daddi $t0, $0, 8 ; $t0 = 8 -> función 8: leer entero o flotante
			  sd $t0, 0($t2)
			  ld $v0,  0($t3)
			  jr $ra