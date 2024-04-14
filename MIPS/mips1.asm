.data
mes1: .asciiz "Insert N: "
mes2: .asciiz "Min digit is: "
.text
main:	li $s0, 9	# Min digit = 9
	li $v0, 4	
    	la $a0, mes1	# Print promt
    	syscall
    	
    	li $v0, 5
    	syscall
    	move $t0, $v0	# Store number into $t0
    	
find_max:
	beqz $t0, print
	li $t1, 10
	div $t0, $t1
	mfhi $t2
	sub $t0, $t0, $t2
	div $t0, $t1
	mflo $t0
	blt $t2, $s0, update
	j find_max
    
update:
	move $s0, $t2
	j find_max
    
print:	li $v0, 4
	la $a0, mes2
	syscall
	
	li $v0, 1	# Print
	move $a0, $s0
	syscall
    
quit:	li $v0, 10	# exit
    	syscall