#Laboratory Exercise 5, Home Assignment 1
.data
test: .asciiz "Hello World"
.text
 li $s0, 4
 la $a0, test
 syscall
