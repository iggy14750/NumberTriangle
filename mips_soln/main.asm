#University of Pittsburgh
#COE-147 Project Euler 150
#Instructor: Samuel J. Dickerson
#Teaching Assistants: Shivam Swami (shs173) and Bonan Yan (boy12)
#-------------------------------------------------------------------------------------------------
.globl main
.include "test_case.asm"
main:

#Submitted by: Isaac B Goss and Kyle Legters

.data
pass_msg: .asciiz "\nPASS\n"
fail_msg: .asciiz "\nFAIL\n"
#-------------------------------------------------------------------------------------------------

.text

        #la      $a0,start_msg
        #li      $v0,4
        #syscall
        #li      $v0,5
        #syscall
        #move    $a0,$v0
        #li      $a1,7
        #jal     new_mod
        #move    $a0,$v0
        
        la      $a0,test
        
        #li      $v0,34
        #syscall
        
        jal     partial_sums
        move    $s2,$v0
        
        #la      $a0,end_msg
        #li      $v0,4
        #syscall
        #move    $a0,$s0
        #li      $v0,34
        #syscall
        
        
        
##################################
#      THE    BUSINESS           #
##################################

# $s0 <- minimum_sum
# $s1 <- current_sum
# $s2 <- meta_pointer
# $s3 <- i
# $s4 <- j
# $s5 <- k


        li      $s0,100         #minimum_sum = 100
        li      $s3,0           #i = 0

loopm1:
        
        lw      $t0,($s2)       #while(meta[pointer]!=null) {
        beqz    $t0,exitm1
        
        
        
        li      $s4,0           # j = 0
loopm2:
        lw      $t0,($s2)       #triangle* = meta[i]
        add     $t3,$t0,$s4     #triangle* += j
        addi    $t3,$t3,4       #triangle* += 1
        lw      $t0,4($s2)      #while (meta[i][j+1]!=meta[i+1]) {
        beq     $t0,$t3,exitm2
        beqz    $t0,exitm2	#ADDED TO FIX INFINITE LOOP
        
        li      $s1,0           #current_sum = 0
        li      $s5,0           #k = 0
        
        #(i,j) should be the apex of the sub-ts
        #the row sum is (i+k, j+k+1) - (i+k, j)
loopm3:
        add     $t0,$s2,$s5     #$t0 <- current_row = meta*+k
        lw      $t1,($t0)       #$t1 <- current_col
        beqz    $t1,exitm3       #while (current_row!=null)
        add     $t1,$t1,$s4     #current_col += j
        lw      $t2,($t1)       #$t2 <- left_side
        add     $t1,$t1,$s5     #current_col += k
        addi    $t1,$t1,4       #current_col += 1
        lw      $t3,($t1)       #$t3 <- right_side
        sub     $t3,$t3,$t2     #$t3 <- row_sum = right_side - left_side
        add     $s1,$s1,$t3     #partial_sum += row_sum
        slt     $t0,$s1,$s0
        beqz    $t0,cont        #if (current_sum < minimum_sum)
        move    $s0,$s1
cont:
        addi    $s5,$s5,4       #k++
        j   loopm3
exitm3:

        addi     $s4,$s4,4      #j++
        j   loopm2
        
exitm2:
        addi    $s3,$s3,4       #i++
        addi    $s2,$s2,4       #meta*++       #changed both registers from s1 to s2
        j   loopm1
        
exitm1:
        move    $a0, $s0
        
        li      $v0,1
        syscall
        
#---------Do NOT modify anything below this line---------------
lw $s0, sol
beq $a0, $s0 pass
fail:
la $a0, fail_msg
li $v0, 4
syscall
j end
pass:
la $a0, pass_msg
li $v0, 4
syscall
end:
#-----END--------------------------------------------------------- 
li      $v0,10
syscall

