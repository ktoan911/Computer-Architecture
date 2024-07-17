.text
addi $s1, $zero, -5
addi $s2, $zero, -14

slt $t1,$s2,$s1
bne $t1, $zero, exit
j L
L: 
exit: 

