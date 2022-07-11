  .data
  A: .word 1
  B: .word 3
  tabla: .word 0
.code
  daddi r3 , r0, 0  ; r3 = inicializo r3 = 0
  ; 1X2 --> 2X2 --> 4X2  = 2^3 = 8 en reg r1
  ld r1, A(r0)  ; r1 = 1
  ld r2, B(r0)  ; r2 = 3
  
  
  ; 1er valor que se guarda de r1 a r3 antes del loop
  dadd r3,r0,r1
  sd r3,tabla(r5) 
  
  loop: daddi r2, r2, -1
    dsll r1, r1, 1  ; desplazo a la izq 1 los bits del registro r1 dejandolo en el mismo reg.
	; tomo lo que hay en r1 y lo mando a r3
	dadd r3,r0,r1
	
	; uso a r5 como desplazamiento + 8
	daddi r5,r5,8
	
	; paso lo que quedo en r3 a la tabla 
	sd r3,tabla(r5) 
	
    bnez r2, loop  ; mientras r2 no sea cero, itero
	 
halt