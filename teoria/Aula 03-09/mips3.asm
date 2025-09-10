# i = 100 ($t1)
# k = 200 ($t2)
# for j = 1 to 4:
# i += 1
# k -= 1

.text

li $t1, 100 # i = 100
li $t2, 200 # k = 200
li $t3, 1 # j = 1

for:
    bgt $t3, 4, fim
    addi $t1, $t1, 1
    addi $t2, $t2, -1
    addi $t3, $t3, 1
    j for
fim:
# imprime o valor de i
li $v0, 1
move $a0, $t1
syscall

# imprime o valor de k
li $v0, 1
move $a0, $t2
syscall
