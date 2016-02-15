
.global trigen

#   Generates a pseudo-random distribution of numbers.
#   (Using mod arithmetic), with the help of a seed placed in $a1
#   Puts them in a large array in "triangle" format
#   with the first element of each row array being zero,
#   to be used as a signal that one has reached the end of each row,
#   and also helpful when array is over-written with iterative sum.
#   The base address of each of these rows is stored in another array,
#   the base address of which is returned in $v0
#   

#   OPEN ISSUE: Please only call with the value 10 (0xa) 
#               (or less) in $a0!
#               Adjusting the size of triangle is outside
#               of my current skill set.
#               For larger data sets, we can hardcode until
#               I have learned how to do this properly.

trigen: ##(int numRows [$a0], int seed [$a1])
    .data
        adress_space: .space 40 #10 rows (how to make this based on $a0?)
        array_base: .space 260  #55+10 elements
    .text
    
        la      $s0,adress_space
        la      $s1,array_base
        li      $t0,0
        li      $s5,17 #for arithmetic
        li      $s6,100#mod for arithmetic
        
loop1:
        addi    $t0,$t0,1
        beq     $t0,$a0,exit1
        sw      $s1,0($s0)
        addi    $s0,$s0,4
        
        li      $t1,0
        sw      $0,0($s1)
loop2:
        addi    $s1,$s1,4
        beq     $t1,$t0,loop1
#Modular arithmetic.  Probably buggy.
        mult    $a1,$s5
        mflo    $a1
        div     $a1,$s6
        mfhi    $a1
        subi    $t2,$a1,50
        
        sw      $t2,0($s1)
        addi    $t1,$t1,1
        j loop2
        
exit1:
        jr $ra
