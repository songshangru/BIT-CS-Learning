    .org 0x0
    .set noat
    .set noreorder
    .set nomacro
    .global _start
_start:
	lui $v0,0xbfc1
	addiu $v0,$v0,0x0000
	
	addi $t0,$t0,0x0005
	addiu $t1,$t1,0x0006
	add $t2,$t1,$t0 #B
	addu $t3,$t0,$t2 #10
	
	ori $t4,$t4,0x0007
	andi $t0,$t0,0x0004 # =4
	
	sub $t5,$t1,$t0 # =2
	subu $t6,$t3,$t2 # =5
	
	and $t7,$t2,$t5 # =2
	or $t8,$t2,$t3 # =1B
	nor $t9,$t0,$t5 # =fff9
	xor $t0,$t5,$t6 # =7
	sw $t1,0x0($v0)
	lw $t3,0x0($v0) # =6
	
	j loop
	addi $t4,$t4,0x0001
loop:	
	addi $t0,$t0,0x0001
	j loop
	addi $t5,$t5,0x0001
