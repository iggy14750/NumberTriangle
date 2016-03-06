

.globl partial_sums

# def partial_sums( $a0<-baseAddressGivenArray)
# this function takes these two parameters
# and returns the base address to a `meta_array' 
# which itself contains pointers to the base of
# the rows of the triangle, but instead of simply
# putting the triangle in another place, I
# also took the partial sums (hence the name)
# across the rows.


partial_sums:

# $s0 <- pointer through given array
# $s1 <- numRows
# $s2 <- base of meta-array
# $s3 <- pointer through meta-array
# $s4 <- pointer through triangle
# $t0 <- i
# $t1 <- j

        move    $s0,$a0
        lw      $s1,($s0)   #get numRows from array
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
        mult    $t0,$s1
        mflo    $t0
        sll     $a0,$t0,1
        li      $v0,9
        syscall
        move    $s4,$v0
        
        
        
        li      $t0,0
loop1:

        beq     $s1,$t0,exit    #while( numRows != i) {
        sw      $s4, ($s3)      #store triangle_pointer at meta_pointer
        addi    $s3,$s3,4       #meta_pointer++
        addi    $t0,$t0,1       #i++
        li      $t1,0           #j=0
        sw      $0, ($s4)       #store 0 at triangle_pointer
        addi    $s4,$s4,4       #triangle_pointer++
        
    loop2:
        
        beq     $t1,$t0,exit_loop2  #while (j!=i) {
        addi    $t1,$t1,1       #j++
        lw      $t2,($s0)       #load x from given_pointer
        lw      $t3,-4($s4)     #load y from triangle_pointer-4
        add     $t2,$t2,$t3     #store x+y at triangle_pointer
        sw      $t2,($s4)
        addi    $s4,$s4,4       #triangle_pointer++
        addi    $s0,$s0,4       #given_pointer++
        
        j   loop2
         
    exit_loop2:
        
        j   loop1
        
exit:   
        sw      $0,($s3)        #store null at meta_pointer
        move    $v0,$s2
        
        jr      $ra
        
