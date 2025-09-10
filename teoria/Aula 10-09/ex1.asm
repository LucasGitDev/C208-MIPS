# FUNÇÕES NO MIPS
# INSTRUÇÃO JAL (JUMP AND LINK)
# DESVIA PARA UMA LABEL E SALVA O ENDEREÇO DE
# RETORNO NO REGISTRADO $ra (RETURN ADDRESS)
# INSTRUÇÃO JR (JUMP REGISTER)
# DESVIA, INCONDICIONALMENTE, PARA O ENDEREÇO
# DE UM DADO REGISTRADOR
# EXEMPLO: CALCULO DA MÉDIA

.text
li $t1, 0x10 # Carrega 0x10 em $t1
li $t2, 0x20 # Carrega 0x20 em $t2
jal media # Salta para "media" e salva o endereço de retorno em $ra
jal potencia # Salta para "potencia" e salva o endereço de retorno em $ra
j fim

media:
    add $t3, $t1, $t2
    div $t4, $t3, 2
    jr $ra

potencia:
    mul $t5, $t1, $t1
    jr $ra

fim: