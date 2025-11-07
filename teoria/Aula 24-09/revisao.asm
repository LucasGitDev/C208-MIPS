# ========================================
# EXERCÍCIO INTEGRADOR - REVISÃO MIPS
# ========================================
# 
# PROBLEMA:
# Dado um número inteiro N (1 ≤ N ≤ 10), leia N inteiros e armazene-os em um vetor.
# Calcule e exiba as seguintes estatísticas e transformações:
#
# ENTRADA:
# - Um inteiro N (1 ≤ N ≤ 10)
# - N inteiros seguintes
#
# PROCESSAMENTO:
# 1. Armazenamento: Salve os N inteiros em um vetor
# 2. Estatísticas básicas: Calcule soma, mínimo e máximo
# 3. Contagem: Conte quantos números são pares
# 4. Busca: Encontre o primeiro número negativo (ou -1 se não houver)
# 5. Média: Calcule a média inteira (soma ÷ N)
# 6. Operação bitwise: Para o primeiro elemento, calcule (arr[0] & 0xF0) | 1
#
# SAÍDA:
# - (arr[0] & 0xF0) | 1: [valor]
# - Soma: [valor]
# - Min: [valor]
# - Max: [valor]
# - Qtde pares: [valor]
# - Primeiro negativo: [valor] (ou -1 se não houver)
# - Media inteira: [valor]
#
# EXEMPLO:
# Entrada: 5, 10, -3, 8, -1, 12
# Saída: 17, 26, -3, 12, 3, -3, 5
#
# CONCEITOS ABORDADOS:
# - Seções .data e .text, Syscalls, Aritmética, Bitwise
# - Controle de fluxo, Acesso à memória, Laços for/while
# ========================================

.data
    promptN:        .asciiz "Informe N (1..10): "
    promptVal:      .asciiz "Informe o valor: "
    lblSoma:        .asciiz "Soma: "
    lblMin:         .asciiz "Min: "
    lblMax:         .asciiz "Max: "
    lblQtdePar:     .asciiz "Qtde pares: "
    lblPrimeiroNeg: .asciiz "Primeiro negativo: "
    lblMedia:       .asciiz "Media inteira: "
    lblBitwise:     .asciiz "(arr[0] & 0xF0) | 1: "
    nl:             .asciiz "\n"
    arr:            .word 0:10       # ate 10 inteiros (10 * 4 bytes)

.text

main:
    # Le N
    li $v0, 4
    la $a0, promptN
    syscall

    li $v0, 5
    syscall
    addi $s0, $v0, 0         # s0 = N

    # Se N > 10, cap em 10
    slti $t0, $s0, 11        # t0=1 se N<11
    bne $t0, $zero, n_ok 
    addi $s0, $zero, 10

n_ok: 
    # Base do vetor em s2
    la $s2, arr

    # i = 0 (s1)
    addi $s1, $zero, 0

read_loop:
    # if i >= N -> fim leitura
    slt $t1, $s1, $s0        # t1=1 se i<N
    beq $t1, $zero, end_read

    # prompt valor
    li $v0, 4
    la $a0, promptVal
    syscall

    # read int
    li $v0, 5
    syscall

    # endereco arr[i]
    sll $t2, $s1, 2          # t2 = i*4
    add $t3, $s2, $t2        # t3 = &arr[i]
    sw $v0, 0($t3)

    # i++
    addi $s1, $s1, 1
    j read_loop

end_read:
    # Inicializacoes para processamento
    addi $s3, $zero, 0       # soma
    # min = arr[0] (se N>0) senao 0
    addi $t4, $zero, 0
    beq $s0, $zero, init_minmax_zero
    lw $s4, 0($s2)           # min
    lw $s5, 0($s2)           # max
    j init_minmax_done

init_minmax_zero:
    addi $s4, $zero, 0
    addi $s5, $zero, 0

