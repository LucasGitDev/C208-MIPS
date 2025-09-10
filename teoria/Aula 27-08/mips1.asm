# CARREGUE NOS REGISTRADORES
# $t1 = 0x25 (a)
# $t2 = 0x20 (b)
# $t3 = 0x30 (c)
# $t4 = 0x40 (d)
# e considere e=>$t5 e f=>$t6
# Realize as seguintes operações:
# a = b - c
.text
addi $t1,$0,0x25 #a
addi $t2,$0,0x20 #b
addi $t3,$0,0x30 #c
addi $t4,$0,0x40 #d

sub $t1,$t2,$t3
# d = (a + b - c)

# f = (a + b) - d
add $t6,$t1,$t2
sub $t6,$t6,$t4
# e = (a - (b - c) + f)
sub $t5,$t2,$t3
sub $t5,$t1,$t5
add $t5,$t5,$t6

# f = e - (a -b) + (b - c)
sub $t6,$t1,$t2
sub $t7,$t2,$t3
sub $t6,$t5,$t6
add $t6,$t6,$t7