.data
  tabla: .word 20, 1, 14, 3, 2, 58, 18, 7, 12, 11
  num: .word 7
  long: .word 10  ; la cantidad de elementos de la tabla 
.code
  ld r1, long(r0)  ; r1 = 10
  ld r2, num(r0)  ; r2 = 7
  dadd r3, r0, r0  ; inicializa r3 = 0
  dadd r10, r0, r0 ; inicializa r10 = 0
  loop: ld r4, tabla(r3) ; toma el 1er numero de la tabla y lo pasa al reg. r4
    daddi r1, r1, -1  ; decremento la "dimL"
	daddi r3, r3, 8  ; Sumo 8 al registro que se utiliza para desplazar en la tabla
	beq r4, r2, listo ; si r4 = r2 --> salto a listo(compara si el valor de r4 es igual al valor de r2)
	;daddi r1, r1, -1  ; decremento la "dimL"

	bnez r1, loop  ; mientras la dimL no llegue a cero, loopeo
  j fin
  listo: daddi r10, r0, 1 ; 
  fin: halt