init_minmax_done:
    addi $s6, $zero, 0       # qtde pares
    addi $s7, $zero, -1      # primeiro negativo (valor), -1 se nao houver

    # bitwise expr para arr[0]
    addi $t8, $zero, 0       # flag temPrimeiro = 0
    beq $s0, $zero, skip_bitwise0
    lw $t9, 0($s2)           # t9 = arr[0]
    addi $t0, $zero, 0xF0    # mascara 0xF0
    and $t9, $t9, $t0        # t9 = arr[0] & 0xF0
    addi $t0, $zero, 1
    or  $t9, $t9, $t0        # t9 = (arr[0] & 0xF0) | 1
    addi $t8, $zero, 1
skip_bitwise0:

    # for (i=0; i<N; i++) { soma/min/max/pares }
    addi $s1, $zero, 0

proc_for:
    slt $t1, $s1, $s0
    beq $t1, $zero, end_for

    sll $t2, $s1, 2
    add $t3, $s2, $t2
    lw $t4, 0($t3)           # t4 = arr[i]

    # soma += arr[i]
    add $s3, $s3, $t4

    # if (arr[i] < min) min = arr[i]
    slt $t5, $t4, $s4
    beq $t5, $zero, skip_min
    addi $s4, $t4, 0
skip_min:

    # if (arr[i] > max) max = arr[i]
    slt $t6, $s5, $t4        # t6=1 se max < arr[i]
    beq $t6, $zero, skip_max
    addi $s5, $t4, 0
skip_max:

    # se par: (arr[i] & 1) == 0
    addi $t7, $zero, 1
    and $t6, $t4, $t7
    bne $t6, $zero, skip_par
    addi $s6, $s6, 1
skip_par:

    # i++
    addi $s1, $s1, 1
    j proc_for

end_for:

    # while: encontrar primeiro negativo; s1 = 0
    addi $s1, $zero, 0

find_neg_while:
    slt $t1, $s1, $s0
    beq $t1, $zero, end_find_neg     # i>=N encerra

    sll $t2, $s1, 2
    add $t3, $s2, $t2
    lw $t4, 0($t3)

    slt $t5, $t4, $zero      # t5=1 se arr[i] < 0
    beq $t5, $zero, cont_find
    addi $s7, $t4, 0         # primeiro negativo = arr[i]
    j end_find_neg

cont_find:
    addi $s1, $s1, 1
    j find_neg_while

end_find_neg:

    # media inteira: soma / N (se N>0)
    addi $t0, $zero, 0
    beq $s0, $zero, media_zero
    div $s3, $s0
    mflo $t0
media_zero:

    # Saidas
    # bitwise de arr[0]
    beq $t8, $zero, skip_print_bitwise
    li $v0, 4
    la $a0, lblBitwise
    syscall
    li $v0, 1
    addi $a0, $t9, 0
    syscall
    li $v0, 4
    la $a0, nl
    syscall
skip_print_bitwise:

    # Soma
    li $v0, 4
    la $a0, lblSoma
    syscall
    li $v0, 1
    addi $a0, $s3, 0
    syscall
    li $v0, 4
    la $a0, nl
    syscall

    # Min
    li $v0, 4
    la $a0, lblMin
    syscall
    li $v0, 1
    addi $a0, $s4, 0
    syscall
    li $v0, 4
    la $a0, nl
    syscall

    # Max
    li $v0, 4
    la $a0, lblMax
    syscall
    li $v0, 1
    addi $a0, $s5, 0
    syscall
    li $v0, 4
    la $a0, nl
    syscall

    # Qtde pares
    li $v0, 4
    la $a0, lblQtdePar
    syscall
    li $v0, 1
    addi $a0, $s6, 0
    syscall
    li $v0, 4
    la $a0, nl
    syscall

    # Primeiro negativo (ou -1)
    li $v0, 4
    la $a0, lblPrimeiroNeg
    syscall
    li $v0, 1
    addi $a0, $s7, 0
    syscall
    li $v0, 4
    la $a0, nl
    syscall

    # Media
    li $v0, 4
    la $a0, lblMedia
    syscall
    li $v0, 1
    addi $a0, $t0, 0
    syscall
    li $v0, 4
    la $a0, nl
    syscall

    # exit
    li $v0, 10
    syscall


