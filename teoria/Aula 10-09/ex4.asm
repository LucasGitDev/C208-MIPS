# ESCREVA UM CÓDIGO EM ASSEMBLY MIPS
# QUE LEIA UM NUMERO INTEIRO E POSITIVO
# E DIGA SE O MESMO É PAR OU IMPAR

.data
    frase: .asciiz "Digite um numero inteiro positivo: \n"
    par: .asciiz "O numero é par\n"
    impar: .asciiz "O numero é impar\n"

.text

li $v0, 4
la $a0, frase
syscall
li $v0, 5
syscall
add $t1, $0, $v0

rem $t2, $t1, 2

beq $t2, 0, par
j impar

par:
    li $v0, 4
    la $a0, par
    syscall
    j fim
impar:
    li $v0, 4
    la $a0, impar
    syscall
    j fim


fim:
    li $v0, 10
    syscall