.data
    promptN: .asciiz "Digite a quantidade de números: "
    promptVal: .asciiz "Digite um número: "
    newline: .asciiz "\n"

.text
.globl main

main:
    # Ler a quantidade de números
    la $a0, promptN
    li $v0, 4
    syscall
    
    li $v0, 5
    syscall
    move $s0, $v0  # $s0 = quantidade de números (n)
    
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
    beq $t1, $zero, sort_array
    
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

sort_array:
    # Bubble sort
    li $t0, 0  # i = 0
    
outer_loop:
    addi $t1, $s0, -1  # n-1
    slt $t2, $t0, $t1  # i < n-1?
    beq $t2, $zero, print_array
    
    li $t3, 0  # j = 0
    sub $t4, $s0, $t0  # n-i
    addi $t4, $t4, -1  # n-i-1
    
inner_loop:
    slt $t5, $t3, $t4  # j < n-i-1?
    beq $t5, $zero, end_inner_loop
    
    # Carregar array[j] e array[j+1]
    sll $t6, $t3, 2  # j * 4
    add $t7, $s1, $t6  # endereço de array[j]
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

print_array:
    # Imprimir números ordenados
    li $t0, 0  # contador i = 0
    
print_loop:
    slt $t1, $t0, $s0  # i < n?
    beq $t1, $zero, end_program
    
    # Carregar e imprimir array[i]
    sll $t2, $t0, 2  # i * 4
    add $t3, $s1, $t2  # endereço do elemento i
    lw $a0, 0($t3)  # array[i]
    li $v0, 1
    syscall
    
    # Imprimir nova linha
    la $a0, newline
    li $v0, 4
    syscall
    
    addi $t0, $t0, 1  # i++
    j print_loop

end_program:
    li $v0, 10
    syscall