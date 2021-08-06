.data
blank : .asciiz " "
_1sc : .asciiz "Please Input 16 numbers:\n"
_2sc : .asciiz "Array A:\n"
_3sc : .asciiz "\n"
_4sc : .asciiz "Array B:\n"
_5sc : .asciiz "\n"
.text
__init:
	lui $sp, 0x8000
	addi $sp, $sp, 0x0000
	move $fp, $sp
	add $gp, $gp, 0x8000
	jal main
	li $v0, 10
	syscall
Mars_PrintInt:
	li $v0, 1
	syscall
	li $v0, 4
	move $v1, $a0
	la $a0, blank
	syscall
	move $a0, $v1
	jr $ra
Mars_GetInt:
	li $v0, 5
	syscall
	jr $ra
Mars_PrintStr:
	li $v0, 4
	syscall
	jr $ra
array4_4:
	subu $sp, $sp, 256
	la $24, _1sc
	move $4, $24
	sw $ra, 252($sp)
	jal Mars_PrintStr
	lw $ra, 252($sp)
	li $8, 0
	sw $8, 120($sp)
IterationCheckL0:
	lw $8, 112($sp)
	lw $9, 120($sp)
	li $25, 4
	blt $9, $25, _tmplabel_1
	li $8, 0
	b _tmplabel_3
_tmplabel_1:
	li $8, 1
_tmplabel_3:
	sw $8, 112($sp)
	sw $9, 120($sp)
	lw $8, 112($sp)
	li $25, 0
	beq $8, $25, IterationEndL1
	li $9, 0
	sw $8, 112($sp)
	sw $9, 116($sp)
IterationCheckL3:
	lw $8, 104($sp)
	lw $9, 116($sp)
	li $25, 4
	blt $9, $25, _tmplabel_5
	li $8, 0
	b _tmplabel_7
_tmplabel_5:
	li $8, 1
_tmplabel_7:
	sw $8, 104($sp)
	sw $9, 116($sp)
	lw $8, 104($sp)
	li $25, 0
	beq $8, $25, IterationEndL4
	li $9, 0
	lw $10, 100($sp)
	lw $11, 120($sp)
	li $25, 4
	mul $10, $11, $25
	add $9, $9, $10
	lw $12, 116($sp)
	add $9, $9, $12
	lw $13, 92($sp)
	move $25, $9
	li $24, 4
	mul $25 , $25 , $24
	sub $24, $sp, $25
	addi $24, $24 , 248
	lw $25, ($24)
	move $13, $25
	sw $8, 104($sp)
	sw $9, 96($sp)
	sw $10, 100($sp)
	sw $11, 120($sp)
	sw $12, 116($sp)
	sw $13, 92($sp)
	sw $ra, 252($sp)
	jal Mars_GetInt
	lw $ra, 252($sp)
	move $8, $v0
	move $9, $8
	lw $10, 96($sp)
	move $25, $10
	li $24, 4
	mul $25 , $25 , $24
	sub $24, $sp, $25
	addi $24, $24 , 248
	sw $9, ($24)
	lw $11, 84($sp)
	li $24, 3
	lw $12, 116($sp)
	sub $11, $24, $12
	li $13, 0
	lw $14, 80($sp)
	li $25, 4
	mul $14, $11, $25
	add $13, $13, $14
	lw $15, 120($sp)
	add $13, $13, $15
	sw $8, 88($sp)
	lw $8, 72($sp)
	move $25, $13
	li $24, 4
	mul $25 , $25 , $24
	sub $24, $sp, $25
	addi $24, $24 , 184
	lw $25, ($24)
	move $8, $25
	sw $9, 92($sp)
	li $9, 0
	sw $10, 96($sp)
	lw $10, 68($sp)
	li $25, 4
	mul $10, $15, $25
	add $9, $9, $10
	add $9, $9, $12
	sw $11, 84($sp)
	lw $11, 60($sp)
	move $25, $9
	li $24, 4
	mul $25 , $25 , $24
	sub $24, $sp, $25
	addi $24, $24 , 248
	lw $25, ($24)
	move $11, $25
	move $8, $11
	move $25, $13
	li $24, 4
	mul $25 , $25 , $24
	sub $24, $sp, $25
	addi $24, $24 , 184
	sw $8, ($24)
	sw $8, 72($sp)
	sw $9, 64($sp)
	sw $10, 68($sp)
	sw $11, 60($sp)
	sw $12, 116($sp)
	sw $13, 76($sp)
	sw $14, 80($sp)
	sw $15, 120($sp)
IterationNextL5:
	lw $9, 116($sp)
	move $8, $9
	addi $9, $9, 1
	sw $8, 56($sp)
	sw $9, 116($sp)
	j IterationCheckL3
IterationEndL4:
IterationNextL2:
	lw $9, 120($sp)
	move $8, $9
	addi $9, $9, 1
	sw $8, 108($sp)
	sw $9, 120($sp)
	j IterationCheckL0
IterationEndL1:
	la $24, _2sc
	move $4, $24
	sw $ra, 252($sp)
	jal Mars_PrintStr
	lw $ra, 252($sp)
	li $8, 0
	sw $8, 120($sp)
