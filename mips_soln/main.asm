
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
# $s4 <- k


        li      $s0,100         #minimum_sum = 100

loop1:
        
        lw      $t0,($s2)       #while(meta[pointer]!=null) {
        beqz    $t0,exit1
        
        
        
        li      $s3,0           # i = 0
loop2:
        add     $t3,$t0,$s3     #triangle* = meta*+i
        lw      $t0,4($t3)      #while (tri[pointer+1]!=null) {
        beqz    $t0,exit2
        
        li      $s1,0           #current_sum = 0
        li      $s4,0
loop3:
        
        lw      $t0,
        
        addi    $s4,$s4,4       #k++
        j   loop3
exit3:

        addi     $s3,$s3,4      #i++
        j   loop2
        
exit2:
        
        addi    $s1,$s1,4       #meta*++
        j   loop1
        
exit1:
        
        
        
        
        
##################################
#           THE END              #
##################################
        
        li      $v0,10
        syscall