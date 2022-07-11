.data
tabla: .double 4, 9.50, 5.75, 7, 8, 8.25, 6.5, 6
min: .double 7
cant: .word 8

.code
  add.d f1,f0,f0  ; instruccion faltante (no se que otra instruccion deberia ir,salvo una inicializacion)
  ld r5, cant(r0)  ; r5 = 8
  daddi r1, r0, 0  ; r1 = 0 (inicializa)
  loop: l.d f2, tabla (r1) ; toma 1er elemento de la tabla
	    add.d f1, f1, f2  ; va sumando todos los elementos de la tabla
	    daddi r1, r1, 8  ; suma desplazamiento
	    daddi r5, r5, -1  ; decrementa nro de iteraciones
	    bnez r5, loop
  ld r5, cant(r0)   ;r5 = 8
  mtc1 r5, f7  ; f7 = 8.0 (en flotante)  <-- instruccion faltante 
  cvt.d.l f10, f7  ; convierte a pf el valor de f7 a f10
  div.d f3, f1, f10
  l.d f4, min(r0) ; f4 = 7
  c.lt.d f3, f4  ; FP = 1 si f3 < f4
  bc1f esmayor ; si FP = 0 ,salto a esmayor   <-- Instruccion faltante
  daddi r10, r0, 0
  j fin
  esmayor: daddi r10, r0, 10
fin: halt