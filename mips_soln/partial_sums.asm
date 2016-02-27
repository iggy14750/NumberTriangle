

.globl partial_sums

partial_sums:

# $s0 <- pointer through given array
# $s1 <- numRows
# $s2 <- base of meta-array
# $s3 <- pointer through meta-array
# $s4 <- pointer through triangle
# $t0 <- i
# $t1 <- j

        move    $s0,$a0
        lw      $s1,($s0)
        addi    $s0,$s0,4
        
    # Init meta-array
        addi    $a0,$s1,1
        sll     $a0,$a0,2
        li      $v0,9
        syscall
        move    $s2,$v0
        move    $s3,$v0 
        
        
    # Init triangle
        addi    $t0,$s1,3
        multi   $t0,3
        mflo    $t0
        sll     $a0,$t0,1
        li      $v0,9
        syscall
        move    $s4,$v0
        
        
        
        li      $t0,0
loop1:
    #while (i<=numRows) {
        slt     $t2,$s1,$t0 # if !(numRows<i), exit
        beqz    $t2,exit
        #store triangle_pointer at meta_pointer
        #meta_pointer++
        #i++
        #j=0
        #store 0 at triangle_pointer
        #triangle_pointer++
        
        loop2:
                #j++
                #while !(j==i) {
                #beq     j,i,exit_loop2
                #load x from given_pointer
                #load y from given_pointer-4
                #store x+y at triangle_pointer
                #given_pointer++
                j loop2
         
    exit_loop2:
        j loop1
        
exit:   
        #store null at meta_pointer
        
        
        jr      $ra
        