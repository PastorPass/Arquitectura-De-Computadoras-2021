.data
  dir_control: .word 0x10000
  dir_data: .word 0x10008

.code
  ld $t6,dir_control($0)
  ld $t7,dir_data($0)
  jal Ingreso
  nop
  jal Resultado
  halt
  
  Ingreso: daddi $t0, $0,8 ; Leer Numero
  
			;Leer 2 numeros
			sd $t0, 0($t6)
			ld $t1, 0($t7) ; Leo num1
			sd $t0, 0($t6)
			ld $t2, 0($t7) ; Leo num2 
			
			;sumo valores
			dadd $v0,$t1,$t2
			jr $ra

  Resultado: sd $v0, 0($t7) ; guardo valores
			;Imprimo
			daddi $t5, $0, 1
			sd $t5, 0($t6) 
			jr $ra 