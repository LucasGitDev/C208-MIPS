.data
    menu: .asciiz "Escolha a figura:\n1 - Trapézio\n2 - Retângulo\n3 - Triângulo\n"
    optexto: .asciiz "Digite a opção: "
    trapeziob1: .asciiz "Digite a base maior: "
    trapeziob2: .asciiz "Digite a base menor: "
    trapezioh: .asciiz "Digite a altura: "
    printtrapezio: .asciiz "A área do trapézio é: "
    retangulob: .asciiz "Digite a base: "
    retanguloh: .asciiz "Digite a altura: "
    printretangulo: .asciiz "A área do retângulo é: "
    triangulob: .asciiz "Digite a base: "
    trianguloh: .asciiz "Digite a altura: "
    printtriangulo: .asciiz "A área do triângulo é: "
    opcaoinvalidatxt: .asciiz "Opção inválida\n"

.text

# Imprimir menu
li $v0, 4
la $a0, menu
syscall

# Ler opção
li $v0, 4
la $a0, optexto
syscall
li $v0, 5
syscall
add $t1, $0, $v0

beq $t1, 1, funcao_trapezio
beq $t1, 2, funcao_retangulo
beq $t1, 3, funcao_triangulo
j opcaoinvalida



# FUNCIONANDO!
funcao_trapezio:
    # Varivaveis serão: $t5, $t6, $t7
    li $v0, 4
    la $a0, trapeziob1
    syscall
    li $v0, 5
    syscall
    add $t5, $0, $v0
    li $v0, 4
    la $a0, trapeziob2
    syscall
    li $v0, 5
    syscall
    add $t6, $0, $v0
    li $v0, 4
    la $a0, trapezioh
    syscall
    li $v0, 5
    syscall
    add $t7, $0, $v0
    # processamento => (b1 + b2) * h / 2
    li $t8, 2
    add $t9, $t5, $t6
    mul $t9, $t9, $t7
    div $t9, $t9, $t8
    # saida
    li $v0, 4
    la $a0, printtrapezio
    syscall
    li $v0, 1
    move $a0, $t9
    syscall
    j fim

# FUNCIONANDO!
funcao_retangulo:
    li $v0, 4
    la $a0, retangulob
    syscall
    li $v0, 5
    syscall
    add $t5, $0, $v0
    li $v0, 4
    la $a0, retanguloh
    syscall
    li $v0, 5
    syscall
    add $t6, $0, $v0
    # processamento => b * h
    mul $t7, $t5, $t6
    # saida
    li $v0, 4
    la $a0, printretangulo
    syscall
    li $v0, 1
    move $a0, $t7
    syscall
    j fim

# FUNCIONANDO!
funcao_triangulo:
    li $v0, 4
    la $a0, triangulob
    syscall
    li $v0, 5
    syscall
    add $t5, $0, $v0
    li $v0, 4
    la $a0, trianguloh
    syscall
    li $v0, 5
    syscall
    add $t6, $0, $v0
    # processamento => b * h / 2
    mul $t7, $t5, $t6
    li $t8, 2
    div $t7, $t7, $t8
    # saida
    li $v0, 4
    la $a0, printtriangulo
    syscall
    li $v0, 1
    move $a0, $t7
    syscall
    j fim

# FUNCIONANDO!
opcaoinvalida:
    li $v0, 4
    la $a0, opcaoinvalidatxt
    syscall
    j fim

fim:
    li $v0, 10
    syscall