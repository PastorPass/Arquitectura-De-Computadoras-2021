.data 
  base: .double 5.85
  altura: .double 13.47
  dos: .double 2.0
  superficie: .double 0

.code
  l.d f1, base(r0)
  l.d f2 , altura(r0)
  l.d f3 , dos(r0)
  
  ;mutiplico base x altura y lo guardo en un registro de punto flotante
  mul.d f4,f1,f2
  ;ahora al resultado parcial lo divide en 2
  div.d f5,f4,f3
  
  ;ahora guardo el resultado en superficie
  s.d f5,superficie(r0)
  halt