
.text
 
main: 

  li $a1, 1
  
  srl $a1, $a1, 1

  move $a0, $a1

  li $v0, 1
  
  syscall
