.data
even_prompt:  .asciiz "This is even"
odd_prompt:   .asciiz "This is odd"
newline:  .asciiz "\n"

  
 
.text

main:

  li $a0, 2
  li $a1, 2
  jal raise

  move $t0, $v0

  #cout the answer
  move $a0, $t0
  li $v0, 1
  syscall

  #End the program
  li $v0, 10
  syscall

#----------------------------------------------------------------------------

raise:
  #spill up stack
  #s0,1,2,3,4
  addi $sp, $sp, -24
  sw $a0, 0($sp)
  sw $s1, 4($sp)
  sw $s2, 8($sp)
  sw $s3, 12($sp)
  sw $s4, 16($sp)
  sw $ra, 20($sp)

  
  #if(b == 0) base case
  bne $a1, $zero, raise_recurssion
  #return 1
  li $v0, 1
  jal raise_down

raise_recurssion:
  
  #if((b & 0x1) == 0x1) 
  and $t1, $a1, 0x1                 #Use and to check odd and even
  bne $t1, 0x1, branch_out          #if even, branch out
  move $s1, $a1                     #s1 = b, save b since it will be changed
  move $t7, $a0
  addi $a1, $a1, -1                 #b = b - 1
  jal raise                         #call raise function
  move $s2, $v0                     #$s2 = raise(a, b-1)

  #return multiply
  #b = $s2 
  move $a1, $s2
  
  jal multiply_function
  move $a1, $s2
  move $a0, $t7

  jal raise_down


branch_out:# The number is even
  move $s3, $a1                       #b = $s3
  srl $a1, $a1, 1                     #b = b / 2
  jal raise                           #call raise function
  move $t0, $v0                       #temp = raise(a, 2/b)
  
  move $s4, $a0                       #$s4 = a

  move $a0, $t0                       #multiply(temp, temp)
  move $a1, $t0     
  jal multiply_function

  move $a0, $s4                       #restore
  move $a1, $s3

raise_down: 

  lw $a0, 0($sp)
  lw $s1, 4($sp)
  lw $s2, 8($sp)
  lw $s3, 12($sp)
  lw $s4, 16($sp)
  lw $ra, 20($sp)
  addi $sp, $sp, 24

  jr $ra
#------------------------------------------------------------------------------
multiply_function:
         #We should spill up parameter a and b         
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

  

  

























  
