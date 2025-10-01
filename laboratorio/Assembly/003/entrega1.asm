.data
    data: .byte 10, 20, 30, 3, 2, 4

.text 

    la $t0, data        # endereço base do array (usando label)

    li $t1, 6           # tamanho do array

    addi $t2, $0, 0     # contador
    addi $t3, $0, 0     # soma

    jal sum
    jal print

    j fim

sum:
    # $t0: endereço base do array
    # $t1: tamanho do array
    # $t2: contador
    # $t3: soma
    lb $t4, ($t0)       # carrega o elemento atual do array
    add $t3, $t3, $t4   # soma o elemento à soma total
    addi $t0, $t0, 1    # incrementa o endereço para o próximo elemento
    addi $t2, $t2, 1    # incrementa o contador
    blt $t2, $t1, sum   # se contador < tamanho, continua
    jr $ra

print:
    move $a0, $t3
    li $v0, 1
    syscall
    jr $ra

fim:

    li $v0, 10
    syscall
