addiu $t0, $0, 1
addiu $t1, $0, -5
addiu $t2, $0, 6


addu  $t3, $t1, $0       
bgez  $t3, abs_done       
subu  $t3, $0, $t3    
abs_done:


addu  $t4, $0, $0    
addu  $t5, $t3, $0   
mult_b_b_loop:
    blez  $t5, mult_b_b_done
    addu  $t4, $t4, $t3     
    addiu $t5, $t5, -1     
    j     mult_b_b_loop
mult_b_b_done:

sll $t6, $t0, 2    

addu  $t7, $0, $0   
addu  $t5, $t2,   $0    
mult_4a_c_loop:
    blez  $t5, mult_4a_c_done
    addu  $t7, $t7, $t6     
    addiu $t5, $t5, -1
    j     mult_4a_c_loop
mult_4a_c_done:            

subu $t9, $t4, $t7  

subu $t1, $0, $t1       

addu $t9, $0, $t9        # Desnecessário

addu $t0, $t0, $t0  

addu $t7, $t1, $t9   
subu $t8, $t1, $t9   


addu $s0, $0, $0        
addu $t5, $t7, $0  
    
div2_x1_loop:
    blez  $t5, div2_x1_done
    subu $t5, $t5, $t0 
    addiu $s0, $s0, 1    
    j     div2_x1_loop
div2_x1_done:  

addu $s1, $0, $0         
addu $t5, $t8, $0 
    
div2_x2_loop:
    blez  $t5, div2_x2_done
    subu $t5, $t5, $t0  
    addiu $s1, $s1, 1    
    j     div2_x2_loop
div2_x2_done:  

addiu $t0, $0, 0x000000
    sw   $s0, 0($t0)        
    sw   $s1, 4($t0)       


# Ao final, teremos:
# Endereço 0x00000090: 0x00000003 ($s0 = 3)
# Endereço 0x00000094: 0x00000002 ($s1 = 2)
