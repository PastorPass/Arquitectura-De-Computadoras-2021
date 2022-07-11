.data
  CONTROL: .word32 0x10000
  DATA: .word32 0x10008
  ingresar: .asciiz "Ingrese Clave: "
  bien: .asciiz "Bienvenido.\n"
  mal: .asciiz "ERROR\n"
  leida: .byte 0,0,0,0,0
  clave: .asciiz "hola"
.code
  daddi $sp, $0, 0x400
  daddi $a0, $0, ingresar
  jal mostrar
  daddi $a0, $0, leida
  jal leeclave
  daddi $a0, $0, leida
  jal check
  dadd $a0, $0, $v0
  jal respuesta
  halt
  
  mostrar: lwu $t1, CONTROL($0) ; $t1 = dirección de CONTROL
		   lwu $t2, DATA($0) ; $t2 = dirección de DATA
		   sd $a0, 0($t2) ; DATA recibe el puntero al comienzo del mensaje
		   daddi $t0, $0, 4 ; $t0 = 4 -> función 4: salida de una cadena ASCII
		   sd $t0, 0($t1)
		   jr $ra
  char: lwu $t1, CONTROL($0) ; $t1 = dirección de CONTROL
		lwu $t2, DATA($0) ; $t2 = dirección de DATA
		daddi $t0, $0, 9
		sd $t0, 0($t1)
		ld $v0, 0($t2)
		jr $ra
  leeclave: daddi $sp, $sp, -24
			sd $ra, 0($sp)
			sd $s0, 8($sp)
			sd $s0, 16($sp)
			daddi $s0, $0, 4
			dadd $s1, $0, $a0
  loop_lee: jal char
			sb $v0, 0($s1)
			daddi $s1, $s1, 1
			daddi $s0, $s0, -1
			bnez $s0, loop_lee
			ld $ra, 0($sp)
			ld $s0, 8($sp)
			ld $s1, 16($sp)
			daddi $sp, $sp, 24
			jr $ra
  check: dadd $v0, $0, $0
		 lwu $t0, 0($a0)
		 lwu $t1, clave($0)
		 bne $t0, $t1, distinta
		 daddi $v0, $v0, 1
  distinta: jr $ra
  respuesta: beqz $v0, imp_error
			 daddi $t0, $0, bien
			 j impr
  imp_error: daddi $t0, $0, mal
  impr: lwu $t1, DATA($0) ; $t1 = dirección de CONTROL
		sd $t0, 0($t1)
		daddi $t3, $0, 4
		lwu $t2, CONTROL($0) ; $t2 = dirección de DATA
		sd $t3, 0($t2)
		jr $ra