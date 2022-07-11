.data
  A: .word 1
  B: .word 3
  C: .word 1
  D: .word 0  ; Si algun numero es igual a otro se carga 1 vez ,2 veces o  3 veces en esta variable D
 
.code 
  ld r1, A(r0)
  ld r2, B(r0)
  ld r3, C(r0)  
  daddi r4,r0,0 ; r4 = 0
  
  beq r1 ,r2 ,sigo1
  j else1
  sigo1: daddi r4,r4,1
  else1: beq r1 ,r3 ,sigo2
         j else2
		 sigo2: daddi r4,r4,1
				
		 else2:	beq r2 ,r3 ,sigo3
		        j fin
				sigo3: daddi r4, r4, 1
  
  fin: sd r4, D(r0)
  halt