.text
#Exemplo 28 + 13 = 41

# li $t1, 28
# li $t2, 13
# add $t0, $t1, $t2

# li $v0, 1
# move $a0, $t0
# syscall

# 1 - 2 + 10 * 3 / 2 = 14

# li $t1, 1
# li $t2, 2
# li $t3, 10
# li $t4, 3

# mult $t3, $t4
# mflo $t0
# div $t0, $t0, $t2
# add $t0, $t0, $t1
# sub $t0, $t0, $t2

# li $v0, 1
# move $a0, $t0
# syscall

# 420 / 2 + 4 = 214

li $t1, 420
li $t2, 2
li $t3, 4

li $t0, 0

div $t1, $t1, $t2
add $t0, $t1, $t3

li $v0, 1
move $a0, $t0
syscall