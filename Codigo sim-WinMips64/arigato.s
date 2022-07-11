.data
  A: .word 10
  B: .word 8
  C: .word 0
  dir_control: .word 0x10000
  dir_data: .word 0x10008
  
.code
  ld r4, A($0)
  ld r5, B($0)
  dadd r3, r4, r5
  sd r3, C($zero)
  
  ld r1 , dir_control($0)
  ld r2 , dir_data($0) 
  daddi r10,$0,1
  
  sd r3, 0(r2)
  sd r10, 0(r1)
		
  halt