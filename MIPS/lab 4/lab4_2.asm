.text
li $s0, 0x0563  

#Extract MSB of $s0
srl $s1, $s0, 24

#Clear LSB of $s0
andi $s0, $s0, 0xffffff00

#Set LSB of $s0 (bits 7 to 0 are set to 1)
ori $s0, $s0, 0x000000ff

#clear $s0
xor $s0, $s0, $s0
