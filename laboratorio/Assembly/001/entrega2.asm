.text
# q2
# (OxFF & 1) - (2 | 4) + (10 * (4 >> 1) / (1 << 1)) => 5

li $t1, 0xFF
li $t2, 1
li $t3, 2
li $t4, 4
li $t5, 10

and $t6, $t1, $t2
or $t7, $t3, $t4
sub $t0, $t6, $t7

# deslocar 4 >> 1
srl $t8, $t4, 1

# deslocar 1 << 1
sll $t9, $t2, 1

mult $t5, $t8
mflo $t8
div $t8, $t8, $t9
add $t0, $t0, $t8

li $v0, 1
move $a0, $t0
syscall