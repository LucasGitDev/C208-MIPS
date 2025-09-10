.data
    frase: .asciiz "Hello, World!"

.text

# PRINT INT
li $v0, 1 # Carrega o serviço de print int ($v0)
li $a0, 10 # Carrega o valor a ser printado ($a0)
syscall

# PRINT STRING
li $v0, 4 # Carrega o serviço de print string ($v0)
la $a0, frase # Carrega o endereço da string ($a0)
syscall

# READ INT
li $v0, 5 # Carrega o serviço de read int ($v0)
syscall
add $t6, $0, $v0 # Soma o valor lido para $t6
