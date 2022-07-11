; El siguiente ejemplo sencillo convierte una cadena de caracteres a caracteres en Mayusculas :
.data
  cadena: .asciiz "Caza"

.text 			;(o .code)
  daddi $sp, $0, 0x400   ; la pila comienza en el tope de la memoria de datos
  daddi $a0, $0, cadena  ; Guarda como 1er argumento para UpcaseStr
  jal UpcaseStr
  halt
  
; Pasar una cadena a mayuscula
; Parametros : $a0 --> inicio de la cadena
; Se utiliza la pila para guardar :
;		$ra --> Porque se invoca a otra subrutina
;		$s0 --> Para guardar la direccion de inicio de la cadena y recorrerla

  UpcaseStr: daddi $sp, $sp, -16  ; Reserva lugar en la pila
			 sd $ra, 0($sp)
			 sd $s0, 8($sp)
			 dadd $s0, $a0, $0  ; copia la direccion de incio de la cadena
	   loop: lbu $a0, 0($s0)    ; Recupera el caracter actual y lo pone como argumento para upcase
			 beq $a0, $0, fin   ; Si es el fin de la cadena, termina
			 jal upcase
			 sb $v0, 0($s0)     ; Guarda el caracter procesado en la cadena
			 daddi $s0, $s0, 1  ; Avanza al siguiente caracter
			 j loop
		fin: ld $ra, 0($sp)
			 ld $s0, 8($sp)
			 daddi $sp, $sp, 16
			 jr $ra
			 
; Pasar un caracter a mayuscula
; Parametros $a0 --> Caracter
;			 $v0 --> caracter en mayuscula
; No se utiliza la pila porque no se usan registros que deban ser salvados

  upcase: dadd $v0, $a0, $0
		  slti $t0, $v0, 0x61  ; Compara con "a" minuscula
		  bnez $t0, salir      ; No es un caracter en minuscula
		  slti $t0, $v0, 0x7b  ; Compara con el caracter siguiente a "z" minuscula (z = 7AH)
		  beqz $t0, salir      ; No es un caracter en minuscula
		  daddi $v0, $v0, -0x20  ; Pasa a minuscula (pone a "0" el 6to bit)
   salir: jr $ra   				; Retorna al p.p