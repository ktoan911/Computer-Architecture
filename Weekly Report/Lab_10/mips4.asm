.eqv KEY_CODE 0xFFFF0004 # ASCII code from keyboard, 1 byte
.eqv KEY_READY 0xFFFF0000 # =1 if has a new keycode ?
 # Auto clear after lw
.eqv DISPLAY_CODE 0xFFFF000C # ASCII code to show, 1 byte
.eqv DISPLAY_READY 0xFFFF0008 # =1 if the display has already to do
 # Auto clear after sw
.text
 li $k0, KEY_CODE
 li $k1, KEY_READY

 li $s0, DISPLAY_CODE
 li $s1, DISPLAY_READY
 
 li $t6, 0
 li $t5, 4
loop: nop

WaitForKey: lw $t1, 0($k1) # $t1 = [$k1] = KEY_READY
 nop
 beq $t1, $zero, WaitForKey # if $t1 == 0 then Polling
 nop
 #-----------------------------------------------------
ReadKey: lw $t0, 0($k0) # $t0 = [$k0] = KEY_CODE
 nop
 #-----------------------------------------------------
WaitForDis: lw $t2, 0($s1) # $t2 = [$s1] = DISPLAY_READY
 nop
 beq $t2, $zero, WaitForDis # if $t2 == 0 then Polling
 nop
 #-----------------------------------------------------

ShowKey: sw $t0, 0($s0) # show key
 nop
 #-----------------------------------------------------
  	  #check exit
 beq $t0, 'e', continue_fake
 beq $t0, 'x', checkx
 beq $t0, 'i', checki
 beq $t0, 't', checkt
 j continue
continue_fake2: addi $t6, $t6, 1
j continue
continue_fake: addi $t6, $zero, 1

continue: beq $t6, $t5, exit
 j loop
 nop
 
checkx: 
  li $t3, 1
  beq $t6, $t3, continue_fake2
  j continue
checki: 
  li $t3, 2
  beq $t6, $t3 continue_fake2
  j continue
checkt: 
  li $t3, 3
  beq $t6, $t3, continue_fake2
  j continue
  
 exit:
 	
