.data 
  tabla: .word 1, 5, 3, 8, 1, 6, 3, 12, 2, 10
  X: .word 4
  cant: .word 0  ; cant = cantidad de elementos mayores que X
  res: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

.code 
  ld r1, X(r0)  ; r1 = numero 5
  daddi r11,r0,1 ; donde guardo unos en el vector res
  daddi r8, r8 , 0 ; incializo el desplazamiento
  daddi r2, r0,10  ; r2 = cantidad de iteraciones/ loop
  daddi r4, r0,0 ; inicializo r4 = 0 (que guarda la cantidad de numeros mayores a X)
  loop: ld r3, tabla(r8)  ; r3 = 1er elemento de la tabla
		slt r9,r1,r3  ; r9 = 1 --> si r1 es menor que r3

		bnez r9,cuento ;si salto a cuento es porque el numero es mayor a X
		j else
		
		cuento: sd r11,res(r8)
				daddi r4,r4,1 ; incremento cant de numeros mayores a X
				j salto
		else: beq r3,r1,EsMenoreIgual  ; ahora pregunto si el numero de la tabla es igual a X
		      EsMenoreIgual: sd r0,res(r8) 
			  
	    ;sumo el desplazamiento
        salto: daddi r2,r2,-1; decremento el nro de iteraciones
		       daddi r8, r8, 8
		
		bnez r2,loop
  sd r4, cant(r0)
  halt