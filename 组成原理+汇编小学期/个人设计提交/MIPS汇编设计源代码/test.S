    .org 0x0
    .set noat
    .set noreorder
    .set nomacro
    .global _start
    
_start:
    addi $t1, $t1, -100
    addiu $t2, $t2, 100
    add $t3, $t1, $t1
    addu $t4, $t2, $t2
    lui $t5, 0x0000
    sw $t4, ($t5)
    lw $t6, ($t5)
    beq $t4, $t6, loop
    addi $t1, $t1, 100

loop:
    addi $t2, $t2, 1
    j loop
    addi $t1, $t1, 100
    
    
