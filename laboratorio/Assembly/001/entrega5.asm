.text
#q5
# (44 >> 1) +1 => 23

li $t1, 44
srl $t1, $t1, 1
addi $t1, $t1, 1

li $v0, 1
move $a0, $t1
syscall