.data 
i : .word 0 
n : .word 3
step: .word 1
max : .word 0 
array:  .word -1,-12,-10,-5,1
.text 
 la $t8, i 
 la $t9, n
 la $k0, step
 la $k1, max
 la $s2, array
 lw $s1, 0($t8) 
 lw $s3, 0($t9) 
 lw $s5, 0($k1)
 lw $s4, 0($k0)
 lw $t0,0($s2) #load value of A[i] in $t0
 slt $a1, $zero, $t0
 beq $a1,$zero,fix
 add $s5, $zero, $t0
 j loop
 fix: 
 neg $s5,$t0
loop: 
add $s1,$s1,$s4 #i=i+step
add $t1,$s1,$s1 #t1=2*s1
add $t1,$t1,$t1 #t1=4*s1
add $t1,$t1,$s2 #t1 store the address of A[i]
lw $t0,0($t1) #load value of A[i] in $t0
slt $a1, $zero, $t0
 beq $a1,$zero,fixx
 add $a0, $zero, $t0
 j continue
 fixx: 
 neg $a0,$t0
 continue:
slt $t0,$a0,$s5
bne $t0,$zero,next
add $s5,$zero,$a0
next:
bne $s1,$s3,loop #if i != n, goto loop

