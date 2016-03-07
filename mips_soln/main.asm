
.globl main
.data
start_msg: .asciiz "How many rows would you like: "
end_msg:   .asciiz "Here is the base address of the triangle: "
soln_msg:  .asciiz "Here is the solution I came up with: "
.text
main:
        la      $a0,start_msg
        li      $v0,4
        syscall
        li      $v0,5
        syscall
        move    $a0,$v0

        jal     new_random
        move    $a0,$v0
        
        jal     partial_sums
        move    $s0,$v0
        
        la      $a0,end_msg
        li      $v0,4
        syscall
        move    $a0,$s0
        li      $v0,34
        syscall
        
        
        
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

loop1:
        
        lw      $t0,($s2)       #while(meta[pointer]!=null) {
        beqz    $t0,exit1
        
        
        
        li      $s4,0           # j = 0
loop2:
        lw      $t0,($s2)       #triangle* = meta[i]
        add     $t3,$t0,$s4     #triangle* += j
        lw      $t0,4($t3)      #while (tri[pointer+1]!=null) {
        beqz    $t0,exit2
        
        li      $s1,0           #current_sum = 0
        li      $s5,0           #k = 0
        
        #(i,j) should be the apex of the sub-ts
        #the row sum is (i+k, j+k+1) - (i+k, j)
loop3:
        add     $t0,$s2,$s5     #$t0 <- current_row = meta*+k
        beqz    $t0,exit3       #while (current_row!=null)
        lw      $t1,($t0)       #$t1 <- current_col
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
        j   loop3
exit3:

        addi     $s4,$s4,4      #j++
        j   loop2
        
exit2:
        addi    $s3,$s3,4       #i++
        addi    $s1,$s1,4       #meta*++
        j   loop1
        
exit1:
        
        
        
        
        
##################################
#           THE END              #
##################################
        
        li      $v0,10
        syscall