
  
.text
main:
         #Assign two twmp parameter
         li $a0, 1
         li $a1, 1
         jal multiply_function

         move $s0, $v0

         #cout the answer
         move $a0, $s0
         li $v0, 1
         syscall

         li $v0, 10
         syscall 

multiply_function:
         addi $sp, $sp, -4
         sw $ra, 0($sp)

          #if( a0 == 0 )
          bne $a0, $zero, recurrsion
          li $v0, 0
          jal multiply_end

recurrsion:
          #multiply($a0-1,$a1)
          addi $a0, $a0, -1
          jal multiply_function

          # $v0 = multiply($a0, $a1) + multiply($a0-1, $a1)
          add $v0, $v0, $a1

multiply_end:
          #load back
          lw $ra, 0($sp)
          addi $sp, $sp, 4
          #jump back
          jr $ra





  

  
