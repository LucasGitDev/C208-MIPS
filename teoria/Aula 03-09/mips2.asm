# criar um while
# x = 30 ($t1)
# i = 20 ($t2)
# while i>=0:
# i+=1;
# x-=2;

.text

li $t1, 30 # x = 30
li $t2, 20 # i = 20

while:
    blez $t2, fim # branch if less than or equal to zero (if i <= 0)
    addi $t2, $t2, -1
    subi $t1, $t1, 2
    j while
    
fim:
li $v0, 1
move $a0, $t1
syscall
