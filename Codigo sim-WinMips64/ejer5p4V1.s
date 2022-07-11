.data
  cant: .word 8
  datos: .word 1, 2, 3, 4, 5, 6, 7, 8
  res: .word 0
.code
  dadd r1, r0, r0 ; r1 se inicializa en = 0
  ld r2, cant(r0)  ; r2 = 8
  loop: ld r3, datos(r1) ; r3 = 1er elemento de la tabla
	daddi r2, r2, -1 ; resto la "dimL"
	dsll r3, r3, 1 ; desplazo a la izq 1 vez los bits del reg r3, dejando el resultado en el mismo reg r3
	sd r3, res(r1) ; guardo el resultado de r3 a res(tabla)
	bnez r2, loop  ; mientras no llegue a cero, loopeo
  daddi r1, r1, 8  ; sumo 8 al reg r1 (que me sirve para desplazarme en la tabla
  halt