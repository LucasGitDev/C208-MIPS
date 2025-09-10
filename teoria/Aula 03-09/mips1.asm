# x = 10 ($t1)
# y = 20 ($t2)
# z = 10 ($t3)
# se x == y então:
# z = z+1
# senão:
# z = z-1

li $t1, 0x20
li $t2, 0x20
li $t3, 10

beq $t1, $t2,desvia
    addi $t3,$t3,-1
    j fim
desvia:
    addi $t3, $t3, 0x1
    j fim

fim:
# imprime o valor de z
li $v0, 1 # -> load immediate "1" para o registrador $v0 (responsavel por escolher a função de saída do programa)
move $a0, $t3 # -> move o valor de $t3 para o registrador $a0 (responsavel por passar o valor para a função de saída do programa)
syscall # -> syscall (chamada de sistema) - chama a função de saída do programa