IterationCheckL6:
	lw $8, 52($sp)
	lw $9, 120($sp)
	li $25, 4
	blt $9, $25, _tmplabel_9
	li $8, 0
	b _tmplabel_11
_tmplabel_9:
	li $8, 1
_tmplabel_11:
	sw $8, 52($sp)
	sw $9, 120($sp)
	lw $8, 52($sp)
	li $25, 0
	beq $8, $25, IterationEndL7
	li $9, 0
	sw $8, 52($sp)
	sw $9, 116($sp)
IterationCheckL9:
	lw $8, 44($sp)
	lw $9, 116($sp)
	li $25, 4
	blt $9, $25, _tmplabel_13
	li $8, 0
	b _tmplabel_15
_tmplabel_13:
	li $8, 1
_tmplabel_15:
	sw $8, 44($sp)
	sw $9, 116($sp)
	lw $8, 44($sp)
	li $25, 0
	beq $8, $25, IterationEndL10
	li $9, 0
	lw $10, 40($sp)
	lw $11, 120($sp)
	li $25, 4
	mul $10, $11, $25
	add $9, $9, $10
	lw $12, 116($sp)
	add $9, $9, $12
	lw $13, 32($sp)
	move $25, $9
	li $24, 4
	mul $25 , $25 , $24
	sub $24, $sp, $25
	addi $24, $24 , 248
	lw $25, ($24)
	move $13, $25
	sw $8, 44($sp)
	sw $9, 36($sp)
	sw $10, 40($sp)
	sw $11, 120($sp)
	sw $12, 116($sp)
	sw $13, 32($sp)
	lw $8, 32($sp)
	move $4, $8
	sw $ra, 252($sp)
	jal Mars_PrintInt
	lw $ra, 252($sp)
	sw $8, 32($sp)
IterationNextL11:
	lw $9, 116($sp)
	move $8, $9
	addi $9, $9, 1
	sw $8, 28($sp)
	sw $9, 116($sp)
	j IterationCheckL9
IterationEndL10:
	la $24, _3sc
	move $4, $24
	sw $ra, 252($sp)
	jal Mars_PrintStr
	lw $ra, 252($sp)
IterationNextL8:
	lw $9, 120($sp)
	move $8, $9
	addi $9, $9, 1
	sw $8, 48($sp)
	sw $9, 120($sp)
	j IterationCheckL6
IterationEndL7:
	la $24, _4sc
	move $4, $24
	sw $ra, 252($sp)
	jal Mars_PrintStr
	lw $ra, 252($sp)
	li $8, 0
	sw $8, 120($sp)
IterationCheckL12:
	lw $8, 24($sp)
	lw $9, 120($sp)
	li $25, 4
	blt $9, $25, _tmplabel_17
	li $8, 0
	b _tmplabel_19
_tmplabel_17:
	li $8, 1
_tmplabel_19:
	sw $8, 24($sp)
	sw $9, 120($sp)
	lw $8, 24($sp)
	li $25, 0
	beq $8, $25, IterationEndL13
	li $9, 0
	sw $8, 24($sp)
	sw $9, 116($sp)
IterationCheckL15:
	lw $8, 16($sp)
	lw $9, 116($sp)
	li $25, 4
	blt $9, $25, _tmplabel_21
	li $8, 0
	b _tmplabel_23
_tmplabel_21:
	li $8, 1
_tmplabel_23:
	sw $8, 16($sp)
	sw $9, 116($sp)
	lw $8, 16($sp)
	li $25, 0
	beq $8, $25, IterationEndL16
	li $9, 0
	lw $10, 12($sp)
	lw $11, 120($sp)
	li $25, 4
	mul $10, $11, $25
	add $9, $9, $10
	lw $12, 116($sp)
	add $9, $9, $12
	lw $13, 4($sp)
	move $25, $9
	li $24, 4
	mul $25 , $25 , $24
	sub $24, $sp, $25
	addi $24, $24 , 184
	lw $25, ($24)
	move $13, $25
	sw $8, 16($sp)
	sw $9, 8($sp)
	sw $10, 12($sp)
	sw $11, 120($sp)
	sw $12, 116($sp)
	sw $13, 4($sp)
	lw $8, 4($sp)
	move $4, $8
	sw $ra, 252($sp)
	jal Mars_PrintInt
	lw $ra, 252($sp)
	sw $8, 4($sp)
IterationNextL17:
	lw $9, 116($sp)
	move $8, $9
	addi $9, $9, 1
	sw $8, 0($sp)
	sw $9, 116($sp)
	j IterationCheckL15
IterationEndL16:
	la $24, _5sc
	move $4, $24
	sw $ra, 252($sp)
	jal Mars_PrintStr
	lw $ra, 252($sp)
IterationNextL14:
	lw $9, 120($sp)
	move $8, $9
	addi $9, $9, 1
	sw $8, 20($sp)
	sw $9, 120($sp)
	j IterationCheckL12
IterationEndL13:
	addu $sp, $sp, 256
	jr $ra
main:
	subu $sp, $sp, 4
	sw $ra, 0($sp)
	jal array4_4
	lw $ra, 0($sp)
	li $v0, 0
	addu $sp, $sp, 4
	jr $ra
