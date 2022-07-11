.data
  A: .word 1
  B: .word 3
  
.code
  ; 1X2 --> 2X2 --> 4X2  = 2^3 = 8 en reg r1
  ld r2, B(r0)  ; r2 = 3
  ld r1, A(r0)  ; r1 = 1
  loop: daddi r2, r2, -1
    dsll r1, r1, 1  ; desplazo a la izq 1 los bits del registro r1 dejandolo en el mismo reg.
    bnez r2, loop  ; mientras r2 no sea cero, itero
halt