.data
  num1: .word 2
  num2: .word 6
  res: .word 0
  
.code
  ld r1, num1(r0)
  ld r2, num2(r0)
  daddi r3, r0, 0
  loop: daddi r2,r2, -1
        nop
		bnez r2, loop	
  dadd r3,r3,r1
  sd r3, res(r0)
  halt