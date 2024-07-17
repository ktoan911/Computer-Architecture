#------------------------------------------------------
# col 0x1 col 0x2 col 0x4 col 0x8
#
# row 0x1 0 1 2 3
# 0x11 0x21 0x41 0x81
#
# row 0x2 4 5 6 7
# 0x12 0x22 0x42 0x82
#
# row 0x4 8 9 a b
# 0x14 0x24 0x44 0x84
#
# row 0x8 c d e f
# 0x18 0x28 0x48 0x88
#
#------------------------------------------------------
# command row number of hexadecimal keyboard (bit 0 to 3)
# Eg. assign 0x1, to get key button 0,1,2,3
# assign 0x2, to get key button 4,5,6,7
# NOTE must reassign value for this address before reading,
# eventhough you only want to scan 1 row
.eqv IN_ADRESS_HEXA_KEYBOARD 0xFFFF0012
# receive row and column of the key pressed, 0 if not key pressed
# Eg. equal 0x11, means that key button 0 pressed.
# Eg. equal 0x28, means that key button D pressed.
.eqv OUT_ADRESS_HEXA_KEYBOARD 0xFFFF0014

main: li $t1, IN_ADRESS_HEXA_KEYBOARD
 li $t2, OUT_ADRESS_HEXA_KEYBOARD

polling_1:li $t3, 0x01 # row 1
 sb $t3, 0($t1 ) # must reassign expected row
 lb $a0, 0($t2) # read scan code of key button
 beq $a0, 0x0, polling_2
 j print
polling_2:li $t3, 0x02 # row 2
 sb $t3, 0($t1 ) # must reassign expected row
 lb $a0, 0($t2) # read scan code of key button
 beq $a0, 0x0, polling_3
 j print
 polling_3:li $t3, 0x04 # row 3
 sb $t3, 0($t1 ) # must reassign expected row
 lb $a0, 0($t2) # read scan code of key button
 beq $a0, 0x0, polling_4
 j print
 polling_4:li $t3, 0x08 # row 4
 sb $t3, 0($t1 ) # must reassign expected row
 lb $a0, 0($t2) # read scan code of key button
 j print
back_to_polling: j polling_1 # continue polling

print: 
 li $v0, 34 # print integer (hexa)
 syscall
sleep: li $a0, 100 # sleep 100ms
 li $v0, 32
 syscall
 j back_to_polling
