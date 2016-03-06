
.globl main
.data
start_msg: .asciiz "How many rows would you like: "
end_msg:   .asciiz "Here is the base address of the triangle: "
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
        
        li      $v0,10
        syscall
        
