# ESCREVA UM CÓDIGO EM ASSEMBLY MIPS
# QUE LEIA 2 NÚMEROS E DIGA QUAL DELES
# É O MAIOR (O PRIMEIRO OU O SEGUNDO)
# --- JEITO DO PROFESSOR
.data
    f1: .asciiz "Digite o primeiro numero: \n"
    f2: .asciiz "Digite o segundo numero: \n"
    f3: .asciiz "O Primeiro é maior\n"
    f4: .asciiz "O Segundo é maior\n"


.text

# Entrada de dados do primeiro valor
li $v0, 4 # Carrega o serviço de print string ($v0)
la $a0, f1 # Carrega o endereço da string ($a0)
syscall
li $v0, 5 # Carrega o serviço de read int ($v0)
syscall
add $t1, $0, $v0 # Soma o valor lido para $t1

# Entrada de dados do segundo valor
li $v0, 4 # Carrega o serviço de print string ($v0)
la $a0, f2 # Carrega o endereço da string ($a0)
syscall
li $v0, 5 # Carrega o serviço de read int ($v0)
syscall
add $t2, $0, $v0 # Soma o valor lido para $t2

## NÃO CONSEGUI LER TUDO....



# --- MEU JEITO
# .data
#     frase1: .asciiz "Digite o primeiro numero: \n"
#     frase2: .asciiz "Digite o segundo numero: \n"
#     frase3: .asciiz "O maior numero é: \n"

# .text

# li $t1, 0
# li $t2, 0

# j perguntar1
# j fim

# perguntar1:
#     li $v0, 4 # Carrega o serviço de print string ($v0)
#     la $a0, frase1 # Carrega o endereço da string ($a0)
#     syscall
#     li $v0, 5 # Carrega o serviço de read int ($v0)
#     syscall
#     add $t1, $0, $v0 # Soma o valor lido para $t1
#     j perguntar2

# perguntar2:
#     li $v0, 4 # Carrega o serviço de print string ($v0)
#     la $a0, frase2 # Carrega o endereço da string ($a0)
#     syscall
#     li $v0, 5 # Carrega o serviço de read int ($v0)
#     syscall
#     add $t2, $0, $v0 # Soma o valor lido para $t2
#     j comparar

# comparar:
#     bgt $t1, $t2, maior
#     j menor

# maior:
#     li $v0, 4 # Carrega o serviço de print string ($v0)
#     la $a0, frase3 # Carrega o endereço da string ($a0)
#     syscall
#     li $v0, 1 # Carrega o serviço de print int ($v0)
#     move $a0, $t1 # Move o valor de $t1 para $a0
#     syscall
#     j fim

# menor: 
#     li $v0, 4 # Carrega o serviço de print string ($v0)
#     la $a0, frase3 # Carrega o endereço da string ($a0)
#     syscall
#     li $v0, 1 # Carrega o serviço de print int ($v0)
#     move $a0, $t2 # Move o valor de $t2 para $a0
#     syscall
#     j fim

# fim:
#     li $v0, 10 # Carrega o serviço de exit ($v0)
#     syscall

# fim2:
#     li $v0, 10 # Carrega o serviço de exit ($v0)
#     syscall

