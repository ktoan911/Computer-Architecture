.data
A: .word 1,-2,3,4,5,4
Aend: .word
B: .word  5 ,4,4,3,-2,1, 2
Bend: .word
equal_prompt: .asciiz "2 mang bang nhau"
not_equal_prompt: .asciiz "2 mang khong bang nhau"
.text
main: 
check_arr:la $t0,A #$t0 = Address(A[0])
    la $t1,Aend
    la $s0,B #$s0 = Address(B[0])
    la $s1,Bend
 
 #check độ dài 2 mảng
    subu $t2, $t1, $t0  # Tính độ dài của mảng A
    subu $s2, $s1, $s0  # Tính độ dài của mảng 8
    bne $t2, $s2, not_equal
# sắp xếp 2 mảng
    la $a0,A #$a0 = Address(A[0])
    la $a1,Aend
    addi $a1,$a1,-4 #$a1 = Address(A[n-1])
    jal sort #sort
    la $a0,B #$s0 = Address(B[0])
    la $a1,Bend
    addi $a1,$a1,-4 #$a1 = Address(B[n-1])
    jal sort #sort
    nop
 
 check_array: la $t0,A #$t0 = Address(A[0])
    la $t1,Aend
    la $s0,B #$s0 = Address(B[0])
    la $s1,Bend
 loop_check_arr:
 #lấy 2 phần tử tương đương index 2 mảng cần check hiện tại
     lw $t3,0($t0) 
     lw $s3, 0($s0)
 #check 2 phần tử bằng nhau không, nếu ko thoát vòng lặp
     bne $s3, $t3, not_equal
 #tiến hành cập nhật phần tử cần check hiện tại
     addi $t0, $t0, 4
     addi $s0, $s0, 4
 # check xem đã là phần tử cuối cùng 
     bne $s0, $s1,  loop_check_arr
 
equal:li $v0, 4          # thông báo 2 mảng bằng nhau
    la $a0, equal_prompt     # Load address of prompt into $a0
    syscall            # Call operating system to perform operation
    j exit
 
not_equal:li $v0, 4          # Thông báo 2 mảng không bằng nhau
    la $a0, not_equal_prompt     # Load address of prompt into $a0
    syscall            # Call operating system to perform operation
    j exit

sort: beq $a0,$a1,done #check xem hết phần tử chưa, nếu hết thì thoát vòng lặp
    j max #call the max procedure
after_max: lw $t0,0($a1) #lấy giá trị phần tử cuối cùng chưa xét đến của mảng
#swap 2 giá trị cuối và gia trị lớn nhất
    sw $t0,0($v0) #lưu giá trị $t0 vào ô có địa chỉ v0 
    sw $v1,0($a1) #lưu giá trị $v0 vào ô có địa chỉ a1
    addi $a1,$a1,-4 #cập nhật lại giá trị ô nhớ cuối cùng của mảng chưa xét đến
    j sort # tiếp tục vòng sort
done: jr $ra

max: addi $v0,$a0,0 #khởi tạo biến chứa địa chỉ ô nhớ có phần tử max
    lw $v1,0($v0) #lưu giá trị phần tử đầu tiên của vào v1 ( max = v1)
    addi $t0,$a0,0 #địa chỉ phần tử đầu tiên của mảng vào t0
loop:beq $t0,$a1,ret #if next=last, return
    addi $t0,$t0,4 #lưu địa chỉ phần tử tiếp theo
    lw $t1,0($t0) #load giá trị tiếp theo vào t1
    slt $t2,$t1,$v1 #(next)<(max) ?
    bne $t2,$zero,loop #if (next)<(max), repeat
    addi $v0,$t0,0 #địa chỉ ô nhớ có phần tử max
    addi $v1,$t1,0 #lưu giá trị max hiện tại
    j loop #tiếp tục loop
ret: j after_max

exit:
