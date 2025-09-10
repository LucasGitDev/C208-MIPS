.text

#q4
# 12 / (2 + 4 - 11) => -2

li $t1, 12
li $t2, 2
li $t3, 4
li $t4, 11

add $t5, $t2, $t3
sub $t5, $t5, $t4
div $t0, $t1, $t5

li $v0, 1
move $a0, $t0
syscall