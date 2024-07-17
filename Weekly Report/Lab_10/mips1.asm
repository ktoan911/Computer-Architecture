#Laboratory Exercise 10 Home Assignment 1 
.data
Number: .word 0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F
.eqv SEVENSEG_LEFT 0xFFFF0011		# Dia chi cua den led 7 doan trai.
					# Bit 0 = doan a;
					# Bit 1 = doan b; ...
					# Bit 7 = dau .		
.eqv SEVENSEG_RIGHT 0xFFFF0010		# Dia chi cua den led 7 doan phai

#0: 0x3F (abcdef)
#1: 0x06 (bc)
#2: 0x5B (abdeg)
#3: 0x4F (abcfg)
#4: 0x66 (bcfg)
#5: 0x6D (acdfg)
#6: 0x7D (acdefg)
#7: 0x07 (abc)
#8: 0x7F (abcdefg)
#9: 0x6F (abcdfg)
.text
main:
	li	$a0, 0x3F	# set value for segments
	jal	SHOW_7SEG_LEFT	#show
	nop
	
	la $s0, Number
	
	lw	$a0, 0($s0)	# set value for segments
	jal	SHOW_7SEG_RIGHT	# show

loop:
	addi    $s0, $s0, 4
loop09: lw	$a0, 0($s0)	# set value for segments
	jal	SHOW_7SEG_RIGHT	# show
	addi    $s0, $s0, 4
	li      $t1, 0x6F
	bne     $t1, $a0, loop09
	
	nop
	subi    $s0, $s0, 4
loop90: lw	$a0, 0($s0)	# set value for segments
	jal	SHOW_7SEG_RIGHT	# show
	subi    $s0, $s0, 4
	li      $t1, 0x3F
	bne     $t1, $a0, loop90
	
	
	j loop


#--------------------------------------------------------------
# Function SHOW_7SEG_LEFT
# param(in)	$a0 value to shown
# remark	$t0 changed
#--------------------------------------------------------------
SHOW_7SEG_LEFT:	li	$t0, SEVENSEG_LEFT	# assign port's address
		sb	$a0, 0($t0)		# assign new value
		nop
		jr	$ra
		nop
		
#-------------------------------------------------------------
# Function SHOW_7SEG_RIGHT:	turn on/off the 7seg
# param(in) $a0 	value to shown
# remark    $t0		changed
#-------------------------------------------------------------
SHOW_7SEG_RIGHT: li	$t0, SEVENSEG_RIGHT	# assign port's adress
		sb	$a0, 0($t0)		# assign new value
		nop
		jr	$ra
		nop
		
	
