.data
A: .word 7, -2, 5, 1, 5,6,7,3,6,8,8,59,5
Aend: .word
.text
main: la $a0,A #$a0 = Address(A[0])
 la $a1,Aend
 addi $a1,$a1,-4 #$a1 = Address(A[n-1])
 j bubble_sort #sort
after_sort: li $v0, 10 #exit
 syscall
end_main:

#s2 là biến tạm

bubble_sort:
# khởi tạo 
add $t1, $zero, $a1 # vị trí cuối
addi $t9, $a0, 4 # vị trí i = 1
loop1: 
beq $t1, $t9, after_sort # kết thúc vòng 1
add $t0, $zero, $a0 # lấy vị trí đầu
loop2:
beq $t1, $t0, update_loop1
addi $t2, $t0, 4
lw $s0,0($t0) # giá trị j
lw $s1, 0($t2) #giá trị j + 1
slt $s2, $s1, $s0 # check điều kiện
bne $s2, $zero, swap
j skip_swap

swap:
sw $s1, 0($t0)
sw $s0, 0($t2)

skip_swap:
addi $t0, $t0, 4
j loop2

update_loop1:
addi $t1, $t1, -4 # i--
j loop1

