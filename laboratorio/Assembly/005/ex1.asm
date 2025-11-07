.data
    promptN: .asciiz "Digite a quantidade de números: "
    promptVal: .asciiz "Digite um número: "
    newline: .asciiz "\n"

.text
.globl main

main:
    # Salvar registradores $ra na pilha
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    
    # Chamar função para ler quantidade de números
    jal read_quantity
    move $s0, $v0  # $s0 = quantidade de números (n)
    
    # Chamar função para ler os números
    move $a0, $s0  # passar quantidade como parâmetro
    jal read_numbers
    move $s1, $v0  # $s1 = endereço do array
    
    # Chamar função para ordenar
    move $a0, $s1  # endereço do array
    move $a1, $s0  # quantidade de números
    jal sort_array
    
    # Chamar função para imprimir
    move $a0, $s1  # endereço do array
    move $a1, $s0  # quantidade de números
    jal print_array
    
    # Restaurar $ra e finalizar
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    j end_program

# ------------------------------------------------------------
# FUNÇÃO: read_quantity
# Retorna: $v0 = quantidade de números
# ------------------------------------------------------------
read_quantity:
    # Salvar $ra na pilha
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    
    # Imprimir prompt
    la $a0, promptN
    li $v0, 4
    syscall
    
    # Ler número
    li $v0, 5
    syscall
    
    # Restaurar $ra e retornar
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra

# ------------------------------------------------------------
# FUNÇÃO: read_numbers
# Parâmetros: $a0 = quantidade de números
# Retorna: $v0 = endereço do array
# ------------------------------------------------------------
read_numbers:
    # Salvar registradores na pilha
    addi $sp, $sp, -12
    sw $ra, 0($sp)
    sw $s0, 4($sp)
    sw $s1, 8($sp)
    
    move $s0, $a0  # $s0 = quantidade de números
    
    # Alocar array de N inteiros (4 bytes cada)
    li $v0, 9
    move $a0, $s0
    sll $a0, $a0, 2  # multiplicar por 4 (tamanho de um inteiro)
    syscall
    move $s1, $v0  # $s1 = endereço do array
    
    # Ler N números e armazenar no array
    li $t0, 0  # contador i = 0
    
read_loop:
    slt $t1, $t0, $s0  # i < n?
    beq $t1, $zero, end_read_loop
    
    # Imprimir prompt
    la $a0, promptVal
    li $v0, 4
    syscall
    
    # Ler número
    li $v0, 5
    syscall
    
    # Armazenar no array
    sll $t2, $t0, 2  # i * 4 (offset)
    add $t3, $s1, $t2  # endereço do elemento i
    sw $v0, 0($t3)  # array[i] = número lido
    
    addi $t0, $t0, 1  # i++
    j read_loop

end_read_loop:
    move $v0, $s1  # retornar endereço do array
    
    # Restaurar registradores
    lw $ra, 0($sp)
    lw $s0, 4($sp)
    lw $s1, 8($sp)
    addi $sp, $sp, 12
    jr $ra

# ------------------------------------------------------------
# FUNÇÃO: sort_array
# Parâmetros: $a0 = endereço do array, $a1 = quantidade de números
# ------------------------------------------------------------
sort_array:
    # Salvar registradores na pilha
    addi $sp, $sp, -16
    sw $ra, 0($sp)
    sw $s0, 4($sp)
    sw $s1, 8($sp)
    sw $s2, 12($sp)
    
    move $s0, $a0  # $s0 = endereço do array
    move $s1, $a1  # $s1 = quantidade de números
    
    # Bubble sort
    li $t0, 0  # i = 0
    
outer_loop:
    addi $t1, $s1, -1  # n-1
    slt $t2, $t0, $t1  # i < n-1?
    beq $t2, $zero, end_sort
    
    li $t3, 0  # j = 0
    sub $t4, $s1, $t0  # n-i
    addi $t4, $t4, -1  # n-i-1
    
inner_loop:
    slt $t5, $t3, $t4  # j < n-i-1?
    beq $t5, $zero, end_inner_loop
    
    # Carregar array[j] e array[j+1]
    sll $t6, $t3, 2  # j * 4
    add $t7, $s0, $t6  # endereço de array[j]
    lw $t8, 0($t7)  # array[j]
    lw $t9, 4($t7)  # array[j+1]
    
    # Se array[j] > array[j+1], trocar
    slt $t5, $t9, $t8  # array[j+1] < array[j]?
    beq $t5, $zero, no_swap
    
    # Trocar elementos
    sw $t9, 0($t7)  # array[j] = array[j+1]
    sw $t8, 4($t7)  # array[j+1] = array[j]
    
no_swap:
    addi $t3, $t3, 1  # j++
    j inner_loop
    
end_inner_loop:
    addi $t0, $t0, 1  # i++
    j outer_loop

end_sort:
    # Restaurar registradores
    lw $ra, 0($sp)
    lw $s0, 4($sp)
    lw $s1, 8($sp)
    lw $s2, 12($sp)
    addi $sp, $sp, 16
    jr $ra

# ------------------------------------------------------------
# FUNÇÃO: print_array
# Parâmetros: $a0 = endereço do array, $a1 = quantidade de números
# ------------------------------------------------------------
print_array:
    # Salvar registradores na pilha
    addi $sp, $sp, -12
    sw $ra, 0($sp)
    sw $s0, 4($sp)
    sw $s1, 8($sp)
    
    move $s0, $a0  # $s0 = endereço do array
    move $s1, $a1  # $s1 = quantidade de números
    
    # Imprimir números ordenados
    li $t0, 0  # contador i = 0
    
print_loop:
    slt $t1, $t0, $s1  # i < n?
    beq $t1, $zero, end_print
    
    # Carregar e imprimir array[i]
    sll $t2, $t0, 2  # i * 4
    add $t3, $s0, $t2  # endereço do elemento i
    lw $a0, 0($t3)  # array[i]
    li $v0, 1
    syscall
    
    # Imprimir nova linha
    la $a0, newline
    li $v0, 4
    syscall
    
    addi $t0, $t0, 1  # i++
    j print_loop

end_print:
    # Restaurar registradores
    lw $ra, 0($sp)
    lw $s0, 4($sp)
    lw $s1, 8($sp)
    addi $sp, $sp, 12
    jr $ra

# ------------------------------------------------------------
# FIM DO PROGRAMA
# ------------------------------------------------------------
end_program:
    li $v0, 10
    syscall
