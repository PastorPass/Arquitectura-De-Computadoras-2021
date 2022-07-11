.data 
  tabla: .word 1,7,4,13,2,6,0,1,1,1
  cant: .word 10
  num: .word 5
  cantMayoresQueNum: .word 0
  
.code
  ld $a0, num($0)  ; $a0 = 5 (el numero a analizar)
  daddi $a1, $0,tabla ; $a1 =  direccion de tabla
  ld $a2, cant($0)  ; $a2 = 10 (cantidad de valores que hay en la tabla)
  jal mayorQueNum
  sd $v0, cantMayoresQueNum($0)
  halt
  
  mayorQueNum: ;hago una copia de la dir de la tabla en $s0
			   dadd $s0,$a1,$zero  ; $s0 = copia de dir de tabla
			   
			   ;cargo con la copia de direccion de tabla, el 1er elemento en $t0
		 loop: ld $t0, 0($s0) ; $t0 = 1er elemento de la tabla
			   nop
			   ;comparo
			   slt $t1, $a0,$t0	 ; si 5 < 1er elem de tabla entonces $t1 = 1
			  
			   beqz $t1, busco ; si $t1 es 0,(o $t1 = 0) osea que el numero analizo es menor que 5,sigo buscando otros numeros
			   ;si el elemento es mayor que num,sumo
			   daddi $v0,$v0,1
			
			  
		       busco: daddi $s0,$s0,8  ; sumo el desplazamiento +8 en la copia de dir de tabla
			
					; decremento el numero de iteraciones
					daddi $a2,$a2,-1  
					bnez $a2, loop
					jr $ra