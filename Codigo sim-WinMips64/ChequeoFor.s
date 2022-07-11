.data
  num: .word 8
  suma: .word 0
.code
  nop
  ld r1, num(r0)
  daddi r2,r0,0
  loop: dadd r2,r2,r1
		daddi r1,r1, -1
		bnez r1, loop
  sd r2, suma(r0)
  halt