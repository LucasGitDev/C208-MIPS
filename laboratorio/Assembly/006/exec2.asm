.data
    menu_msg: .asciiz "\n=== MENU DE EXERCÍCIOS ===\n"
    op1_msg: .asciiz "1 - Soma de números em array\n"
    op2_msg: .asciiz "2 - Cálculo de fatorial\n"
    op3_msg: .asciiz "3 - Sair\n"
    escolha_msg: .asciiz "Escolha uma opção (1-3): "
    
    ex1_msg: .asciiz "\n=== EXERCÍCIO 1: SOMA DE NÚMEROS ===\n"
    qtd_msg: .asciiz "Insira a quantidade de números inteiros dentro do array: "
    num_msg: .asciiz "Insira um número: "
    soma_result: .asciiz "A soma dos números é: "
    
    ex2_msg: .asciiz "\n=== EXERCÍCIO 2: FATORIAL ===\n"
    fat_msg: .asciiz "Insira o valor que vai ser feito o fatorial: "
    fat_result: .asciiz "O fatorial é: "
    
    newline: .asciiz "\n"
    invalida_msg: .asciiz "Opção inválida! Tente novamente.\n"
    tchau_msg: .asciiz "Obrigado por usar o programa!\n"
    
    array: .align 2
          .space 400

.text
.globl main

main:
menu_loop:
    li $v0, 4
    la $a0, menu_msg
    syscall
    
    li $v0, 4
    la $a0, op1_msg
    syscall
    
    li $v0, 4
    la $a0, op2_msg
    syscall
    
    li $v0, 4
    la $a0, op3_msg
    syscall
    
    li $v0, 4
    la $a0, escolha_msg
    syscall
    
    li $v0, 5
    syscall
    move $t0, $v0
    
    beq $t0, 1, exercicio1
    beq $t0, 2, exercicio2
    beq $t0, 3, sair
    
    li $v0, 4
    la $a0, invalida_msg
    syscall
    j menu_loop

exercicio1:
    li $v0, 4
    la $a0, ex1_msg
    syscall
    
    li $v0, 4
    la $a0, qtd_msg
    syscall
    
    li $v0, 5
    syscall
    move $s0, $v0
    
    li $t0, 0
    li $s1, 0
    la $s2, array
    
loop_ler:
    bge $t0, $s0, fim_ler
    
    li $v0, 4
    la $a0, num_msg
    syscall
    
    li $v0, 5
    syscall
    move $t1, $v0
    
    sw $t1, 0($s2)
    add $s1, $s1, $t1
    addi $t0, $t0, 1
    addi $s2, $s2, 4
    
    j loop_ler

fim_ler:
    li $v0, 4
    la $a0, soma_result
    syscall
    
    li $v0, 1
    move $a0, $s1
    syscall
    
    li $v0, 4
    la $a0, newline
    syscall
    
    j menu_loop

exercicio2:
    li $v0, 4
    la $a0, ex2_msg
    syscall
    
    li $v0, 4
    la $a0, fat_msg
    syscall
    
    li $v0, 5
    syscall
    move $s0, $v0
    
    li $s1, 1
    
loop_fatorial:
    ble $s0, $zero, fim_fatorial
    
    mul $s1, $s1, $s0
    subi $s0, $s0, 1
    
    j loop_fatorial

fim_fatorial:
    li $v0, 4
    la $a0, fat_result
    syscall
    
    li $v0, 1
    move $a0, $s1
    syscall
    
    li $v0, 4
    la $a0, newline
    syscall
    
    j menu_loop

sair:
    li $v0, 4
    la $a0, tchau_msg
    syscall
    
    li $v0, 10
    syscall
