.data
  A: .word 1
  B: .word 2
.code
  ld r1, A(r0)
  ld r2, B(r0)
  sd r2, A(r0)  ; si el forwarding esta deshabilitado --> esta inst. esta causando el atasco, ya que hay una dependencia de dato en el reg. r2
  sd r1, B(r0)
halt