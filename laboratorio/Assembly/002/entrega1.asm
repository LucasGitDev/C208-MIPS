.data
    frase: .asciiz "Hello, World!\n"

.text

li $v0, 4
la $a0, frase
syscall

li $v0, 10
syscall