.data
 valor1: .word 16
 valor2: .word 4
 result: .word 0
 
.text
  ld $a0, valor1($zero)  ; $a0 = 16
  ld $a1, valor2($zero)  ; $a1 = 4
  jal a_la_potencia  ; llamo a subrutina 
  sd $v0, result($zero)
  halt
  
  ;subrutina 
  a_la_potencia: daddi $v0, $zero, 1  ; $v0 = 1
  lazo: slt $t1, $a1, $zero  ; comparo $a1 < 0, si  es asi, dejo en $t1 = 1
  bnez $t1, terminar  ; si $t1 no es 0 , salto a terminar(hasta que $t1 = 0)
  daddi $a1, $a1, -1  ; resto $a1, osea 4-1
  dmul $v0, $v0, $a0  ; multiplico 1 * 16 y lo guardo en $v0
  j lazo  ; vuelvo a lazo
  terminar: jr $ra
