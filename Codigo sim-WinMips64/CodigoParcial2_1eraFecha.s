;1) Implementar  una subrutina INGRESAR_NUMERO. La misma deberá solicitar el ingreso por teclado de un número entero del 1 al 9.
;Si el número ingresado es un número válido entre 1 y 9 la subrutina deberá imprimir por pantalla el número ingresado y retornar
;dicho valor. En caso contrario,  la subrutina deberá  imprimir por pantalla  “Debe ingresar un número” y devolver el valor 0.
 
;Usando la subrutina INGRESAR_NUMERO implementar un programa que invoque a dicha subrutina y genere una tabla llamada NUMEROS
;con los valores ingresados. La generación de la tabla finaliza cuando la suma de los resultados obtenidos  sea mayor o igual 
;a los últimos 3 dígitos de su número mágico.  

;Al finalizar la generación de la tabla, deberá invocar a la subrutina PROCESAR_NUMEROS.  
;Se debe usar la convención para nombrar a los registros. 
;Para todos los casos, la subrutina PROCESAR_NUMEROS debe devolver el valor calculado y desde el programa principal el mismo
;se debe almacenar en la dirección RESULTADO.

;SI SU NUMERO MÁGICO TERMINA CON 0, 1 o 2: la subrutina PROCESAR_NUMEROS debe recibir como parámetro la dirección de la tabla
;NUMEROS y la cantidad de elementos y contar la cantidad de números impares ingresados.
;Se debe mostrar por pantalla el valor calculado, con el texto "Cantidad de Valores Impares: “ y el valor.

.data
  TresDigitos: .word 45   ; XXX (ultimos 3 digitos de mi numero magico)  ; o usar su valor inmediato  (linea 51)
  dir_control: .word 0x10000
  dir_data: .word 0x10008
  resultado: .word 0
  num: .word 0
  str: .asciiz "debe ingresar un numero "
  texto: .asciiz "cantidad de valores impares : " 
  numeros: .word 0
  
.code
  ld $t6, dir_control($0)
  ld $t7, dir_data($0)

  ;inicializo desplazamiento
  daddi $t8, $t8, 0
  ;inicializo el contador $s0 para la suma de numeros
  daddi $s0, $0, 0
  ;inicializo el contador $s1 para la cantidad de elementos que cargo en la tabla de numeros (es para la 2da subrutina)
  daddi $s1, $0, 0
  
  loop: jal ingresar_numero
		sd $v0, num($0)
		
		;sumo +1 la cantidad de elemento que voy cargando en la tabla de numeros
		daddi $s1, $s1, 1
		
        ;REINICIO  REGISTRO $T9
		daddi $t9, $0, 0
		
		;Generar tabla  
		sd $v0, numeros($t8)
		daddi $t8, $t8, 8
		
		;suma los numeros leidos
		dadd $s0,$s0,$v0
		slti $t9, $s0, 45     ;  si $s0(suma) < 100 entonces -->  $t9 = 1  
		bnez $t9, loop
;-----------------hasta aca todo bien----------------------------

  ;paso parametros a la subrutina procesar_numeros
  daddi $a0, $0, numeros  ; $a0 = direccion de la tabla de numeros
  dadd $a1, $0, $s1  ; $a1 = cantidad de elementos en la tabla de numeros  
  
  ; iniciar SP
  daddi $sp, $0, 0x400 
  
  ;llamado a subrutina procesar numeros
  jal procesar_numeros
  sd $v1, resultado($0)  ; $v1 = devuelvo a variable resultado ,cantidad de elementos impares de la tabla de numeros
  
  ; Imprimir mensaje "cantidad de valores impares : "
					daddi $t3, $0, texto
					sd $t3, 0($t7)
					
					;codigo de imprimir str
					daddi $t5, $0, 4
					sd $t5, 0($t6)
					
  ;imprimir cantidad de numeros impares encontrados (valor calculado)
  ld $a3, resultado($0)  ; saco el resultado (cantidad de numeros impares en la tabla de numeros) y lo alojo en $a3
  sd $a3, 0($t7)  ; guardo en data
  daddi $a2, $0,1  ;cod imprimir numero sin signo
  sd $a2, 0($t6)  ; guardo en control 
  halt
  
  procesar_numeros: daddi $sp,$sp,-8 ; decremento la pila (-8 bytes)
				    sd $ra, 0($sp)  ; Push (valor) en la pila - Salvado
					daddi $v1, $0, 0 ; $v1 = 0 (inicializo contador de numeros impares)
					daddi $t9,$0,0  ; inicializo $t9 (registro que sirve para ver si el numero salio par o impar)
					daddi $t0, $0,0 ; $t0 = 0 (inicializo registro para desplazarme en la tabla de numeros)
  
		   	 itero: ld $a0, numeros($t0)
					;llamo a subrutina a analizar si el numero es impar
				    jal Esimpar
					beqz $t9, continuo ; si $t9 = 0 (numero par) , sigo avanzando en la tabla de numeros
			   	    ;sino fue par(osea el numero fue impar) , incremento contador de numeros impares +1
				    daddi $v1,$v1, 1
		  continuo: daddi $t0,$t0,8
					
					;decremento el for
					daddi $a1, $a1, -1
					bnez  $a1, itero
					
			        ld $ra, 0($sp)  ; Pop(valor) de la pila al registro $ra
				    daddi $sp, $sp, 8 ; dejo la pila en su estado inicial (+8 bytes)
		            jr $ra
					
					;subrutina Esimpar
					Esimpar: daddi $t9,$0,0  ; $t9 = 0 (inicializo en 0, si sale en 0 es porque es numero par)
						     andi $t9,$a0,1	
						     jr $ra
	
  ingresar_numero: 
				    ;Paso codigo 8 a control
					daddi $t0, $0, 8
					sd $t0, 0($t6) ; le paso el valor 8 a control (codigo para leer un numero de teclado
					;(espera a que se ingrese un numero de teclado, se guarda en data)
  
					;almaceno en $t1 el valor ingresado
					ld $t1, 0($t7)
					
					;analizo si es un numero del 1 al 9
					slti $t9, $t1, 10 ;						
				    beqz $t9, salir
					
					;paso el numero 1 a un registro para comparar con un slt
					daddi $t2, $0, 0; cambio de 1 a 0( a ver si toma el 1)
					slt $t9, $t2, $t1 
					beqz $t9, salir

					;Mientras sea un numero :
					dadd $v0, $0, $t1
					
					;si llego hasta aca es porque es un numero valido
					;imprimir numero
					daddi $t5, $0, 1
					sd $t5, 0($t6) ; paso el codigo 1 a control (se imprime un numero)
					j fin
					
			 salir: daddi $v0, $0, 0  
			        ;imprimir mensaje de "debe ingresar un numero"
					daddi $t3, $0, str
					sd $t3, 0($t7)
					
					;codigo de imprimir str
					daddi $t5, $0, 4
					sd $t5, 0($t6)
			   fin: jr $ra	