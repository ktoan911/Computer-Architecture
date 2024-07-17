.eqv MONITOR_SCREEN 0x10010000 #Dia chi bat dau cua bo nho man hinh
.eqv RED 0x00FF0000 #Cac gia tri mau thuong su dung
.eqv GREEN 0x0000FF00
.eqv BLUE 0x000000FF
.eqv WHITE 0x00FFFFFF
.eqv YELLOW 0x00FFFF00
.eqv BLACK 0x00000000
.text


 li $k0, MONITOR_SCREEN #Nap dia chi bat dau cua man hinh
 addi $k0, $k0, 28
 li $t0, RED
 sw $t0, 0($k0)
 add $t1, $zero, $zero
 li $t2, 7
 nop
 
loop:
 li $t0, BLACK
 sw $t0, 0($k0)
 nop
 
 addi $t1, $t1, 1
 subi $k0, $k0, 4
 
 li $t0, RED
 sw $t0, 0($k0)
 nop
 
 bne $t1, $t2, loop
 
 