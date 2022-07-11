.data
  A: .word 3
  B: .word 6
  C: .word 3
  D: .word 0  ; D = guarda la cantidad de numeros iguales entre si, por ejemplo : si A = B entonces hay 2 numeros iguales
 
.code 
  ld r1, A(r0)
  ld r2, B(r0)
  ld r3, C(r0)  
  daddi r4,r0,0 ; r4 = 0
  bne r1 ,r2 ,busco  ; evaluo A = B
  daddi r4,r4,1
  busco: bne r2 ,r3 ,fin  ; evaluo B = C
		 daddi r4, r4, 1 ; Si (A = B) y (B = C) entonces A=B=C
         
    daddi r4,r4,1
    fin:  sd r4, D(r0)
  halt