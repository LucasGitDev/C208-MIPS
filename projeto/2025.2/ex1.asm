
# Calculando x1 = (-b + √Δ) / 2a = (5 + 1) / 2 = 3
addiu $t0, $zero, 5
addiu $t1, $zero, 1
add $t0, $t0, $t1
addiu $t1, $zero, 2
div $t0, $t1
mflo $s0

# Calculando x2 = (-b - √Δ) / 2a = (5 - 1) / 2 = 2
addiu $t0, $zero, 5
addiu $t1, $zero, 1
sub $t0, $t0, $t1
addiu $t1, $zero, 2
div $t0, $t1
mflo $s1

# Armazenando na memória
addiu $t0, $zero, 0x10010020
sw $s0, 0($t0)
sw $s1, 4($t0)

addiu $v0, $zero, 10
syscall

# Ao final, teremos:
# 0x10010020: 3
# 0x10010024: 2
