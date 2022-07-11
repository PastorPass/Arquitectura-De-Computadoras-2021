.data 
  tablaNums: .word 5,1,2,4,7,13,0
  NumsImpares: .word 0

.code
  ; iniciar SP
  daddi $sp, $0, 0x400 
  ;ld $a0, tablaNums($0)  lo recorro inicializo en la subrutina
  jal RecorrerTabla
  sd $v0, NumsImpares($0)
  halt
  
  
  RecorrerTabla: daddi $sp,$sp,-8 ; decremento la pila (-8 bytes)
				 sd $ra, 0($sp)  ; Push (valor) en la pila - Salvado 
				 daddi $v0, $0, 0 ; $v0 = 0 (inicializo contador de numeros impares) 
				 ; usar registro temporal para dejar el numero en tal registro para comparar
				 daddi $t0, $0,0 ; t0 = 0 (registro para desplazarme en la tabla de numeros)
				 
		   loop: ld $a0, tablaNums($t0)
		         nop
		         beqz $a0,fin
				;llamo a subrutina a analizar si el numero es impar
				 jal Esimpar
				 beqz $v1, Avanzo ; si $v1 = 0 (numero par) , sigo avanzando en la tabla de numeros
				 ;sino fue par(osea el numero fue impar) , incremento contador de numeros impares +1
				 daddi $v0,$v0, 1
				 ; avanzo en la tabla de numeros
		 Avanzo: daddi $t0,$t0,8
				 j loop
				 
			fin: ld $ra, 0($sp)  ; Pop(valor) de la pila al registro $ra
				 daddi $sp, $sp, 8 ; dejo la pila en su estado inicial (+8 bytes)
		         jr $ra
				 
				 
				 Esimpar: daddi $v1,$0,0  ; $v1 = 0 (inicializo en 0, si sale en 0 es porque es numero par)
				          andi $v1,$a0,1
						  jr $ra