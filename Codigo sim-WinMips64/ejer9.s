.data
  X: .word  2 ; numero a eleccion personal
  Y: .word  3 ; numero a eleccion personal
 
 .code
  ld r1, X(r0)  ; r1 = 2
  ld r2 ,Y(r0)
  
  daddi r3, r0,3  ; r3 =  n cantidad de iteraciones en el loop (en este caso elegi 5 = n ); a = r3
  loop: daddi r3,r3, -1    ; a := a - 1
        nop
		bnez r3, loop
  dadd r1,r1,r2  ; x := x + y
  halt