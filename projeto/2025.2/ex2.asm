S1: .word 20, 12, 8, 16, 18, 20
S2: .word 11, 3, 12, 17, 15, 19
S3: .word 9, 8, 7, 14, 18, 22

medias: .word 0, 0, 0, 0, 0, 0
status: .word 0, 0, 0, 0, 0, 0

msg_posicao: .asciiz "\nPosicao "
msg_sensores: .asciiz " - Sensores: S1="
msg_media: .asciiz " | Media="
msg_status: .asciiz " | Status="
msg_baixo: .asciiz "Baixo"
msg_normal: .asciiz "Normal"
msg_alto: .asciiz "Alto"
msg_dois_pontos: .asciiz ": "
msg_virgula: .asciiz ", S2="
msg_virgula2: .asciiz ", S3="

main:
    li $t0, 0
    li $t1, 6
    la $t2, S1
    la $t3, S2
    la $t4, S3
    la $t5, medias
    la $t6, status
    
loop:
    bge $t0, $t1, fim
    
    sll $t7, $t0, 2
    add $t8, $t2, $t7
    add $t9, $t3, $t7
    add $s0, $t4, $t7
    
    lw $s1, 0($t8)
    lw $s2, 0($t9)
    lw $s3, 0($s0)
    
    li $v0, 4
    la $a0, msg_posicao
    syscall
    li $v0, 1
    move $a0, $t0
    syscall
    li $v0, 4
    la $a0, msg_dois_pontos
    syscall
    
    li $v0, 4
    la $a0, msg_sensores
    syscall
    li $v0, 1
    move $a0, $s1
    syscall
    li $v0, 4
    la $a0, msg_virgula
    syscall
    li $v0, 1
    move $a0, $s2
    syscall
    li $v0, 4
    la $a0, msg_virgula2
    syscall
    li $v0, 1
    move $a0, $s3
    syscall
    
    add $s4, $s1, $s2
    add $s4, $s4, $s3
    li $s5, 3
    div $s4, $s5
    mflo $s6
    
    add $s7, $t5, $t7
    sw $s6, 0($s7)
    
    li $v0, 4
    la $a0, msg_media
    syscall
    li $v0, 1
    move $a0, $s6
    syscall
    
    li $s7, 10
    li $s5, 15
    
    blt $s6, $s7, status_baixo
    blt $s6, $s5, status_normal
    
    li $s7, 2
    j armazena_status
    
status_baixo:
    li $s7, 0
    j armazena_status
    
status_normal:
    li $s7, 1
    j armazena_status
    
armazena_status:
    add $s5, $t6, $t7
    sw $s7, 0($s5)
    
    li $v0, 4
    la $a0, msg_status
    syscall
    beq $s7, 0, print_baixo
    beq $s7, 1, print_normal
    beq $s7, 2, print_alto
    
print_baixo:
    li $v0, 4
    la $a0, msg_baixo
    syscall
    j continua_loop
    
print_normal:
    li $v0, 4
    la $a0, msg_normal
    syscall
    j continua_loop
    
print_alto:
    li $v0, 4
    la $a0, msg_alto
    syscall
    j continua_loop
    
continua_loop:
    addi $t0, $t0, 1
    j loop
    
fim:
    li $v0, 10
    syscall
