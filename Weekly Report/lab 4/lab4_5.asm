.text
li $s0, 8      
li $s2, 16    

li $a1 2

slt $t1, $s2, $a1
bne $t1, $zero, exit 
loop: 
sll $s0, $s0, 1
sra $s2, $s2, 1
slt $t1, $s2, $a1
beq $t1, $zero, loop
exit: 

