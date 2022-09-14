           #Zhihao Jin
           #This MIPS will sort array in acending order.
  
.data
  
prompt1:  .asciiz "Enter the number of elements in array:"
prompt2:  .asciiz "Enter array elements, one per line:\n"
newline:  .asciiz "\n"
          #n is associated with $s1  
          .align 2
list:     .space 400 # int list[100] and will be associated with $s7
           # i will be asscoiate with $s2
           # j_index will be associated with $s5  
           # min_pos will be asscociated with $s3
           # temp will be asscociated with $s4
           # 1 will be associated with $s6
  
.text 

        
main:   #load array into a register
        la $s7, list # $s7 = &list

        # Print out prompt1, number of elements in array
        la $a0, prompt1
        li $v0, 4
        syscall
  
        # Scan in user's input
        li $v0, 5
        syscall
        move $s1, $v0 # and put it in $s1

        # Print out prompt2
        la $a0, prompt2
        li $v0, 4
        syscall

        li $s2, 0 # i = 0
  
for_1:  # Begin the 1st loop
        # for( i = 0, i < size, i++)
        bge $s2, $s1, for_1_exit

        # Let user input
        li $v0, 5
        syscall

        # Store the value in list
        sll $t2, $s2, 2          # $t2 = $s2 * 4
        addu $t3, $t2, $s7       # $t3 = $t2 + $s3 (temp off-set notation index)

        sw $v0, 0($t3)           # Store value in list
        
        addi $s2, $s2, 1         # i++
        j for_1 # jump to for_1 loop
for_1_exit:



        li $s2, 0                # i = 0
        li $s6, 1                # $s6 = 1
        sub $s0, $s1, $s6        # $s0 = n - 1
for_2:  # The second loop starts
        bge $s2, $s0, for_2_exit # for( i < (n-1))
        move $s3, $s2            # min_position  = i


        addi $s5, $s2, 1         # j = i + 1
for_3:  # for ( j < n )
        bge $s5, $s1, for_3_exit
    
        # transfer index to off-set min_pos and j
        sll $t0, $s3, 2
        addu $t1, $t0, $s7       # The off-set index of min_pos: $t1

        sll $t2, $s5, 2
        addu $t3, $t2, $s7       # The off-set index of j: $t3

        lw $t4, 0($t1)           # $t4 = list[min_pos]
        lw $t5, 0($t3)           # $t5 = list[j]


        #if statement
        bge $t5, $t4, if_exit    #if(list[j] < list[min_pos])
        move $s3, $s5            #min_pos = j 
if_exit:                         #branch_out

addi $s5, $s5, 1                 #j++
j for_3                          #jump back
for_3_exit:


        #Begin to start to swap part
        sll $t0, $s2, 2           # i = i * 4
        addu $t1, $t0, $s7        # find the off-set notation on index
        lw $s4, 0($t1)            # temp = list[i]

        sll $t0, $s3, 2
        addu $t2, $t0, $s7        # off-set of temp index is $t2
        lw $t3, 0($t2)            # $t3 = list[min_pos]
        sw $t3, 0($t1)            # list[i] = l=list[min_pos]

        sw $s4, 0($t2)            # list[min_pos] = temp

# i++
addi $s2, $s2, 1
j for_2
for_2_exit:


  

  #Print out a new line
la $a0, newline
li $v0, 4
syscall

 
# Print out array  
li $s2, 0
for_4:  bge $s2, $s1, for_4_exit

        #Lw the elements in $t
        sll $t0, $s2, 2
        addu $t1, $t0, $s7
        lw $a0, 0($t1)

        # Print out the element one by one
        li $v0, 1
        syscall

        # Print out a new line
        la $a0, newline
        li $v0, 4
        syscall

        addi $s2, $s2, 1

        j for_4
for_4_exit: j $ra

  

  

         

  
        
  
  
   
  

  

  
