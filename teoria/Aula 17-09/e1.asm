
.data
    frase: .asciiz "Digite o valor em graus Celsius: "
    frase2: .asciiz "O valor em graus Fahrenheit é: "
    frase3: .asciiz "O valor em graus Kelvin é: "

.text

# Entrada de dados
li $v0, 4
la $a0, frase
syscall

# Alocar C no registrador $t1
li $v0, 5
syscall
add $t1, $0, $v0 # Celsius

addi $t2, $t1, 273 # Kelvin = Celsius + 273

mul $t3, $t1, 9 # 9 * Celsius
div $t3, $t3, 5 # 9 * Celsius / 5
mflo $t3 # Move o quociente para $t3
add $t3, $t3, 32 # 9 * Celsius / 5 + 32 => Fahrenheit

# Saída de dados
li $v0, 4
la $a0, frase2
syscall

li $v0, 1
move $a0, $t3
syscall

li $v0, 4
la $a0, frase3
syscall

li $v0, 1
move $a0, $t2
syscall


j fim

fim:
    li $v0, 10
    syscall