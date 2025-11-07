.data 
num1: .word 10		# Declara uma variável num1 com valor 10
num2: .word 20		# Declara uma variável num2 com valor 20

.text
la $t0,num1		# Carrega o endereço de num1 no registrador $t0
li $t1,3		# Carrega o valor 3 no registrador $t1 (contador do loop)

loop:
	lw $t3,0($t0)	# Carrega o valor do endereço $t0+0 (primeiro número) em $t3
	lw $t4,4($t0)	# Carrega o valor do endereço $t0+4 (segundo número) em $t4
	add $t2,$t3,$t4	# Soma $t3 + $t4 e armazena o resultado em $t2
	sw $t2,8($t0)	# Armazena o resultado da soma no endereço $t0+8
	addi $t0,$t0,4	# Incrementa $t0 em 4 bytes (próximo endereço)
	subi $t1,$t1,1	# Decrementa o contador $t1 em 1
	bgtz $t1,loop	# Se $t1 > 0, volta para o label 'loop'

/*
O código implementa uma sequência de Fibonacci modificada, 
onde cada novo número é a soma dos dois números anteriores, 
mas começando com os valores 10 e 20 em vez de 1 e 1.
*/
