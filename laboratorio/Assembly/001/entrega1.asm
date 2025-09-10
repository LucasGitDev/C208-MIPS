.text
# q1
# 0xFF & 0xF0 | 1 => 241

li $t1, 0xFF
li $t2, 0xF0
li $t3, 1

and $t4, $t1, $t2
or $t5, $t4, $t3

li $v0, 1
move $a0, $t5
syscall
