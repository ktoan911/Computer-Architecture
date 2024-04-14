#Laboratory Exercise 7 Home Assignment 1
.text
main: li $a0,-5 #load input parameter
 jal abs #jump and link to abs procedure
 nop
 add $s0, $zero, $v0
 li $v0,10 #terminate
 syscall
endmain:
#--------------------------------------------------------------------
# function abs
# param[in] $a1 the interger need to be gained the absolute value
# return $v0 absolute value
#--------------------------------------------------------------------
abs:
 bltz $a0,fix #if (a0)<0 then done
 jr $ra
fix:
 sub $v0,$zero,$a0 #put -(a0) in v0; in case (a0)<0
 nop
done:
 jr $ra
