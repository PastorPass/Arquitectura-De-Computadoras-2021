.data
  num1: .word 3
  num2: .word 5 
  res: .word 0
.code
  ld r1, num1(r0)
  ld r2, num2(r0)
  dadd r10, r0, r0
  loop: daddi r2, r2, -1
  bnez r2, loop
  dadd r10, r10, r1
  sd r10, res(r0)
  halt