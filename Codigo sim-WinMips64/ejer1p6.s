.data
  CONTROL: .word32 0x10000
  DATA: .word32 0x10008
  cadena: .ascii "........."
.text
  lwu $s0, CONTROL($0) ; $s0 = dirección de CONTROL 
  lwu $s1, DATA($0)    ; $s0 = dirección de DATA 
  daddi $s4, $0, 13 ; $s4 = ASCII del enter
  loop: daddi $t1 ,$0,9
		sd $t1, 0($s0)
		lbu $t1, 0($s1)
		; comparo con el ascii del enter
		beq $t1, $s4,fin
		sb $t1, cadena($0)
		daddi $s3 , $0, cadena
		sd $s3, 0($s1)
		
		;imprimos cadena
		daddi $t1, $0, 4
		sd $t1, 0($0)
		j loop
  fin: halt