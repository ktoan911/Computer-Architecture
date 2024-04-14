#Laboratory Exercise 7, Home Assignment 2
.data
largest: .asciiz "Largest: "
smallest: .asciiz "\nSmallest: "
comma: .asciiz ", 
.text
main: li $s0,1 #load test input
 li $s1,-1
 li $s2,2
 li $s3,3
 li $s4,4
 li $s5,150
 li $s6,6
 li $s7,170
 
 jal find_minmax
 nop
 li $v0, 4 # Print message Largest
la $a0, largest
syscall
add $a0, $t3, $zero # Print Max
li $v0, 1
syscall
li $v0, 4 # Print message Comma
la $a0, comma
syscall
add $a0, $t4, $zero
li $v0, 1 # Print the register number of Max
syscall
li $v0, 4 # Print message Smallest
la $a0, smallest
syscall
add $a0, $t1, $zero # Print Min
li $v0, 1
syscall
li $v0, 4 # Print message Comma
la $a0, comma
syscall
add $a0, $t2, $zero
li $v0, 1 # Print the register number of Min
syscall
endmain: li $v0, 10 # Exit
syscall

 li $v0, 10
 syscall
end_main:

find_minmax:  add $v0, $zero, $sp
addi $sp,$sp,-32

add $t1, $zero, $s0
add $t3, $zero, $s0

li $t5, 0

sw $s0, 0($sp)
sw $s1, 4($sp)
sw $s2, 8($sp)
sw $s3, 12($sp)
sw $s4, 16($sp)
sw $s5, 20($sp)
sw $s6, 24($sp)
sw $s7, 28($sp)

add $t0, $sp, $zero
loop: lw $a2, 0($t0)
slt $a0, $a2, $t1
beq $a0, $zero, skip_min
add $t1, $zero, $a2
add $t2, $zero , $t5
skip_min:
slt $a0, $t3, $a2
beq $a0, $zero, skip_max
add $t3, $zero, $a2
add $t4, $zero , $t5
skip_max:
addi $t0, $t0, 4
addi $t5, $t5, 1
bne $v0, $t0, loop
jr $ra


