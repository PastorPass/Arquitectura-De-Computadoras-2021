.data
  coorX: .byte 0 ; coordenada X de un punto
  coorY: .byte 0 ; coordenada Y de un punto
  color: .byte 0, 0, 0, 0 ; color: máximo rojo + máximo azul => magenta
  CONTROL: .word32 0x10000
  DATA: .word32 0x10008
.text
  lwu $s6, CONTROL($zero) ; $s6 = dirección de CONTROL
  lwu $s7, DATA($zero) ; $s7 = dirección de DATA
  
  daddi $t0, $zero, 7 ; $t0 = 7 -> función 7: limpiar pantalla gráfica
  sd $t0, 0($s6) ; CONTROL recibe 7 y limpia la pantalla gráfica
  
  ;Se leen 2 numeros
 loop: daddi $t5, $0,8 ; Leer Numero 
	;Leer 2 numeros
  sd $t5, 0($s6) ; dir_control = 8
  ld $v0, 0($s7) ; Leo num1
  sd $t5, 0($s6) ; dir_control = 8
  ld $v1, 0($s7) ; Leo num2 
  ;----------------------------------
    
  sb $v0, 5($s7) ; DATA+5 recibe el valor de coordenada X
  sb $v1, 4($s7) ; DATA+4 recibe el valor de coordenada Y
  
  lwu $s2, color($0) ; $s2 = valor de color a pintar
  sw $s2, 0($s7) ; DATA recibe el valor del color a pintar
  daddi $t0, $0, 5 ; $t0 = 5 -> función 5: salida gráfica
  sd $t0, 0($s6) ; CONTROL recibe 5 y produce el dibujo del punto
  j loop
halt