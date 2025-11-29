# Exercício 2 - Sensores MIPS
# Calcula média de 3 sensores e determina status

# Inicialização dos arrays S1, S2, S3 na memória
# S1: [20, 12, 8, 16, 18, 20]
addiu $t0, $0, 0x000100    # Endereço base S1
addiu $t1, $0, 20
sw    $t1, 0($t0)
addiu $t1, $0, 12
sw    $t1, 4($t0)
addiu $t1, $0, 8
sw    $t1, 8($t0)
addiu $t1, $0, 16
sw    $t1, 12($t0)
addiu $t1, $0, 18
sw    $t1, 16($t0)
addiu $t1, $0, 20
sw    $t1, 20($t0)

# S2: [11, 3, 12, 17, 15, 19]
addiu $t0, $0, 0x000118    # Endereço base S2
addiu $t1, $0, 11
sw    $t1, 0($t0)
addiu $t1, $0, 3
sw    $t1, 4($t0)
addiu $t1, $0, 12
sw    $t1, 8($t0)
addiu $t1, $0, 17
sw    $t1, 12($t0)
addiu $t1, $0, 15
sw    $t1, 16($t0)
addiu $t1, $0, 19
sw    $t1, 20($t0)

# S3: [9, 8, 7, 14, 18, 22]
addiu $t0, $0, 0x000130    # Endereço base S3
addiu $t1, $0, 9
sw    $t1, 0($t0)
addiu $t1, $0, 8
sw    $t1, 4($t0)
addiu $t1, $0, 7
sw    $t1, 8($t0)
addiu $t1, $0, 14
sw    $t1, 12($t0)
addiu $t1, $0, 18
sw    $t1, 16($t0)
addiu $t1, $0, 22
sw    $t1, 20($t0)

# Inicialização de variáveis
addiu $s0, $0, 0x000100    # Endereço base S1
addiu $s1, $0, 0x000118    # Endereço base S2
addiu $s2, $0, 0x000130    # Endereço base S3
addiu $s3, $0, 0x001b0     # Endereço base médias
addiu $s4, $0, 0x001c0     # Endereço base status
addiu $s5, $0, 0            # Contador i = 0
addiu $s6, $0, 6            # Tamanho do array

# Loop principal
loop:
    # Verificar se i >= 6
    slt  $t0, $s5, $s6      # t0 = 1 se i < 6
    beq  $t0, $0, fim       # Se i >= 6, sair do loop
    
    # Calcular offset = i * 4
    sll  $s7, $s5, 2        # s7 = i * 4 (preservar offset)
    
    # Carregar S1[i], S2[i], S3[i]
    addu $t0, $s0, $s7      # t0 = endereço S1[i]
    lw   $t1, 0($t0)        # t1 = S1[i]
    addu $t0, $s1, $s7      # t0 = endereço S2[i]
    lw   $t2, 0($t0)        # t2 = S2[i]
    addu $t0, $s2, $s7      # t0 = endereço S3[i]
    lw   $t3, 0($t0)        # t3 = S3[i]
    
    # Calcular soma = S1[i] + S2[i] + S3[i]
    addu $t4, $t1, $t2      # t4 = S1[i] + S2[i]
    addu $t4, $t4, $t3      # t4 = soma total
    
    # Dividir por 3 usando loop de subtração (padrão do exercicio1.s)
    addu $t5, $0, $0        # t5 = contador (resultado da divisão)
    addu $t6, $t4, $0       # t6 = valor a dividir
    addiu $t7, $0, 3        # t7 = divisor (3)
    
div3_loop:
    # Verificar se podemos subtrair (t6 >= 3)
    # Se t6 < 3, não podemos mais subtrair, então sair
    subu $t0, $t6, $t7      # t0 = t6 - 3 (teste)
    bltz $t0, div3_done     # Se t6 - 3 < 0 (ou seja, t6 < 3), sair
    # Se chegou aqui, t6 >= 3, então podemos subtrair
    subu $t6, $t6, $t7      # t6 = t6 - 3
    addiu $t5, $t5, 1       # contador++
    j    div3_loop
    
div3_done:
    # t5 contém a média (divisão inteira)
    
    # Armazenar média em 0x001b0 + offset
    addu $t0, $s3, $s7      # t0 = endereço médias[i]
    sw   $t5, 0($t0)        # Armazenar média
    
    # Determinar status baseado na média
    addiu $t0, $0, 10       # t0 = 10
    addiu $t1, $0, 15       # t1 = 15
    addiu $t2, $0, 0        # t2 = status (inicializa com 0 = Baixo)
    
    # Verificar se média < 10
    slt  $t3, $t5, $t0      # t3 = 1 se média < 10
    bne  $t3, $0, status_baixo # Se média < 10, status = Baixo
    
    # Verificar se média < 15
    slt  $t3, $t5, $t1      # t3 = 1 se média < 15
    bne  $t3, $0, status_normal # Se 10 <= média < 15, status = Normal
    
    # Caso contrário, média >= 15, status = Alto
    addiu $t2, $0, 2        # status = 2 (Alto)
    j    armazena_status
    
status_baixo:
    addiu $t2, $0, 0        # status = 0 (Baixo)
    j    armazena_status
    
status_normal:
    addiu $t2, $0, 1        # status = 1 (Normal)
    j    armazena_status
    
armazena_status:
    # Armazenar status em 0x001c0 + offset
    addu $t0, $s4, $s7      # t0 = endereço status[i]
    sw   $t2, 0($t0)        # Armazenar status
    
    # Incrementar contador i
    addiu $s5, $s5, 1       # i++
    j    loop               # Voltar ao início do loop
    
fim:
    # Fim do programa


# Ao final, teremos:
#
# MÉDIAS (armazenadas a partir de 0x001b0):
# Endereço 0x001b0: 0x0000000d (13) - média de [20, 11, 9]
# Endereço 0x001b4: 0x00000007 (7)  - média de [12, 3, 8]
# Endereço 0x001b8: 0x00000009 (9)  - média de [8, 12, 7]
# Endereço 0x001bc: 0x0000000f (15) - média de [16, 17, 14]
# Endereço 0x001c0: 0x00000011 (17) - média de [18, 15, 18]
# Endereço 0x001c4: 0x00000014 (20) - média de [20, 19, 22]
#
# STATUS (armazenados a partir de 0x001c0):
# Endereço 0x001c0: 0x00000001 (1 = Normal) - média 13 está entre 10 e 15
# Endereço 0x001c4: 0x00000000 (0 = Baixo)  - média 7 é menor que 10
# Endereço 0x001c8: 0x00000000 (0 = Baixo)  - média 9 é menor que 10
# Endereço 0x001cc: 0x00000002 (2 = Alto)  - média 15 é maior ou igual a 15
# Endereço 0x001d0: 0x00000002 (2 = Alto)  - média 17 é maior ou igual a 15
# Endereço 0x001d4: 0x00000002 (2 = Alto)  - média 20 é maior ou igual a 15
#
# Valores de status:
# 0 = Baixo  (média < 10)
# 1 = Normal (10 <= média < 15)
# 2 = Alto   (média >= 15)
