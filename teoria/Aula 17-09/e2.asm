.data
    input: .asciiz "Entre com o número do candidato: "
    menutxt: .asciiz "Menu:\n1 - Carlos\n2 - Pedro\n3 - Zulmira\n0 - Finalizar"
    votos_carlos: .word 0
    votos_pedro: .word 0
    votos_zulmira: .word 0
    finalizartxt: .asciiz "\nVotação finalizada\n"
    carlostxt: .asciiz "\nCarlos: "
    pedrotxt: .asciiz "\nPedro: "
    zulmiratxt: .asciiz "\nZulmira: "
    carlos_ganhotxt: .asciiz "\nCarlos ganhou\n"
    pedro_ganhotxt: .asciiz "\nPedro ganhou\n"
    zulmira_ganhotxt: .asciiz "\nZulmira ganhou\n"

.text

iniciar:


jal menu
jal ler_voto

beq $t1, 1, somar_carlos
beq $t1, 2, somar_pedro
beq $t1, 3, somar_zulmira
beq $t1, 0, finalizar

j iniciar
# FUNÇÕES:

somar_carlos:
    lw $t2, votos_carlos
    addi $t2, $t2, 1
    sw $t2, votos_carlos
    j iniciar

somar_pedro:
    lw $t2, votos_pedro
    addi $t2, $t2, 1
    sw $t2, votos_pedro
    j iniciar

somar_zulmira:
    lw $t2, votos_zulmira
    addi $t2, $t2, 1
    sw $t2, votos_zulmira
    j iniciar

ler_voto:
    li $v0, 4
    la $a0, input
    syscall
    li $v0, 5
    syscall
    add $t1, $0, $v0
    jr $ra

menu:
    li $v0, 4
    la $a0, menutxt
    syscall
    jr $ra

quem_ganhou:
    lw $t2, votos_carlos
    lw $t3, votos_pedro
    lw $t4, votos_zulmira
    bgt $t2, $t3, carlos_ganhou
    bgt $t3, $t4, pedro_ganhou
    j zulmira_ganhou

carlos_ganhou:
    li $v0, 4
    la $a0, carlos_ganhotxt
    syscall
    j fim

pedro_ganhou:
    li $v0, 4
    la $a0, pedro_ganhotxt
    syscall
    j fim

zulmira_ganhou:
    li $v0, 4
    la $a0, zulmira_ganhotxt
    syscall
    j fim

finalizar:
    li $v0, 4
    la $a0, finalizartxt
    syscall
    li $v0, 4
    la $a0, carlostxt
    syscall
    li $v0, 1
    lw $a0, votos_carlos
    syscall
    li $v0, 4
    la $a0, pedrotxt
    syscall
    li $v0, 1
    lw $a0, votos_pedro
    syscall
    li $v0, 4
    la $a0, zulmiratxt
    syscall
    li $v0, 1
    lw $a0, votos_zulmira
    syscall
    jal quem_ganhou
    j fim

fim:
    li $v0, 10
    syscall
