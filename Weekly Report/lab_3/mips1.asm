.data 
I : .word 5 
J : .word 1

.text 
 la $t8, I 
 la $t9, J 
 lw $s1, 0($t8) 
 lw $s2, 0($t9) 
 
add $k0,$s1,$s2
slt $t0,$k0,$zero
bne $t0,$zero,else # branch to else if j<i
beq $k0,$zero else
addi $t1,$t1,1 # then part: x=x+1
addi $t3,$zero,1 # z=1
j endif # skip “else” part
else: 
addi $t2,$t2,-1 # begin else part: y=y-1
add $t3,$t3,$t3 # z=2*z
endif: