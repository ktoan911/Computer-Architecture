.data
Message: .space 25
newline: .asciiz "\n" 
.text
la $s0, Message
xor $t0, $zero, $zero # t0 = i = 0
li $t7, 20
li $t1, 10
read_char:
li $v0, 12
syscall
beq $v0, $t1, endread
beq $t0, $t7, endread
add $t3,$s0,$t0 
sb $v0,0($t3)
addi $t0, $t0, 1
j read_char
endread:
li $v0, 4
la $a0, newline    
syscall            
print_reverse:
add $t1, $s0, $t0
li $v0, 11          
lb $a0, ($t1)       
syscall
beq $t0,$zero,end_print
addi $t0, $t0, -1
j print_reverse
end_print:
li $v0, 10         # syscall 10 to exit the program
syscall