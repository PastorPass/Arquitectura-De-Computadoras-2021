.data
  CONTROL: .word32 0x10000
  DATA: .word32 0x10008
  sale: .byte 0x20 ; Sale con espacio
  cero: .byte 0x30
  nueve: .byte 0x39
  letras: .asciiz "CERO "
		  .asciiz "UNO "
		  .asciiz "DOS "
		  .asciiz "TRES "
		  .asciiz "CUATRO "
		  .asciiz "CINCO "
		  .asciiz "SEIS "
		  .asciiz "SIETE "
		  .asciiz "OCHO "
		  .asciiz "NUEVE "
.code
  daddi $s0, $0, -1
  salto: jal ingreso
  beq $s0, $v0, final
  dadd $a0, $0, $v0
  jal muestra
  j salto
  final: halt
  ingreso: lwu $t2, CONTROL($0) ; $t2 = dirección de CONTROL
		   lwu $t3, DATA($0) ; $t3 = dirección de DATA
		   lbu $t4, cero($0)
		   lbu $t5, nueve($0)
		   lbu $t7, sale($0)
		   daddi $t0, $0, 9
    sigue: sd $t0, 0($t2)
		   ld $t1, 0($t3)
		   bne $t7, $t1, comp
		   daddi $v0, $0, -1
		   j fin_ing
  comp: slt $t6, $t1, $t4
  bnez $t6, sigue
  slt $t6, $t5, $t1
  bnez $t6, sigue
  daddi $v0, $t1, -0x30
  fin_ing: jr $ra
  muestra: lwu $t2, CONTROL($0) ; $t2 = dirección de CONTROL
		   lwu $t3, DATA($0) ; $t3 = dirección de DATA
		   dsll $t1, $a0, 3
		   daddi $t0, $t1, letras
		   sd $t0, 0($t3) ; DATA recibe el puntero al comienzo del mensaje
		   daddi $t0, $0, 4 ; $t0 = 4 -> función 4: salida de una cadena ASCII
		   sd $t0, 0($t2) ; CONTROL recibe 4 y produce la salida del mensaje
		   jr $ra