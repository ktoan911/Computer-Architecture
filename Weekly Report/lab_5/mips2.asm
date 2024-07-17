.data
textone: .asciiz "The sum of "
texttwo: .asciiz " and "
textthree: .asciiz " is "
.text

li $s0, 3
li $s1, 2
add $s2, $s1, $s2

li $v0, 4
la $a0, textone
syscall

li $v0, 1
add $a0, $zero, $s0
syscall

li $v0, 4
la $a0, texttwo
syscall

li $v0, 1
add $a0, $zero, $s1
syscall

li $v0, 4
la $a0, textthree
syscall

li $v0, 1
add $a0, $zero, $s2
syscall
