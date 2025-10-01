.data
    msg_entrada: .asciiz "Digite sua idade: "
    msg_saida: .asciiz "Você não pode votar\n"

.text

main:
    li $t0, 15
    blt $t0, 16, menor_de_idade
    blt $t0, 18, nao_obrigado
    blt $t0, 65, obrigado
    j nao_obrigado

menor_de_idade:
    li $v0, 4
    la $a0, msg_saida
    syscall
    j fim
