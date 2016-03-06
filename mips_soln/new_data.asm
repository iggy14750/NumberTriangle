

.globl new_random, new_mod


new_random:
#def function which puts n (random) numbers into memory
#call with numRows in $a0. (Optionally) Place bound on numbers
#in $a1.  Base address of array 
#will be returned in $v0

# $s0 <- length of new list
# $s1 <- base of new array
# $s2 <- pointer through array
# $t0 <- iterator

    #store local variables on the stack
        addi    $sp,$sp,4
        sw      $s0,($sp)
        addi    $sp,$sp,4
        sw      $s1,($sp)
        addi    $sp,$sp,4
        sw      $s2,($sp)
    #transform numRows into n(umElements) = (r*(r+1))/2
        move    $t1,$a0 #for now, this holds numRows
        addi    $t0,$a0,1   #r+1
        mult    $t0,$a0     #r(r+1)
        mflo    $a0
        srl     $a0,$a0,1   #(r(r+1))/2
        
    #I need 4(n+1) bytes
        move    $s0,$a0
        addi    $a0,$a0,1
        sll     $a0,$a0,2
        
        li      $v0,9
        syscall
    #First I need to put numRows in the list
        move    $a0,$t1
        
        move    $s1,$v0
        move    $s2,$v0
        move    $t0,$0
        li      $v0,42
        bne     $a1,$0,loop1
        li      $a1,100
        
loop1:  
        sw      $a0,($s2)
        addi    $s2,$s2,4
        beq     $t0,$s0,exit1
        addi    $t0,$t0,1
        syscall
        subi    $a0,$a0,50
        j loop1
        
exit1:
        move    $v0,$s1

        lw      $s2,($sp)
        subi    $sp,$sp,4
        lw      $s1,($sp)
        subi    $sp,$sp,4
        lw      $s0,($sp)
        subi    $sp,$sp,4
        
        jr      $ra
        
new_mod:

# Def a function which generates a list
# of (pseudo) random numbers, using mod
# arithmetic, based upon the numRows,
# specified in $a0, and a seed, specified
# in $a1, upon call.


# $s0 <- length of new list
# $s1 <- base of new array
# $s2 <- pointer through array
# $t0 <- iterator
# $a1 <- seed for mod
# $a0 <- coefficient for mod
# $s3 <- mod

    #store local variables on the stack
        addi    $sp,$sp,4
        sw      $s0,($sp)
        addi    $sp,$sp,4
        sw      $s1,($sp)
        addi    $sp,$sp,4
        sw      $s2,($sp)
    #transform numRows into n(umElements) = (r*(r+1))/2
        move    $t1,$a0 #for now, this holds numRows
        addi    $t0,$a0,1
        mult    $t0,$a0
        mflo    $a0
        srl     $a0,$a0,1
        
    #I need 4(n+1) bytes
        move    $s0,$a0
        addi    $a0,$a0,1
        sll     $a0,$a0,2
        
        li      $v0,9
        syscall
        
        move    $s1,$v0
        move    $s2,$v0
        move    $t0,$0
        
        li      $a0,109 #coeff for arithmetic
        li      $s3,100 #mod for to arithmetic
        #li      $v0,42
        #bne     $a1,$0,loop2
        #li      $a1,100
        
loop2:  
        sw      $t1,($s2)
        addi    $s2,$s2,4
        beq     $t0,$s0,exit2
        addi    $t0,$t0,1
        
        #the mod part
        mult    $a1,$a0
        mflo    $a1
        div     $a1,$s3
        mfhi    $a1
        
        
        subi    $t1,$a1,50
        j loop2
        
exit2:
        move    $v0,$s1

        lw      $s2,($sp)
        subi    $sp,$sp,4
        lw      $s1,($sp)
        subi    $sp,$sp,4
        lw      $s0,($sp)
        subi    $sp,$sp,4
        
        jr      $ra
        
        
        
