.text
# q3
# 12 + 44 - 33 => 23

li $t1, 12
li $t2, 44
li $t3, 33

add $t0, $t1, $t2
sub $t0, $t0, $t3

li $v0, 1
move $a0, $t0
syscall