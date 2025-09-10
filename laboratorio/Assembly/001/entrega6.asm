.text
#q6
# 22 << (1 + (32 / (1 + 5 - 2)))  => 11264

li $t1, 22
li $t2, 1
li $t3, 32
li $t4, 5
li $t5, 2


# 1 + 5 - 2
add $t6, $t2, $t4
sub $t6, $t6, $t5

# 32 / (1 + 5 - 2)
div $t7, $t3, $t6
mflo $t7

# 1 + (32 / (1 + 5 - 2))
add $t8, $t2, $t7

# 22 << (1 + (32 / (1 + 5 - 2)))
sllv $t9, $t1, $t8

li $v0, 1
move $a0, $t9
syscall
