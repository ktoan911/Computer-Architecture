.data
array: .space 400 
input_prompt: .asciiz "Nhap so phan tu cua mang (1 so be hon 100): "
prompt: .asciiz "Nhap phan tu thu "  
prompt2: .asciiz ": "
enter_prompt: .asciiz "\n"
comclu1_prompt: .asciiz "phan tu lon nhat mang la: "
comclu2_prompt: .asciiz "so phan tu trong khoang (m, M):  "
strm: .asciiz "Nhap so m: "
strM: .asciiz "Nhap so M: "
prompt_reset: .asciiz "Ban co muon nhap lai khong? Neu khong nhap 0, neu co nhap 1 so khac khong: "
.text
main:la $s0, array # lưu địa chỉ phần tử đầu tiên của mảng
    # In prompt số lượng phần tử của mảng
    li $v0, 4          
    la $a0, input_prompt     
    syscall            

    # Nhập số lượng phần tử của mảng từ bn phím
    li $v0, 5          
    syscall
    
    addi $t0, $zero, 101
    slt $t1, $v0, $t0  #check < 100
    beq $t1, $zero, exit  #check xem số bé hơn 100
    
    addi $t2, $zero, 1
    slt $t1, $v0, $t2  
    bne $t1, $zero, exit # check xem số phần tử bé hơn 1 ko
    add $t0, $zero, $v0 # Lưu số lượng phần tử vào $t0
    
    addi $t2, $zero, 1 # khởi tạo thứ tự đầu tiên của mảng
    
    jal read_int # lưu phần tử đầu tiên
    add $s2, $zero, $s1 # đặt giá trị max đầu tiên = phần tử đầu tiên
    sw $s1, 0($s0) # lưu vào mảng
    addi $s0, $s0, 4
    
    beq $t0, $t2, exit_add #check xem số phần tử lớn hơn 1 không, nếu có thì thoát nhập
    
    addi $t2, $t2, 1 # cập nhật thứ tự phần tử nhập vào
    j add_element

read_int: li $v0, 4          # System call for print_str
    la $a0, prompt     # Load address of prompt into $a0
    syscall            # Call operating system to perform operation
    
    li $v0, 1               # Lệnh in số nguyên
    add $a0, $t2, $zero           # Di chuyển số nguyên từ $t2 đến $a0 để in
    syscall
    
    li $v0, 4          # System call for print_str
    la $a0, prompt2     # Load address of prompt into $a0
    syscall 
    
    li $v0, 5               # Lệnh để đọc một số nguyên
    syscall
    add $s1, $zero, $v0
    
    jr $ra

add_element: 
    jal read_int
    
    slt $t3, $s2, $s1 # check xem giá trị mới nhập có phải giá trị lớn nhất không
    beq $t3, $zero, skip_save_max
    add $s2, $s1, $zero # lưu giá trị lớn nhất hiện thời
    
    skip_save_max:
    sw $s1, 0($s0) # lưu vào mảng
    addi $s0, $s0, 4
    
    addi $t2, $t2, 1 # cập nhật thứ tự phần tử nhập vào
    slt $t3, $t0, $t2
    beq $t3, $zero, add_element

exit_add: li $v0, 4 
    la $a0, comclu1_prompt     
    syscall            
    
    li $v0, 1               
    add $a0, $s2, $zero        # in ra giá trị lớn nhất trong mảng   
    syscall
    
    li $v0, 4          
    la $a0, enter_prompt     
    syscall 

#Nhập các giá trị m,M vào t1, t2
    # In prompt số m
    li $v0, 4          
    la $a0, strm   
    syscall            
	
    # nhập m
    li $v0, 5          
    syscall            
    add $t1, $zero, $v0 

    # In prompt số M
    li $v0, 4          
    la $a0, strM   
    syscall            

    # Nhập M
    li $v0, 5          
    syscall            
    add $t2, $zero, $v0 
    
    # bắt đầu xét 
    add $t3, $zero, $zero # count = 0
    addi $t6, $zero, 0 # temp = 0 -> số phần tử của mảng đã được xét
    la $s0, array # lấy phần tử đầu tiên của mảng
loop_count: lw $s1, 0($s0)
    slt $t4, $t1, $s1
    beq $t4, $zero, next_loop #so sánh với m
    slt $t4, $s1, $t2
    beq $t4, $zero, next_loop #so sánh với M
    
    addi $t3, $t3, 1 # tăng count
next_loop: addi $t6, $t6, 1
    addi $s0, $s0, 4
    bne $t6, $t0, loop_count
 
print_result:li $v0, 4 
    la $a0, comclu2_prompt     
    syscall            
    
    li $v0, 1               
    add $a0, $t3, $zero  # in ra số phần tử trong khoảng (m, M)         
    syscall
    
    li $v0, 4          
    la $a0, enter_prompt     
    syscall 
    
reset: li $v0, 4          
    la $a0, prompt_reset # in ra prompt hỏi người dùng có muốn lặp lại chương trình
    syscall  
    
    # nhập lựa chọn
    li $v0, 5          
    syscall
    
    bne $v0, $zero, main

exit:

	
    
    
    

    
    
